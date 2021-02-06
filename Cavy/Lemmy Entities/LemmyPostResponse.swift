//
//  LemmyPostResponse.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import Foundation

struct LemmyPostResponse: Codable, Equatable {
    let post: LemmyPostItem
    let comments: [LemmyComment]
    let community: LemmyCommunity
    let moderators: [LemmyModerator]
}
