//
//  LemmyPostResponseV2.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmyPostResponseV2: Codable {
    var postView: LemmyPostItemSummary
    var communityView: LemmyCommunitySummary?
    var comments: [LemmyCommentSummary]?
    var moderators: [LemmyModeratorSummary]?
    var online: Int?
    
    enum CodingKeys: String, CodingKey {
        case postView = "post_view"
        case communityView = "community_view"
        case comments = "comments"
        case moderators = "moderators"
        case online = "online"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postView = try values.decode(LemmyPostItemSummary.self, forKey: .postView)
        communityView = try values.decodeIfPresent(LemmyCommunitySummary.self, forKey: .communityView)
        comments = try values.decodeIfPresent([LemmyCommentSummary].self, forKey: .comments)
        moderators = try values.decodeIfPresent([LemmyModeratorSummary].self, forKey: .moderators)
        online = try values.decodeIfPresent(Int.self, forKey: .online)
    }
}

struct LemmyCommentSummary: Codable {
    var comment: LemmyComment?
    var creator: LemmyUser?
    var recipient: LemmyUser?
    var post: LemmyPostItem?
    var community: LemmyCommunity?
    var counts: Counts
    var creatorBannedFromCommunity: Bool?
    var subscribed: Bool?
    var saved: Bool?
    var myVote: Int?
    
    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case creator = "creator"
        case recipient = "recipient"
        case post = "post"
        case community = "community"
        case counts = "counts"
        case creatorBannedFromCommunity = "creator_banned_from_community"
        case subscribed = "subscribed"
        case saved = "saved"
        case myVote = "my_vote"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comment = try values.decodeIfPresent(LemmyComment.self, forKey: .comment)
        creator = try values.decodeIfPresent(LemmyUser.self, forKey: .creator)
        recipient = try values.decodeIfPresent(LemmyUser.self, forKey: .recipient)
        post = try values.decodeIfPresent(LemmyPostItem.self, forKey: .post)
        community = try values.decodeIfPresent(LemmyCommunity.self, forKey: .community)
        counts = try values.decode(Counts.self, forKey: .counts)
        creatorBannedFromCommunity = try values.decodeIfPresent(Bool.self, forKey: .creatorBannedFromCommunity)
        subscribed = try values.decodeIfPresent(Bool.self, forKey: .subscribed)
        saved = try values.decodeIfPresent(Bool.self, forKey: .saved)
        myVote = try values.decodeIfPresent(Int.self, forKey: .myVote)
    }
    
    struct Counts: Codable {
        var id: Int
        var commentID: Int
        var score: Int?
        var upvotes: Int?
        var downvotes: Int?
        var published: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case commentID = "comment_id"
            case score = "score"
            case upvotes = "upvotes"
            case downvotes = "downvotes"
            case published = "published"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            commentID = try values.decode(Int.self, forKey: .commentID)
            score = try values.decodeIfPresent(Int.self, forKey: .score)
            upvotes = try values.decodeIfPresent(Int.self, forKey: .upvotes)
            downvotes = try values.decodeIfPresent(Int.self, forKey: .downvotes)
            published = try values.decodeIfPresent(String.self, forKey: .published)
        }
    }
}

struct LemmyModeratorSummary: Codable {
    var community: LemmyCommunity?
    var moderator: LemmyUser?
}

