//
//  LemmySite.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/22/21.
//

import Foundation

struct LemmySite: Codable {
    var id: Int
    var name: String?
    var description: String?
    var creatorID: Int?
    var published: String? // Formatted Date
    var updated: String? // Formatted Date
    var enableDownvotes: Bool?
    var openRegistration: Bool?
    var enableNSFW: Bool?
    var icon: String?
    var banner: String?
    var creatorName: String?
    var creatorPreferredUsername: String?
    var creatorAvatar: String?
    var numberOfUsers: Int?
    var numberOfPosts: Int?
    var numberOfComments: Int?
    var numberOfCommunities: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case creatorID = "creator_id"
        case published = "published"
        case enableDownvotes = "enable_downvotes"
        case openRegistration = "open_registration"
        case enableNSFW = "enable_nsfw"
        case icon = "icon"
        case banner = "banner"
        case creatorName = "creator_name"
        case creatorPreferredUsername = "creator_preferred_username"
        case creatorAvatar = "creator_avatar"
        case numberOfUsers = "number_of_users"
        case numberOfPosts = "number_of_posts"
        case numberOfComments = "number_of_comments"
        case numberOfCommunities = "number_of_communities"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        creatorID = try values.decodeIfPresent(Int.self, forKey: .creatorID)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        enableDownvotes = try values.decodeIfPresent(Bool.self, forKey: .enableDownvotes)
        openRegistration = try values.decodeIfPresent(Bool.self, forKey: .openRegistration)
        enableNSFW = try values.decodeIfPresent(Bool.self, forKey: .enableNSFW)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        banner = try values.decodeIfPresent(String.self, forKey: .banner)
        creatorName = try values.decodeIfPresent(String.self, forKey: .creatorName)
        creatorPreferredUsername = try values.decodeIfPresent(String.self, forKey: .creatorPreferredUsername)
        creatorAvatar = try values.decodeIfPresent(String.self, forKey: .creatorAvatar)
        numberOfUsers = try values.decodeIfPresent(Int.self, forKey: .numberOfUsers)
        numberOfPosts = try values.decodeIfPresent(Int.self, forKey: .numberOfPosts)
        numberOfComments = try values.decodeIfPresent(Int.self, forKey: .numberOfComments)
        numberOfCommunities = try values.decodeIfPresent(Int.self, forKey: .numberOfCommunities)
    }
}
