//
//  CreatePostView.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class CreatePostView: UIView {
    
    public var orgIVTopAnchor: NSLayoutConstraint?

    
    public lazy var organizationIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    /*
     let description: String
     let shortDescription: String
     let location: String
     let category: String
     let startDate: Timestamp
     */
    
    public lazy var listingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
        label.text = "Title"
        return label
    }()
    
    public lazy var listingTitleTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  enter a short description for listing"
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    public lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
        label.text = "Location"
        return label
    }()
    
    public lazy var locationTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  enter location for listing"
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
        label.text = "Date"
        return label
    }()
    
    public lazy var dateTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  enter date for listing"
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    public lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
        label.text = "Select a category"
        return label
    }()
    
    public lazy var categoryPV: UIPickerView = {
        let pv = UIPickerView()
        
        return pv
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
        label.text = "Description"
        return label
    }()
    
    public lazy var descriptionTV: UITextView = {
        let tv = UITextView()
        tv.text = "  enter a detailed description of listing"
        tv.textColor = .placeholderText
        tv.layer.cornerRadius = 5
        tv.clipsToBounds = true
        return tv
    }()
    
    public lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("submit", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        return button
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
        setupImageViewConstraints()
        setupTitleLabelConstraints()
        setupTitleTFConstraints()
        setupLocationLabelConstraints()
        setupLocationTFConstraints()
        setupDateLabelConstraints()
        setupDateTFConstraints()
        setupDescriptionLabelConstraints()
        setupDescriptionTVConstraints()
        setupSubmitButtonConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(organizationIV)
        organizationIV.translatesAutoresizingMaskIntoConstraints = false
        
//        organizationIV.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            organizationIV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            organizationIV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            organizationIV.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)//,
//            organizationIV.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.27)
        ])
        
//        orgIVTopAnchor = organizationIV.topAnchor.constraint(equalTo: topAnchor)
//        orgIVTopAnchor?.isActive = true
    }
    
    private func setupTitleLabelConstraints() {
        addSubview(listingLabel)
        listingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            listingLabel.topAnchor.constraint(equalTo: organizationIV.bottomAnchor, constant: 10),
            listingLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            listingLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTitleTFConstraints() {
        addSubview(listingTitleTF)
        listingTitleTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            listingTitleTF.topAnchor.constraint(equalTo: listingLabel.bottomAnchor, constant: 5),
            listingTitleTF.leadingAnchor.constraint(equalTo: listingLabel.leadingAnchor),
            listingTitleTF.trailingAnchor.constraint(equalTo: listingLabel.trailingAnchor),
            listingTitleTF.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupLocationLabelConstraints() {
        addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: listingTitleTF.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: listingTitleTF.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: listingTitleTF.trailingAnchor)
        ])
    }
    
    private func setupLocationTFConstraints() {
        addSubview(locationTF)
        locationTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationTF.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            locationTF.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            locationTF.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),
            locationTF.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupDateLabelConstraints() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: locationTF.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: locationTF.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: locationTF.trailingAnchor)
        ])
    }
    
    private func setupDateTFConstraints() {
        addSubview(dateTF)
        dateTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateTF.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            dateTF.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            dateTF.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            dateTF.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateTF.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: dateTF.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: dateTF.trailingAnchor)
        ])
    }
    
    private func setupDescriptionTVConstraints() {
        addSubview(descriptionTV)
        descriptionTV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTV.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            descriptionTV.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            descriptionTV.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            descriptionTV.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupSubmitButtonConstraints() {
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: descriptionTV.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: descriptionTV.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 74),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
