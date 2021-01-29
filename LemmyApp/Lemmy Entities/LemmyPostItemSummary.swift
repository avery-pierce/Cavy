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
    var counts: LemmyCounts?
    var subscribed: Bool?
    var saved: Bool?
    var read: Bool?
    var myVote: Bool?
}
