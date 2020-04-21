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
    @IBOutlet weak var errorLabel: UILabel!
    
    
    private var accountState: AccountState = .existingUser
    private var authentication = AuthenticationSession()
    
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
            errorLabel.text = "Both textfields must be filled!"
            errorLabel.textColor = .systemRed
            return
        }
        continueLoginFlow(email: username, password: password)
    }
    
    @IBAction func lookingButtonPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            errorLabel.text = "Both fields must be filled"
            return
        }
        continueLoginFlow(email: username, password: password)
    }
    
    private func navigateToUserView() {
        UIViewController.showViewController(storyBoardName: "Volunteer", viewControllerId: "VolunteerTabBarController")
    }
    
    private func navigateToPostView() {
        
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
            authentication.createNewUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorLabel.text = "\(error)"
                        self?.errorLabel.textColor = .systemRed
                    }
                case .success(let authDataResult):
                    DispatchQueue.main.async {
                        self?.createDatabaseUser(authDataResult: authDataResult)
                    }
                }
            }
        }
    }
    
    private func createDatabaseUser(authDataResult: AuthDataResult) {
        DatabaseService.shared.createDatabaseUser(authDataResult: authDataResult) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print("\(error)")
                }
            case .success(_):
                self?.navigateToUserView()
            }
        }
    }
}