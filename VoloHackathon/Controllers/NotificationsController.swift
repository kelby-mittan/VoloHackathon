//
//  NotificationsController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController {
  
  private var nfView = NotificationView()
  
  override func loadView() {
    view = nfView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Notifications"
    tableViewSetup()
  }
  
  private func tableViewSetup() {
    nfView.tableView.dataSource = self
    nfView.tableView.delegate = self
    nfView.tableView.register(NotificationCell.self, forCellReuseIdentifier: "notificationCell")
  }
  
  
  
}

extension NotificationsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as? NotificationCell else {
      fatalError("unab le to downcast NotificationCell")
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
