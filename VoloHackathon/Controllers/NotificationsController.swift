//
//  NotificationsController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import FirebaseAuth

class NotificationsController: UIViewController {

  private var nfView = NotificationView()

  override func loadView() {
    view = nfView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Notifications"
    tableViewSetup()
    loadChats()
    print("Notif tab")
    if self.chats.isEmpty {
      self.nfView.tableView.backgroundView = EmptyView(title: "No chats", message: "When an organization reaches out. It will appear up here", imageName: "exclamationmark.bubble")
    }
  }
  
  private var chats = [Chat]() {
    didSet {
      DispatchQueue.main.async {
        if self.chats.isEmpty {
          self.nfView.tableView.backgroundView = EmptyView(title: "No chats", message: "When an organization reaches out. It will show up here", imageName: "exclamationmark.bubble")
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
    guard let user = Auth.auth().currentUser else { return }
    DatabaseService.shared.chatsAvailable(userID: user.uid) { (result) in
      switch result {
      case .failure(let error):
        print("Error: \(error)")
      case .success(let chats):
        self.chats = chats
        print("Chats found")
      }
    }
  }



}

extension NotificationsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chats.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as? NotificationCell else {
      fatalError("unable to downcast NotificationCell")
    }
    cell.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    
    return cell
  }
}

extension NotificationsController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
