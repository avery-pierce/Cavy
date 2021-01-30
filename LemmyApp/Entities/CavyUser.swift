//
//  CavyUser.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

struct CavyUser {
    var id: Int
    var name: String
    var bio: String?
}

protocol CavyUserConvertable {
    var cavyUser: CavyUser { get }
}

extension LemmyUser {
    var cavyUser: CavyUser {
        CavyUser(id: id, name: name ?? "(anonymous)", bio: bio)
    }
}

