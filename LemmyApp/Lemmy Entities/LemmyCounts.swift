//
//  LemmyCounts.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmyCounts: Codable {
    var id: Int?
    
    // TODO: bind this to community_id
    var communityID: Int?
    var subscribers: Int?
    var posts: Int?
    var comments: Int?
    var published: String?
}
