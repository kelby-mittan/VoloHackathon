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
    
    private var authentication = AuthenticationSession()
    private var userType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
    
    @IBAction func signInButtonPresser() {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Missing Fields", message: "Please fill in the required fields.")
            return
        }
        continueLoginFlow(email: username, password: password)
    }
    
    private func navigateToAppView() {
        if let user = Auth.auth().currentUser {
            DatabaseService.shared.fetchUserInfo(userId: user.uid) { (result) in
                switch result {
                case .failure(let error):
                    print("\(error) getting userInfo")
                case .success(let user):
                    DispatchQueue.main.async {
                        if user.first?.userType == "Volunteer" {
                            UIViewController.showViewController(storyBoardName: "Volunteer", viewControllerId: "VolunteerTabBarController")
                        } else if user.first?.userType == "Organization" {
                            UIViewController.showViewController(storyBoardName: "Organization", viewControllerId: "OrganizationTabBarController")
                        }
                    }
                }
            }
        }
    }
    
    private func continueLoginFlow(email: String, password: String) {
        
        authentication.signExistingUser(email: email, password: password) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print("user doesnt exist")
                    self?.showAlert(title: "Error", message: "Error logging in: \(error.localizedDescription)")
                }
            case .success(_):
                self?.navigateToAppView()
            }
        }
    }
}
