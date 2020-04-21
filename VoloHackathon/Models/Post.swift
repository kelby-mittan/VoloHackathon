//
//  Post.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: String
    let description: String
    let location: String
    let category: String
    let volunteers: [User]
    let startDate: Date
    let endDate: Date
    let status: String
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
