//
//  NotificationCell.swift
//  VoloHackathon
//
//  Created by Eric Davenport on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//


import UIKit

class NotificationCell: UITableViewCell {

  public lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .white
    label.text = "Organization Name"
    return label
  }()

  public lazy var notificationIcon: UIImageView = {
    let icon = UIImageView()
    icon.image = UIImage(systemName: "exclamationmark.circle.fill")
    icon.tintColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    return icon
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    constraintLabel()
    constraintIcon()
  }

  private func constraintLabel() {
    addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }

  private func constraintIcon() {
    addSubview(notificationIcon)
    notificationIcon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      notificationIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      notificationIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
      notificationIcon.widthAnchor.constraint(equalToConstant: 30),
      notificationIcon.heightAnchor.constraint(equalTo: notificationIcon.widthAnchor)
    ])
  }

}

