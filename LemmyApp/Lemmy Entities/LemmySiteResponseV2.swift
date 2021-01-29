//
//  LemmySiteResponseV2.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmySiteResponseV2: Codable {
    var siteView: LemmySiteView?
    var admins: [LemmyUserView]?
    var banned: [LemmyUserView]?
    var online: Int?
    var version: String?
    
    // TODO: CodingKeys
    var myUser: LemmyUser?
    var federatedInstances: [String]?
}

struct LemmySiteView: Codable {
    var site: LemmySite?
    var creator: LemmyUser?
    var counts: LemmyCounts?
}

struct LemmyUserView: Codable {
    var user: LemmyUser?
    var counts: LemmyCounts?
}
