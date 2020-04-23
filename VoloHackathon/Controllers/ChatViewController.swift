//
//  ChatViewController.swift
//  VoloHackathon
//
//  Created by Eric Davenport on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Firebase
import FirebaseFirestore

class ChatViewController: MessagesViewController {
  
  //  @IBOutlet weak var messagesCollectionView: MessagesCollectionView!
  
  var currentUser = Auth.auth().currentUser!
  private var docReference: DocumentReference?
  var messages: [Message] = []
  
  let db = Firestore.firestore()
  
  private var listener: ListenerRegistration?

  
  var user2ID: String!
  private var newChat : Bool = false
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    print("user1ID: \(currentUser.uid ?? "no user 1")")
//    print("user2ID: \(user2ID)")
    
    self.title =  "Chat"
    navigationItem.largeTitleDisplayMode = .never
    maintainPositionOnKeyboardFrameChanged = true
    messageInputBar.inputTextView.tintColor = .orange
    messageInputBar.sendButton.setTitleColor(.orange, for: .normal)
    messageInputBar.delegate = self
    messagesCollectionView.messagesDataSource = self
    messagesCollectionView.messagesLayoutDelegate = self
    messagesCollectionView.messagesDisplayDelegate = self
    loadChat()
    
  }

  
  private func loadChat() {
    // fetch all chats with current user in it
    Firestore.firestore().collection("chats").whereField("users", arrayContains: currentUser.uid).getDocuments { (snapshot, error) in
      if let error = error {
        print("Error: \(error)")
        return
      } else if let snapshot = snapshot {
        // count the number of documents returned
        if snapshot.documents.count == 0 {
          // no chats available -> create a new instance
          DatabaseService.shared.createNewChat(user1ID: self.currentUser.uid, user2ID: self.user2ID) { (result) in
            switch result {
            case .failure(let error):
              print("error \(error)")
            case .success:
              print("check firebase")
//              self.messages = messages
            }
          }
//          self.createNewChat()
          return
        } else if snapshot.documents.count >= 1 {
          // chats have currentUser id in it
          for doc in snapshot.documents {
            if let chat = Chat(dictionary: doc.data()),
              let user2ID = self.user2ID {
            // obtain chat with second user
            if (chat.users.contains(user2ID)) {
              self.docReference = doc.reference
              self.docReference?.collection("thread").order(by: "created", descending: false).addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
                if let error = error {
                  print("Error: \(error)")
                  return
                } else {
                  self.messages.removeAll()
                  for message in snapshot!.documents {
                    let msg = Message(dictionary: message.data())
                    self.messages.append(msg!)
                    print("Data: \(msg?.content ?? "no message content found")")
                  }
                  self.messagesCollectionView.reloadData()
                  self.messagesCollectionView.scrollToBottom(animated: true)
                }
              })
              return
            }
            }
          }
          self.createNewChat()
//                    DatabaseService.shared.createNewChat(user1ID: self.currentUser.uid, user2ID: self.user2ID) { (result) in
//                      switch result {
//                      case .failure(let error):
//                        print("error \(error)")
//                      case .success:
//                        print("check firebase")
//                        self.messages = messages
//                      }
//                    }
        } else {
          print("it didnt work it this printed")
        }
      }
    }
  }
  

  func createNewChat() {
    let users = [self.currentUser.uid, self.user2ID]
    let data: [String: Any] = [ "users": users]
    db.collection("chats").addDocument(data: data) { (error) in
      if let error = error {
        print("Unable to create chat error: \(error)")
        return
      } else {
//        self.loadChat()
        return
      }
    }
  }

  
  private func insertNewMessage(_ message: Message) {
    // add the message to the message array and reload it
    messages.append(message)
    DispatchQueue.main.async {
      self.messagesCollectionView.reloadData()
      self.messagesCollectionView.scrollToBottom(animated: true)
    }
  }
  
  private func save(_ message: Message) {
    // preparing the data as per firestore collection
    let data: [String: Any] = ["content": message.content,
                               "created": message.created,
                               "id": message.id,
                               "senderID": message.senderID,
                               "senderName": message.senderName]
    
    // writing to the thread using the saved document reference we saved in load chat func
    docReference?.collection("thread").addDocument(data: data, completion: { (error) in
      if let error = error {
        print("Error sending message: \(error)")
        return
      }
      self.messagesCollectionView.scrollToBottom()
    })
  }
  
}


extension ChatViewController: InputBarAccessoryViewDelegate {
  func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
    // when user pressed send button
    let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser.uid, senderName: currentUser.displayName ?? "No name")
    // calloing func to insert and save message
    insertNewMessage(message)
    save(message)

    // clear input field
    messagesCollectionView.reloadData()
    messagesCollectionView.scrollToBottom(animated: true)
  }
  
}

extension ChatViewController: MessagesDataSource {
  func currentSender() -> SenderType {
    return Sender(senderId: currentUser.uid, displayName: currentUser.displayName ?? "No Name found")
  }
  // this returns the mesage type which is defined in Messages.swift
  func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
    return messages[indexPath.section]
  }
  
  func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
    if messages.count == 0 {
      print("NO messages")
      return 0
    } else {
      return messages.count
    }
  }
}

extension ChatViewController: MessagesLayoutDelegate {
  // default avatar size
  func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
    return .zero
  }
  
}

extension ChatViewController: MessagesDisplayDelegate {
  func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
    return isFromCurrentSender(message: message) ? #colorLiteral(red: 0.9675597548, green: 0.4630349874, blue: 0.4231805205, alpha: 1) : #colorLiteral(red: 0.9675597548, green: 0.4630349874, blue: 0.4231805205, alpha: 1)
  }
  
//  func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//    // if the current user -> show current photo
//    if message.sender.senderId == currentUser.uid {
//      SDWebImageManager.shared.loadImage(with: currentUser.photoURL, options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageURL) in
//        avatarView.image = image
//      }
//    } else {
//      SDWebImageManager.shared.loadImage(with: URL(string: user2Image!), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageURL) in
//        avatarView.image = image
//      }
//    }
//  }
  
  func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
    // styling the bubble to have a tail
    let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
    return .bubbleOutline(.green)
  }
}


