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
    return label
  }()

  public lazy var notificationIcon: UIImageView = {
    let icon = UIImageView()
    icon.image = UIImage(systemName: "exclamationmark.circle.fill")
    icon.tintColor = .systemRed
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
//    constraintLabel()
    constraintIcon()
  }

  private func constraintLabel() {
    addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }

  private func constraintIcon() {
    addSubview(notificationIcon)
    notificationIcon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      notificationIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      notificationIcon.topAnchor.constraint(equalTo: topAnchor, constant: 40),
      notificationIcon.widthAnchor.constraint(equalToConstant: 55)
    ])
  }

}

