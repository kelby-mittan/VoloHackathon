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
    let orgId: String
    let description: String
    let shortDescription: String
    let location: String
    let category: String
    let startDate: String
    let postDate: Timestamp
    let status: String
    let imageURL: String
    let postId: String
}

extension Post {
    
    init(_ dictionary: [String: Any]) {
        
        self.orgId = dictionary["orgId"] as? String ?? "N/A"
        self.description = dictionary["description"] as? String ?? "N/A"
        self.shortDescription = dictionary["shortDescription"] as? String ?? "N/A"
        self.location = dictionary["location"] as? String ?? "N/A"
        self.category = dictionary["category"] as? String ?? "N/A"
        self.startDate = dictionary["startDate"] as? String ?? "N/A"
        self.postDate = dictionary["postDate"] as? Timestamp ?? Timestamp(date: Date())
        self.status = dictionary["status"] as? String ?? "N/A"
        self.imageURL = dictionary["imageURL"] as? String ?? "N/A"
        self.postId = dictionary["postId"] as? String ?? "N/A"
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
