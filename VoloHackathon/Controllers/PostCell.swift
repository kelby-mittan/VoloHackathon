//
//  PostingCell.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Kingfisher

class PostCell: UICollectionViewCell {
    
    public lazy var postImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        iv.image =  UIImage(named: "noimage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    public lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .bold)
        label.text = "Short Description"
        return label
    }()
    
    public lazy var orgNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        label.text = "Organization Name"
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var verifiedSymbol: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "verified")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        label.text = "Date"
        return label
    }()
    
    public lazy var calendarSymbol: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "calendar")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
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
        setUpPostImageConstraints()
        setupShortDescriptionConstraints()
        setupVerifiedImageConstraints()
        setUpOrganizationNameLabel()
        setUpCalendarSymbolconstraints()
        setUpDateLabelConstraints()
    }
    
    
    private func setUpPostImageConstraints() {
        addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: topAnchor),
            postImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55)
        ])
    }
    
    private func setupShortDescriptionConstraints() {
        addSubview(shortDescriptionLabel)
        shortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shortDescriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            shortDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shortDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupVerifiedImageConstraints() {
        addSubview(verifiedSymbol)
        verifiedSymbol.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verifiedSymbol.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            verifiedSymbol.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor, constant: 8),
            verifiedSymbol.heightAnchor.constraint(equalToConstant: 20),
            verifiedSymbol.widthAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    
    
    private func setUpOrganizationNameLabel() {
        addSubview(orgNameLabel)
        orgNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            orgNameLabel.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor, constant: 8),
            orgNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            orgNameLabel.trailingAnchor.constraint(equalTo: verifiedSymbol.leadingAnchor, constant: -8)
        ])
    }
    
    
    private func setUpCalendarSymbolconstraints() {
        
        addSubview(calendarSymbol)
        calendarSymbol.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarSymbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            calendarSymbol.topAnchor.constraint(equalTo: orgNameLabel.bottomAnchor, constant: 8),
            calendarSymbol.heightAnchor.constraint(equalToConstant: 20),
            calendarSymbol.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setUpDateLabelConstraints() {
        
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: orgNameLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: calendarSymbol.trailingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    
    
    public func configureCell(_ post: Post) {
        
        shortDescriptionLabel.text = post.shortDescription
        dateLabel.text = "Start Date: \(post.startDate)"
        postImage.kf.setImage(with: URL(string: post.imageURL))
        
        let orgId = post.orgId
        
          DatabaseService.shared.fetchUserInfo(userId: orgId) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("\(error) getting org info")
            case .success(let org):
                self?.orgNameLabel.text = org.first?.name
            }
        }
        
    }
    
}
