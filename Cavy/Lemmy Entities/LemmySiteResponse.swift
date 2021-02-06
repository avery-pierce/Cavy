//
//  LemmySiteResponse.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/22/21.
//

import Foundation

struct LemmySiteResponse: Codable {
    var site: LemmySite?
    var admins: [LemmyUser]
    var banned: [LemmyUser]
    var online: Int?
    var version: String?
    var myUser: LemmyUser?
    var federatedInstances: [String]
    
    enum CodingKeys: String, CodingKey {
        case site = "site"
        case admins = "admins"
        case banned = "banned"
        case online = "online"
        case version = "version"
        case myUser = "my_user"
        case federatedInstances = "federated_instances"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        site = try values.decodeIfPresent(LemmySite.self, forKey: .site)
        admins = try values.decodeIfPresent([LemmyUser].self, forKey: .admins) ?? []
        banned = try values.decodeIfPresent([LemmyUser].self, forKey: .banned) ?? []
        online = try values.decodeIfPresent(Int.self, forKey: .online)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        myUser = try values.decodeIfPresent(LemmyUser.self, forKey: .myUser)
        federatedInstances = try values.decodeIfPresent([String].self, forKey: .federatedInstances) ?? []
    }
    
    init(site: LemmySite?, admins: [LemmyUser], banned: [LemmyUser], online: Int?, version: String?, myUser: LemmyUser?, federatedInstances: [String]) {
        self.site = site
        self.admins = admins
        self.banned = banned
        self.online = online
        self.version = version
        self.myUser = myUser
        self.federatedInstances = federatedInstances
    }
}
