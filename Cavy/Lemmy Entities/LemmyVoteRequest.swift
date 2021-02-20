//
//  LemmyVoteBody.swift
//  Cavy
//
//  Created by Avery Pierce on 2/20/21.
//

import Foundation

struct LemmyVoteBody: Codable {
    var post_id: Int
    var score: Int
    var auth: String
    
    init(_ score: Int, postID: Int, auth: String) {
        self.score = score
        self.post_id = postID
        self.auth = auth
    }
}
