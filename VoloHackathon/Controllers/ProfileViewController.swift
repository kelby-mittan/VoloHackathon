//
//  ProfileViewController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileView = ProfileView()
    
    public var volunteer: User?
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    

}
