//
//  LemmyModerator.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import Foundation

struct LemmyModerator: Codable, Equatable {
    var id: Int
    var communityID: Int?
    var userID: Int?
    var published: String? // Date String
    var userActorID: String?
    var userLocal: Bool?
    var userName: String?
    var userPreferredUsername: String?
    var avatar: String?
    var communityActorID: String?
    var communityLocal: Bool?
    var communityName: String?
    var communityIcon: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case communityID = "community_id"
        case userID = "user_id"
        case published = "published"
        case userActorID = "user_actor_id"
        case userLocal = "user_local"
        case userName = "user_name"
        case userPreferredUsername = "user_preferred_username"
        case avatar = "avatar"
        case communityActorID = "community_actor_id"
        case communityLocal = "community_local"
        case communityName = "community_name"
        case communityIcon = "community_icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        communityID = try values.decodeIfPresent(Int.self, forKey: .communityID)
        userID = try values.decodeIfPresent(Int.self, forKey: .userID)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        userActorID = try values.decodeIfPresent(String.self, forKey: .userActorID)
        userLocal = try values.decodeIfPresent(Bool.self, forKey: .userLocal)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        userPreferredUsername = try values.decodeIfPresent(String.self, forKey: .userPreferredUsername)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        communityActorID = try values.decodeIfPresent(String.self, forKey: .communityActorID)
        communityLocal = try values.decodeIfPresent(Bool.self, forKey: .communityLocal)
        communityName = try values.decodeIfPresent(String.self, forKey: .communityName)
        communityIcon = try values.decodeIfPresent(String.self, forKey: .communityIcon)
    }
}
