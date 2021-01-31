//
//  LemmyPostItemSummary.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmyPostItemSummary: Codable {
    var post: LemmyPostItem?
    var creator: LemmyUser?
    var community: LemmyCommunity?
    var creatorBannedFromCommunity: Bool?
    var counts: Counts
    var subscribed: Bool?
    var saved: Bool?
    var read: Bool?
    var myVote: Bool?
    
    enum CodingKeys: String, CodingKey {
        case post = "post"
        case creator = "creator"
        case community = "community"
        case creatorBannedFromCommunity = "creator_banned_from_community"
        case counts = "counts"
        case subscribed = "subscribed"
        case saved = "saved"
        case read = "read"
        case myVote = "my_vote"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        post = try values.decodeIfPresent(LemmyPostItem.self, forKey: .post)
        creator = try values.decodeIfPresent(LemmyUser.self, forKey: .creator)
        community = try values.decodeIfPresent(LemmyCommunity.self, forKey: .community)
        creatorBannedFromCommunity = try values.decodeIfPresent(Bool.self, forKey: .creatorBannedFromCommunity)
        counts = try values.decode(Counts.self, forKey: .counts)
        subscribed = try values.decodeIfPresent(Bool.self, forKey: .subscribed)
        saved = try values.decodeIfPresent(Bool.self, forKey: .saved)
        read = try values.decodeIfPresent(Bool.self, forKey: .read)
        myVote = try values.decodeIfPresent(Bool.self, forKey: .myVote)
    }
    
    struct Counts: Codable {
        var id: Int
        var postID: Int
        var comments: Int?
        var score: Int?
        var upvotes: Int?
        var downvotes: Int?
        var stickied: Bool?
        var published: String?
        var newestCommentTime: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case postID = "post_id"
            case comments = "comments"
            case score = "score"
            case upvotes = "upvotes"
            case downvotes = "downvotes"
            case stickied = "stickied"
            case published = "published"
            case newestCommentTime = "newest_comment_time"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            postID = try values.decode(Int.self, forKey: .postID)
            comments = try values.decodeIfPresent(Int.self, forKey: .comments)
            score = try values.decodeIfPresent(Int.self, forKey: .score)
            upvotes = try values.decodeIfPresent(Int.self, forKey: .upvotes)
            downvotes = try values.decodeIfPresent(Int.self, forKey: .downvotes)
            stickied = try values.decodeIfPresent(Bool.self, forKey: .stickied)
            published = try values.decodeIfPresent(String.self, forKey: .published)
            newestCommentTime = try values.decodeIfPresent(String.self, forKey: .newestCommentTime)
        }
    }
}
