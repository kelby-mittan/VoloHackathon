//
//  LoginViewController.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var volunteerButton: UIButton!
    @IBOutlet weak var lookingButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
    

    private func configureButtonUI() {
        
        volunteerButton.layer.cornerRadius = 60
        volunteerButton.layer.borderWidth = 1.0
        lookingButton.layer.cornerRadius = 60
        lookingButton.layer.borderWidth = 1.0
    }
    
    @IBAction func volunterrButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func looingButtonPressed(_ sender: UIButton) {
    }
    
}
