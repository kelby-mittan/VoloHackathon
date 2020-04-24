//
//  User.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let userId: String
    let name: String
    let location: String
    let imageURL: String
    let userType: String
    let verified: String
    let email: String
}

extension User {
    
    init(_ dictionary: [String: Any]) {
        
        self.userId = dictionary["userId"] as? String ?? "N/A"
        self.name = dictionary["name"] as? String ?? "N/A"
        self.location = dictionary["location"] as? String ?? "N/A"
        self.imageURL = dictionary["imageURL"] as? String ?? "N/A"
        self.userType = dictionary["userType"] as? String ?? "N/A"
        self.verified = dictionary["verified"] as? String ?? "N/A"
        self.email = dictionary["email"] as? String ?? "N/A"
    }
}

/*
 User Model
 - name
 - location?
 - image
 - org/volunteer (user type)
 - id
 - collection of interested volunteer work [posting]?
 */
