//
//  LemmyPostResponseV2.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmyPostResponseV2: Codable {
    var postView: LemmyPostItemSummary?
    var communityView: LemmyCommunitySummary?
    var comments: [LemmyCommentSummary]?
    var moderators: [LemmyModeratorSummary]?
    var online: Int?
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
    var myVote: Bool?
    
    struct Counts: Codable {
        var id: Int
        var commentID: Int
        var score: Int?
        var upvotes: Int?
        var downvotes: Int?
        var published: String?
    }
}

struct LemmyModeratorSummary: Codable {
    var community: LemmyCommunity?
    var moderator: LemmyUser?
}

