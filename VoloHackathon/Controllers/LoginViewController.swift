//
//  LoginViewController.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountState {
    case existingUser
    case newUser
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var volunteerButton: UIButton!
    @IBOutlet weak var lookingButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var accountState: AccountState = .existingUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        configureButtonUI()
    }
    

    private func configureButtonUI() {
        
        volunteerButton.layer.cornerRadius = 10
        volunteerButton.layer.borderWidth = 0.8
        volunteerButton.layer.borderColor = UIColor.white.cgColor
        lookingButton.layer.cornerRadius = 10
        lookingButton.layer.borderWidth = 0.8
        lookingButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func volunterrButtonPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            return
        }
    }
    
    @IBAction func lookingButtonPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            return
        }
    }
    
    private func navigateToUserView() {
        
    }
    
    private func navigateToPostView() {
        
    }
    
}
