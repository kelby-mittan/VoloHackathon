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
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var accountState: AccountState = .existingUser
    private var authentication = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
    
    @IBAction func signInButtonPresser() {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
                    errorLabel.text = "Both textfields must be filled!"
                    errorLabel.textColor = .systemRed
                    return
                }
        continueLoginFlow(email: username, password: password)
    }
    
    private func navigateToUserView() {
        UIViewController.showViewController(storyBoardName: "Volunteer", viewControllerId: "VolunteerTabBarController")
    }
    
    private func continueLoginFlow(email: String, password: String) {
        
        if accountState == .existingUser {
            authentication.signExistingUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorLabel.text = "\(error)"
                        self?.errorLabel.textColor = .systemRed
                    }
                case .success(_):
                    self?.navigateToUserView()
                }
            }
        } else {
            errorLabel.text = "User does not exist. Create a new user or enter valid information."
        }
    }
}
