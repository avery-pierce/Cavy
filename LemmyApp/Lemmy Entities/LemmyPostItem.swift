//
//  LemmyPostItem.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation

struct LemmyPostItem: Codable, Equatable {
    let embedDescription : String?
    let communityDeleted : Bool?
    let _id : Int
    let local : Bool?
    let body : String?
    let creatorID : Int?
    let creatorAvatar : String?
    let locked : Bool?
    let url : URL?
    let updated : String?
    let communityID : Int?
    let communityIcon : String?
    let score : Int
    let newestActivityTime : String?
    let creatorActorID : String?
    let communityLocal : Bool?
    let embedTitle : String?
    let hotRankActive : Int?
    let banned : Bool?
    let name : String?
    let embedHTML : String?
    let myVote : String?
    let creatorPreferredUsername : String?
    let apID : String?
    let subscribed : String?
    let published : String?
    let stickied : Bool?
    let creatorName : String?
    let thumbnailURL : String?
    let communityName : String?
    let saved : String?
    let deleted : Bool?
    let removed : Bool?
    let creatorPublished : String?
    let upvotes : Int?
    let numberOfComments : Int?
    let userID : String?
    let hotRank : Int?
    let communityRemoved : Bool?
    let read : String?
    let bannedFromCommunity : Bool?
    let creatorLocal : Bool?
    let communityActorID : String?
    let downvotes : Int?
    let communityNSFW : Bool?
    let nsfw : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case embedDescription = "embed_description"
        case communityDeleted = "community_deleted"
        case _id = "id"
        case local = "local"
        case body = "body"
        case creatorID = "creator_id"
        case creatorAvatar = "creator_avatar"
        case locked = "locked"
        case url = "url"
        case updated = "updated"
        case communityID = "community_id"
        case communityIcon = "community_icon"
        case score = "score"
        case newestActivityTime = "newest_activity_time"
        case creatorActorID = "creator_actor_id"
        case communityLocal = "community_local"
        case embedTitle = "embed_title"
        case hotRankActive = "hot_rank_active"
        case banned = "banned"
        case name = "name"
        case embedHTML = "embed_html"
        case myVote = "my_vote"
        case creatorPreferredUsername = "creator_preferred_username"
        case apID = "ap_id"
        case subscribed = "subscribed"
        case published = "published"
        case stickied = "stickied"
        case creatorName = "creator_name"
        case thumbnailURL = "thumbnail_url"
        case communityName = "community_name"
        case saved = "saved"
        case deleted = "deleted"
        case removed = "removed"
        case creatorPublished = "creator_published"
        case upvotes = "upvotes"
        case numberOfComments = "number_of_comments"
        case userID = "user_id"
        case hotRank = "hot_rank"
        case communityRemoved = "community_removed"
        case read = "read"
        case bannedFromCommunity = "banned_from_community"
        case creatorLocal = "creator_local"
        case communityActorID = "community_actor_id"
        case downvotes = "downvotes"
        case communityNSFW = "community_nsfw"
        case nsfw = "nsfw"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        embedDescription = try values.decodeIfPresent(String.self, forKey: .embedDescription)
        communityDeleted = try values.decodeIfPresent(Bool.self, forKey: .communityDeleted)
        _id = try values.decode(Int.self, forKey: ._id)
        local = try values.decodeIfPresent(Bool.self, forKey: .local)
        body = try values.decodeIfPresent(String.self, forKey: .body)
        creatorID = try values.decodeIfPresent(Int.self, forKey: .creatorID)
        creatorAvatar = try values.decodeIfPresent(String.self, forKey: .creatorAvatar)
        locked = try values.decodeIfPresent(Bool.self, forKey: .locked)
        url = try values.decodeIfPresent(URL.self, forKey: .url)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        communityID = try values.decodeIfPresent(Int.self, forKey: .communityID)
        communityIcon = try values.decodeIfPresent(String.self, forKey: .communityIcon)
        score = try values.decode(Int.self, forKey: .score)
        newestActivityTime = try values.decodeIfPresent(String.self, forKey: .newestActivityTime)
        creatorActorID = try values.decodeIfPresent(String.self, forKey: .creatorActorID)
        communityLocal = try values.decodeIfPresent(Bool.self, forKey: .communityLocal)
        embedTitle = try values.decodeIfPresent(String.self, forKey: .embedTitle)
        hotRankActive = try values.decodeIfPresent(Int.self, forKey: .hotRankActive)
        banned = try values.decodeIfPresent(Bool.self, forKey: .banned)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        embedHTML = try values.decodeIfPresent(String.self, forKey: .embedHTML)
        myVote = try values.decodeIfPresent(String.self, forKey: .myVote)
        creatorPreferredUsername = try values.decodeIfPresent(String.self, forKey: .creatorPreferredUsername)
        apID = try values.decodeIfPresent(String.self, forKey: .apID)
        subscribed = try values.decodeIfPresent(String.self, forKey: .subscribed)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        stickied = try values.decodeIfPresent(Bool.self, forKey: .stickied)
        creatorName = try values.decodeIfPresent(String.self, forKey: .creatorName)
        thumbnailURL = try values.decodeIfPresent(String.self, forKey: .thumbnailURL)
        communityName = try values.decodeIfPresent(String.self, forKey: .communityName)
        saved = try values.decodeIfPresent(String.self, forKey: .saved)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        removed = try values.decodeIfPresent(Bool.self, forKey: .removed)
        creatorPublished = try values.decodeIfPresent(String.self, forKey: .creatorPublished)
        upvotes = try values.decodeIfPresent(Int.self, forKey: .upvotes)
        numberOfComments = try values.decodeIfPresent(Int.self, forKey: .numberOfComments)
        userID = try values.decodeIfPresent(String.self, forKey: .userID)
        hotRank = try values.decodeIfPresent(Int.self, forKey: .hotRank)
        communityRemoved = try values.decodeIfPresent(Bool.self, forKey: .communityRemoved)
        read = try values.decodeIfPresent(String.self, forKey: .read)
        bannedFromCommunity = try values.decodeIfPresent(Bool.self, forKey: .bannedFromCommunity)
        creatorLocal = try values.decodeIfPresent(Bool.self, forKey: .creatorLocal)
        communityActorID = try values.decodeIfPresent(String.self, forKey: .communityActorID)
        downvotes = try values.decodeIfPresent(Int.self, forKey: .downvotes)
        communityNSFW = try values.decodeIfPresent(Bool.self, forKey: .communityNSFW)
        nsfw = try values.decodeIfPresent(Bool.self, forKey: .nsfw)
    }
}

extension LemmyPostItem: PostItem {
    var htmlContent: String? { embedHTML }
    var bodyContent: String? { embedDescription }
    
    var id: String { String(_id) }
    var title: String { name ?? "" }
    var imageURL: URL? { thumbnailURL.flatMap(URL.init(string:)) }
    var authorName: String { creatorPreferredUsername ?? creatorName ?? "" }
    var domain: String {
        guard let url = url else { return "" }
        return URLComponents(url: url, resolvingAgainstBaseURL: false)?.host ?? ""
    }
    
    var destination: PostDestination? {
        if let url = url {
            return .web(url)
        } else {
            return .selfDetail
        }
    }
}
