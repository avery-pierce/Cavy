//
//  LemmyCommunity.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation

struct LemmyCommunity: Codable, Equatable {
    let nsfw : Bool?
    let title : String?
    let numberOfSubscribers : Int?
    let actorID : String?
    let creatorLocal : Bool?
    let creatorPreferredUsername : String?
    let categoryName : String?
    let icon : String?
    let userID : String?
    let deleted : Bool?
    let hotRank : Int?
    let creatorAvatar : String?
    let updated : String?
    let name : String?
    let numberOfPosts : Int?
    let id : Int?
    let creatorName : String?
    let numberOfComments : Int?
    let subscribed : String?
    let removed : Bool?
    let banner : String?
    let local : Bool?
    let lastRefreshedAt : String?
    let creatorID : Int?
    let published : String?
    let categoryID : Int?
    let creatorActorID : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case nsfw = "nsfw"
        case title = "title"
        case numberOfSubscribers = "number_of_subscribers"
        case actorID = "actor_id"
        case creatorLocal = "creator_local"
        case creatorPreferredUsername = "creator_preferred_username"
        case categoryName = "category_name"
        case icon = "icon"
        case userID = "user_id"
        case deleted = "deleted"
        case hotRank = "hot_rank"
        case creatorAvatar = "creator_avatar"
        case updated = "updated"
        case name = "name"
        case numberOfPosts = "number_of_posts"
        case id = "id"
        case creatorName = "creator_name"
        case numberOfComments = "number_of_comments"
        case subscribed = "subscribed"
        case removed = "removed"
        case banner = "banner"
        case local = "local"
        case lastRefreshedAt = "last_refreshed_at"
        case creatorID = "creator_id"
        case published = "published"
        case categoryID = "category_id"
        case creatorActorID = "creator_actor_id"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nsfw = try values.decodeIfPresent(Bool.self, forKey: .nsfw)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        numberOfSubscribers = try values.decodeIfPresent(Int.self, forKey: .numberOfSubscribers)
        actorID = try values.decodeIfPresent(String.self, forKey: .actorID)
        creatorLocal = try values.decodeIfPresent(Bool.self, forKey: .creatorLocal)
        creatorPreferredUsername = try values.decodeIfPresent(String.self, forKey: .creatorPreferredUsername)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        userID = try values.decodeIfPresent(String.self, forKey: .userID)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        hotRank = try values.decodeIfPresent(Int.self, forKey: .hotRank)
        creatorAvatar = try values.decodeIfPresent(String.self, forKey: .creatorAvatar)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        numberOfPosts = try values.decodeIfPresent(Int.self, forKey: .numberOfPosts)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        creatorName = try values.decodeIfPresent(String.self, forKey: .creatorName)
        numberOfComments = try values.decodeIfPresent(Int.self, forKey: .numberOfComments)
        subscribed = try values.decodeIfPresent(String.self, forKey: .subscribed)
        removed = try values.decodeIfPresent(Bool.self, forKey: .removed)
        banner = try values.decodeIfPresent(String.self, forKey: .banner)
        local = try values.decodeIfPresent(Bool.self, forKey: .local)
        lastRefreshedAt = try values.decodeIfPresent(String.self, forKey: .lastRefreshedAt)
        creatorID = try values.decodeIfPresent(Int.self, forKey: .creatorID)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        categoryID = try values.decodeIfPresent(Int.self, forKey: .categoryID)
        creatorActorID = try values.decodeIfPresent(String.self, forKey: .creatorActorID)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}
