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
    var counts: Counts
    
    struct Counts: Codable {
        var id: Int
        var communityID: Int
        var subscribers: Int?
        var posts: Int?
        var comments: Int?
        var published: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case communityID = "community_id"
            case subscribers = "subscribers"
            case posts = "posts"
            case comments = "comments"
            case published = "published"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            communityID = try values.decode(Int.self, forKey: .communityID)
            subscribers = try values.decodeIfPresent(Int.self, forKey: .subscribers)
            posts = try values.decodeIfPresent(Int.self, forKey: .posts)
            comments = try values.decodeIfPresent(Int.self, forKey: .comments)
            published = try values.decodeIfPresent(String.self, forKey: .published)
        }
    }
}
