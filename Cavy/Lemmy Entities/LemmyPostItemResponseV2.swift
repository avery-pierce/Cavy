//
//  LemmyPostItemResponseV2.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmyPostItemResponseV2: Codable {
    var posts: [LemmyPostItemSummary]
}
