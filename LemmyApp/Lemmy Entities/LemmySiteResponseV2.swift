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
    var myUser: LemmyUser?
    var federatedInstances: [String]?
    
    enum CodingKeys: String, CodingKey {
        case siteView = "site_view"
        case admins = "admins"
        case banned = "banned"
        case online = "online"
        case version = "version"
        case myUser = "my_user"
        case federatedInstances = "federated_instances"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        siteView = try values.decodeIfPresent(LemmySiteView.self, forKey: .siteView)
        admins = try values.decodeIfPresent([LemmyUserView].self, forKey: .admins)
        banned = try values.decodeIfPresent([LemmyUserView].self, forKey: .banned)
        online = try values.decodeIfPresent(Int.self, forKey: .online)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        myUser = try values.decodeIfPresent(LemmyUser.self, forKey: .myUser)
        federatedInstances = try values.decodeIfPresent([String].self, forKey: .federatedInstances)
    }
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
