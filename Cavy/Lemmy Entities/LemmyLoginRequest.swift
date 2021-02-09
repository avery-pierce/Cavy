//
//  LemmyLoginRequest.swift
//  Cavy
//
//  Created by Avery Pierce on 2/9/21.
//

import Foundation

struct LemmyLoginRequest: Codable {
    var username_or_email: String
    var password: String
    
    init(usernameOrEmail: String, password: String) {
        self.username_or_email = usernameOrEmail
        self.password = password
    }
}
