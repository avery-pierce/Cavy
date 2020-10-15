//
//  LemmyComment.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import Foundation

struct LemmyComment: Codable {
    let id : Int?
    let creatorID : Int?
    let postID : Int?
    let postName : String?
    let parentID : Int?
    let content : String?
    let removed : Bool?
    let read : Bool?
    let published : String?
    let updated : String?
    let deleted : Bool?
    let apID : String?
    let local : Bool?
    let communityID : Int?
    let communityActorID : String?
    let communityLocal : Bool?
    let communityName : String?
    let communityIcon : String?
    let banned : Bool?
    let bannedFromCommunity : Bool?
    let creatorActorID : String?
    let creatorLocal : Bool?
    let creatorName : String?
    let creatorPreferredUsername : String?
    let creatorPublished : String?
    let creatorAvatar : String?
    let score : Int?
    let upvotes : Int?
    let downvotes : Int?
    let hotRank : Int?
    let hotRankActive : Int?
    let userID : String?
    let myVote : String?
    let subscribed : String?
    let saved : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case creatorID = "creator_id"
        case postID = "post_id"
        case postName = "post_name"
        case parentID = "parent_id"
        case content = "content"
        case removed = "removed"
        case read = "read"
        case published = "published"
        case updated = "updated"
        case deleted = "deleted"
        case apID = "ap_id"
        case local = "local"
        case communityID = "community_id"
        case communityActorID = "community_actor_id"
        case communityLocal = "community_local"
        case communityName = "community_name"
        case communityIcon = "community_icon"
        case banned = "banned"
        case bannedFromCommunity = "banned_from_community"
        case creatorActorID = "creator_actor_id"
        case creatorLocal = "creator_local"
        case creatorName = "creator_name"
        case creatorPreferredUsername = "creator_preferred_username"
        case creatorPublished = "creator_published"
        case creatorAvatar = "creator_avatar"
        case score = "score"
        case upvotes = "upvotes"
        case downvotes = "downvotes"
        case hotRank = "hot_rank"
        case hotRankActive = "hot_rank_active"
        case userID = "user_id"
        case myVote = "my_vote"
        case subscribed = "subscribed"
        case saved = "saved"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        creatorID = try values.decodeIfPresent(Int.self, forKey: .creatorID)
        postID = try values.decodeIfPresent(Int.self, forKey: .postID)
        postName = try values.decodeIfPresent(String.self, forKey: .postName)
        parentID = try values.decodeIfPresent(Int.self, forKey: .parentID)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        removed = try values.decodeIfPresent(Bool.self, forKey: .removed)
        read = try values.decodeIfPresent(Bool.self, forKey: .read)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        apID = try values.decodeIfPresent(String.self, forKey: .apID)
        local = try values.decodeIfPresent(Bool.self, forKey: .local)
        communityID = try values.decodeIfPresent(Int.self, forKey: .communityID)
        communityActorID = try values.decodeIfPresent(String.self, forKey: .communityActorID)
        communityLocal = try values.decodeIfPresent(Bool.self, forKey: .communityLocal)
        communityName = try values.decodeIfPresent(String.self, forKey: .communityName)
        communityIcon = try values.decodeIfPresent(String.self, forKey: .communityIcon)
        banned = try values.decodeIfPresent(Bool.self, forKey: .banned)
        bannedFromCommunity = try values.decodeIfPresent(Bool.self, forKey: .bannedFromCommunity)
        creatorActorID = try values.decodeIfPresent(String.self, forKey: .creatorActorID)
        creatorLocal = try values.decodeIfPresent(Bool.self, forKey: .creatorLocal)
        creatorName = try values.decodeIfPresent(String.self, forKey: .creatorName)
        creatorPreferredUsername = try values.decodeIfPresent(String.self, forKey: .creatorPreferredUsername)
        creatorPublished = try values.decodeIfPresent(String.self, forKey: .creatorPublished)
        creatorAvatar = try values.decodeIfPresent(String.self, forKey: .creatorAvatar)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        upvotes = try values.decodeIfPresent(Int.self, forKey: .upvotes)
        downvotes = try values.decodeIfPresent(Int.self, forKey: .downvotes)
        hotRank = try values.decodeIfPresent(Int.self, forKey: .hotRank)
        hotRankActive = try values.decodeIfPresent(Int.self, forKey: .hotRankActive)
        userID = try values.decodeIfPresent(String.self, forKey: .userID)
        myVote = try values.decodeIfPresent(String.self, forKey: .myVote)
        subscribed = try values.decodeIfPresent(String.self, forKey: .subscribed)
        saved = try values.decodeIfPresent(String.self, forKey: .saved)
    }
}
