//
//  NotificationsController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class NotificationsController: UIViewController {

  private var nfView = NotificationView()
    
    
    
    private var listOfOrgs = [User]()

  override func loadView() {
    view = nfView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Notifications"
    tableViewSetup()
    loadChats()
    createUsers()
    print("Notif tab")
//    if self.chats.isEmpty {
//      self.nfView.tableView.backgroundView = EmptyView(title: "No chats", message: "When an organization reaches out. It will appear up here", imageName: "exclamationmark.bubble")
//    }
  }
    
    private func createUsers() {
        let user1 = User(userId: "1", name: "New York Cares", location: "", imageURL: "", userType: "Organization", verified: "")
        let user2 = User(userId: "1", name: "Mount Sinai", location: "", imageURL: "", userType: "Organization", verified: "")
        listOfOrgs = [user1, user2]
        
    }
  
  private var chats = [Chat]() {
    didSet {
      DispatchQueue.main.async {
        if self.chats.isEmpty {
          self.nfView.tableView.backgroundView = EmptyView(title: "No chats", message: "When an organization reaches out. It will show up here", imageName: "exclamationmark.bubble")
        } else {
            self.nfView.tableView.reloadData()
        }
        }
    }
  }

  private func tableViewSetup() {
    nfView.tableView.dataSource = self
    nfView.tableView.delegate = self
    nfView.tableView.register(NotificationCell.self, forCellReuseIdentifier: "notificationCell")
  }
  
  private func loadChats() {
    //guard let user = Auth.auth().currentUser else { return }
    /*
     DatabaseService.shared.chatsAvailable(userID: user.uid) { (result) in
         switch result {
         case .failure(let error):
           print("Error: \(error)")
         case .success(let chats):
           self.chats = chats
           print("Chats found")
         }
       }
     */
    
    Firestore.firestore().collection("chats").getDocuments { (snapshot, error) in
        if let error = error {
            print("error getting chat thread: \(error.localizedDescription)")
        } else {
            if let snapshot = snapshot {
                let chats = snapshot.documents.compactMap { Chat(dictionary: $0.data())}
                self.chats = chats
                dump(chats)
            }
        }
    }
    
    
    
    
    }
}

extension NotificationsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listOfOrgs.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as? NotificationCell else {
      fatalError("unable to downcast NotificationCell")
    }
    let org = listOfOrgs[indexPath.row]
    cell.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    cell.nameLabel.text = org.name
    return cell 
  }
}

extension NotificationsController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatViewController(nibName: nil, bundle: nil)
        chatVC.user2ID = "PqOQEmdcs5fxxHdk4hVtr2YtFfd2"
        present(chatVC, animated: true)
    }
}
