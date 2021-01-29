//
//  LemmyCommunitySummary.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmyCommunitySummary: Codable {
    var community: LemmyCommunity?
    var creator: LemmyUser?
    var category: LemmyCategory?
    var subscribed: Bool?
    var counts: LemmyCounts?
}
