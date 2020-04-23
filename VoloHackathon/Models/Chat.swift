//
//  Chat.swift
//  VoloHackathon
//
//  Created by Eric Davenport on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

struct Chat {

    var users: [String]
    var id: String

    var dictionary: [String: Any] {
        return ["users": users]
    }
}

extension Chat {
    

    init?(dictionary: [String: Any]) {
        guard let chatUsers = dictionary["users"] as? [String],
      let id = dictionary["id"] as? String else { return nil }
      self.init(users: chatUsers, id: id)
    }

}

