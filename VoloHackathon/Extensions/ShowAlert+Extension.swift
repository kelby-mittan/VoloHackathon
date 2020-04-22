//
//  ShowAlert+Extension.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
