//
//  NotificationView.swift
//  VoloHackathon
//
//  Created by Eric Davenport on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class NotificationView: UIView {

  public lazy var tableView: UITableView = {
    let tb = UITableView()
//    tb.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    tb.backgroundColor = .red
    return tb
  }()

  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    tableViewConstraints()
  }
  
  private func tableViewConstraints() {
    addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }


}
