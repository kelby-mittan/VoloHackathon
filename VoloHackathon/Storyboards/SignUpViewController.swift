//
//  SignUpViewController.swift
//  VoloHackathon
//
//  Created by Brendon Cecilio on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var volunteerButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func configureButtons() {
        
        volunteerButton.layer.cornerRadius = 10
        postButton.layer.cornerRadius = 10
    }
    
    @IBAction func volunteerButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    
}
