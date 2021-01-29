//
//  LemmyPostItemSummary.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmyPostItemSummary: Codable {
    // TODO: CodingKeys
    var post: LemmyPostItem?
    var creator: LemmyUser?
    var community: LemmyCommunity?
    var creatorBannedFromCommunity: Bool?
    var counts: Counts
    var subscribed: Bool?
    var saved: Bool?
    var read: Bool?
    var myVote: Bool?
    
    struct Counts: Codable {
        // TODO: CodingKeys
        var id: Int
        var postID: Int?
        var comments: Int?
        var score: Int?
        var upvotes: Int?
        var downvotes: Int?
        var stickied: Bool?
        var published: String?
        var newestCommentTime: String?
    }
}
