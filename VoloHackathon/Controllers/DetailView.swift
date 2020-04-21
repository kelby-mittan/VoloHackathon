//
//  DetailView.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .clear
        return scrollview
    }()
    
    public lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    public lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "noimage")
        iv.clipsToBounds = true
        iv.alpha = 1
        return iv
    }()
    
    
    public lazy var blur: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.extraLight))
        return blur
    }()
    
    public lazy var mainImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "noimage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    public lazy var largeLabel: UILabel = {
        let label = UILabel()
        label.text = "Volunteer Work"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var smallLabel1: UILabel = { // eventTime or date created date
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Orginazation Name"
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    public lazy var smallLabel2: UILabel = { // description or price range
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiatiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est labo"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    public lazy var smallLabel3: UILabel = { // link to event place produced
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Location"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    public lazy var volunteerButton: UIButton = {
        let button = UIButton()
        button.setTitle("I Want to Help!", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
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
        scrollViewContraints()
        contentViewContraints()
        backgroundImageContraints()
        blurContraints()
        ImageContraints()
        largeLabelConstraints()
        smallLabelConstraints1()
        smallLabelConstraints2()
        smallLabelConstraints3()
        volunteerButtonConstraints()
        
    }
    
    private func scrollViewContraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func contentViewContraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        // default is 1000 -> do not change but 250 allows flexibility
        
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func backgroundImageContraints() {
        
        contentView.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
    }
    
    private func blurContraints() {
        
        backgroundImage.addSubview(blur)
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            blur.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            blur.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor)
        ])
    }
    
    private func ImageContraints() {
        contentView.addSubview(mainImage)
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: backgroundImage.centerYAnchor, constant: -150),
            mainImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90),
            mainImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
    }
    
    private func largeLabelConstraints() {
        contentView.addSubview(largeLabel)
        largeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            largeLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 20),
            largeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            largeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
    private func smallLabelConstraints1() {
        contentView.addSubview(smallLabel1)
        smallLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            smallLabel1.topAnchor.constraint(equalTo: largeLabel.bottomAnchor),
            smallLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            smallLabel1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func smallLabelConstraints2() {
        contentView.addSubview(smallLabel2)
        smallLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            smallLabel2.topAnchor.constraint(equalTo: smallLabel1.bottomAnchor, constant: 20),
            smallLabel2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            smallLabel2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func smallLabelConstraints3() {
        contentView.addSubview(smallLabel3)
        smallLabel3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            smallLabel3.topAnchor.constraint(equalTo: smallLabel2.bottomAnchor, constant: 20),
            smallLabel3.leadingAnchor.constraint(equalTo: smallLabel2.leadingAnchor),
            smallLabel3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            smallLabel3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func volunteerButtonConstraints() {
        contentView.addSubview(volunteerButton)
        volunteerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            volunteerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            volunteerButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            volunteerButton.heightAnchor.constraint(equalToConstant: 44),
            volunteerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
