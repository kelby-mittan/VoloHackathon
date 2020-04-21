//
//  User.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation

struct User: Codable {
    let userId: String
    let name: String
    let location: String
    let imageURL: String
    let userType: String
    let interests: [Post]
    let commitments: [Post]
}

extension User {
    
    init(_ dictionary: [String: Any]) {
        
        self.userId = dictionary["userId"] as? String ?? "N/A"
        self.name = dictionary["name"] as? String ?? "N/A"
        self.location = dictionary["location"] as? String ?? "N/A"
        self.imageURL = dictionary["imageURL"] as? String ?? "N/A"
        self.userType = dictionary["userType"] as? String ?? "N/A"
        self.interests = dictionary["interests"] as? [Post] ?? []
        self.commitments = dictionary["commitments"] as? [Post] ?? []
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
