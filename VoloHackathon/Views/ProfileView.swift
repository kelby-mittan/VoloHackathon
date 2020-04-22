//
//  ProfileView.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    public lazy var blur: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.extraLight))
        return blur
    }()
    
    public lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    public lazy var volunteerImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle")
        iv.tintColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = iv.frame.width/2
        return iv
    }()
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Volunteer Name"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    public lazy var emailLabel: UILabel = { // description or price range
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Volunteer Email"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .thin)
        return label
    }()
    
    public lazy var availablityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Volunteer Availability"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .thin)
        return label
    }()
    
    
    public lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, emailLabel, availablityLabel])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    public lazy var messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Message Volunteer", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        button.layer.cornerRadius = 5
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
        blurContraints()
        centerViewConstraints()
        volunteerImageConstraints()
        buttonStackConstraint()
        messageButtonConstraints()
    }
    
    
    private func blurContraints() {
        addSubview(blur)
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: topAnchor),
            blur.leadingAnchor.constraint(equalTo: leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func centerViewConstraints() {
        addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            centerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func volunteerImageConstraints() {
        centerView.addSubview(volunteerImage)
        volunteerImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            volunteerImage.heightAnchor.constraint(equalTo: centerView.heightAnchor, multiplier: 0.2),
            volunteerImage.widthAnchor.constraint(equalTo: volunteerImage.heightAnchor),
            volunteerImage.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 20),
            volunteerImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        ])
    }
    
    private func buttonStackConstraint() {
        centerView.addSubview(labelStack)
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStack.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -10),
            labelStack.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 10),
            labelStack.topAnchor.constraint(equalTo: volunteerImage.bottomAnchor, constant: 20),
            labelStack.heightAnchor.constraint(equalTo: centerView.heightAnchor, multiplier: 0.20)
        ])
    }
    
    private func messageButtonConstraints() {
           centerView.addSubview(messageButton)
           messageButton.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
              // messageButton.topAnchor.constraint(equalTo: smallLabel3.bottomAnchor, constant: 20),
               messageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
               messageButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
               messageButton.heightAnchor.constraint(equalToConstant: 40),
               messageButton.bottomAnchor.constraint(equalTo: centerView.bottomAnchor, constant: -20)
           ])
       }
    
    
}
