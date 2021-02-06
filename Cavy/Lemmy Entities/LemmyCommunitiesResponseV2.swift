//
//  LemmyCommunitiesResponseV2.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmyCommunitiesResponseV2: Codable {
    var communities: [LemmyCommunitySummary]
}
