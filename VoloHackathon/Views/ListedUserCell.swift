//
//  ListedUserCell.swift
//  VoloHackathon
//
//  Created by Brendon Cecilio on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Kingfisher

class ListedUserCell: UITableViewCell {
    
    public var user: User?
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFill
        // image.layer.cornerRadius = image.
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Eric Davenport"
        return label
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
        setupImageView()
        setupNameLabel()
    }
    
    private func setupImageView() {
        addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            userImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            userImage.widthAnchor.constraint(equalTo: userImage.heightAnchor)
        ])
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        ])
    }
    
    public func configureUserCell(user: User) {
        
        nameLabel.text = user.name
        userImage.kf.setImage(with: URL(string: user.imageURL))
    }

}
