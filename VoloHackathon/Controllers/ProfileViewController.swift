//
//  ProfileViewController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
  
  private var profileView = ProfileView()
  
  public var volunteer: User?
  
  override func loadView() {
    view = profileView
  }
    
    override func viewDidLayoutSubviews() {
        profileView.volunteerImage.layer.cornerRadius = profileView.volunteerImage.frame.height/2
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profileView.messageButton.addTarget(self, action: #selector(messageButtonPressed(_:)), for: .touchUpInside)
    updateUI()
  }
  
  
  @objc func messageButtonPressed(_ sender: UIButton) {
    print("message button pressed")
    
    let chatVC = ChatViewController(nibName: nil, bundle: nil)
    chatVC.user2ID = volunteer?.userId
    present(chatVC, animated: true)
    
  }
    
    

    
    private func updateUI() {
        
    
        guard let volunteer = volunteer else {
            fatalError("no user passed")
        }
        
        profileView.nameLabel.text = volunteer.name
        profileView.emailLabel.text = volunteer.email
        
        profileView.volunteerImage.kf.setImage(with: URL(string: volunteer.imageURL))
    }
    
  
  
  
}
