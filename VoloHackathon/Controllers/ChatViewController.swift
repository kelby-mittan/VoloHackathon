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

  
  var user2ID: String?
  private var newChat : Bool = false
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("user1ID: \(currentUser.uid ?? "no user 1")")
    print("user2ID: \(user2ID)")
    
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
  
//  private func listener() {
//    listener = db.collection(DatabaseService.chats)
//  }
  
  private func loadChat2() {
    DatabaseService.shared.loadChats(user1ID: currentUser.uid, user2ID: user2ID!) { (result) in
      switch result {
      case .failure(let error):
        print("chat Error \(error)")
      case .success(let chats):
        print("chat success ")
      }
    }
  }
  
  
  private func loadChat() {
    // fetch all chats with current user in it
    let fetch = db.collection("Chats").whereField("users", arrayContains: currentUser.uid)
    fetch.getDocuments { (snapshot, error) in
      if let error = error {
        print("Error: \(error)")
        return
      } else {
        // count the number of documents returned
        guard let count = snapshot?.documents.count else {
          return
        }
        
        if count == 0 {
          // no chats available -> create a new instance
          self.createNewChat()
        } else if count >= 1 {
          // chats have currentUser id in it
          for doc in snapshot!.documents {
            let chat = Chat(dictionary: doc.data())
            // obtain chat with second user
            if (chat?.users.contains(self.user2ID!))! {
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
          self.createNewChat()
        } else {
          print("it didnt work if this printed")
        }
      }
    }
  }
  
  private func createNewChat() {
    DatabaseService.shared.createNewChat(user1ID: currentUser.uid, user2ID: user2ID!) { (result) in
      switch result {
      case .failure(let error):
        print("error: \(error)")
      case .success:
        print("success")
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
//    DatabaseService.shared.saveChatMessage(message, user1ID: currentUser.uid, user2ID: user2ID!) { (result) in
//            switch result {
//      case .failure(let error):
//        print("Error: \(error)")
//      case .success:
//        print("messages saved!! - check firebase")
//      }
//    }
    

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


