//
//  Post.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    let id: String
    let description: String
    let shortDescription: String
    let location: String
    let category: String
    let startDate: Timestamp
    let endDate: Timestamp
    let status: String
    let imageURL: String
}

extension Post {
    
    init(_ dictionary: [String: Any]) {
        
        self.id = dictionary["id"] as? String ?? "N/A"
        self.description = dictionary["description"] as? String ?? "N/A"
        self.shortDescription = dictionary["shortDescription"] as? String ?? "N/A"
        self.location = dictionary["location"] as? String ?? "N/A"
        self.category = dictionary["category"] as? String ?? "N/A"
        self.startDate = dictionary["startDate"] as? Timestamp ?? Timestamp(date: Date())
        self.endDate = dictionary["endDate"] as? Timestamp ?? Timestamp(date: Date())
        self.status = dictionary["status"] as? String ?? "N/A"
        self.imageURL = dictionary["imageURL"] as? String ?? "N/A"
    }
}

/*
 Posting Model
 - user id
 - description
 - location
 - category
 - potential volunteers
 - Start Date/Time
 - End Date
 - completion (filled/open)
 */
