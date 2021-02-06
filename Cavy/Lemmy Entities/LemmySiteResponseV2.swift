//
//  LemmySiteResponseV2.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct LemmySiteResponseV2: Codable {
    var siteView: LemmySiteView?
    var admins: [LemmyUserView]?
    var banned: [LemmyUserView]?
    var online: Int?
    var version: String?
    var myUser: LemmyUser?
    var federatedInstances: [String]?
    
    enum CodingKeys: String, CodingKey {
        case siteView = "site_view"
        case admins = "admins"
        case banned = "banned"
        case online = "online"
        case version = "version"
        case myUser = "my_user"
        case federatedInstances = "federated_instances"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        siteView = try values.decodeIfPresent(LemmySiteView.self, forKey: .siteView)
        admins = try values.decodeIfPresent([LemmyUserView].self, forKey: .admins)
        banned = try values.decodeIfPresent([LemmyUserView].self, forKey: .banned)
        online = try values.decodeIfPresent(Int.self, forKey: .online)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        myUser = try values.decodeIfPresent(LemmyUser.self, forKey: .myUser)
        federatedInstances = try values.decodeIfPresent([String].self, forKey: .federatedInstances)
    }
}

struct LemmySiteView: Codable {
    var site: LemmySite?
    var creator: LemmyUser?
    var counts: Counts
    
    struct Counts: Codable {
        var id: Int
        var siteID: Int
        var users: Int?
        var posts: Int?
        var comments: Int?
        var communities: Int?
        var usersActiveDay: Int?
        var usersActiveWeek: Int?
        var usersActiveMonth: Int?
        var usersActiveHalfYear: Int?

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case siteID = "site_id"
            case users = "users"
            case posts = "posts"
            case comments = "comments"
            case communities = "communities"
            case usersActiveDay = "users_active_day"
            case usersActiveWeek = "users_active_week"
            case usersActiveMonth = "users_active_month"
            case usersActiveHalfYear = "users_active_half_year"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            siteID = try values.decode(Int.self, forKey: .siteID)
            users = try values.decodeIfPresent(Int.self, forKey: .users)
            posts = try values.decodeIfPresent(Int.self, forKey: .posts)
            comments = try values.decodeIfPresent(Int.self, forKey: .comments)
            communities = try values.decodeIfPresent(Int.self, forKey: .communities)
            usersActiveDay = try values.decodeIfPresent(Int.self, forKey: .usersActiveDay)
            usersActiveWeek = try values.decodeIfPresent(Int.self, forKey: .usersActiveWeek)
            usersActiveMonth = try values.decodeIfPresent(Int.self, forKey: .usersActiveMonth)
            usersActiveHalfYear = try values.decodeIfPresent(Int.self, forKey: .usersActiveHalfYear)
        }
    }
}

struct LemmyUserView: Codable {
    var user: LemmyUser?
    var counts: Counts
    
    struct Counts: Codable {
        var id: Int
        var userID: Int
        var postCount: Int?
        var postScore: Int?
        var commentCount: Int?
        var commentScore: Int?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case userID = "user_id"
            case postCount = "post_count"
            case postScore = "post_score"
            case commentCount = "comment_count"
            case commentScore = "comment_score"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            userID = try values.decode(Int.self, forKey: .userID)
            postCount = try values.decodeIfPresent(Int.self, forKey: .postCount)
            postScore = try values.decodeIfPresent(Int.self, forKey: .postScore)
            commentCount = try values.decodeIfPresent(Int.self, forKey: .commentCount)
            commentScore = try values.decodeIfPresent(Int.self, forKey: .commentScore)
        }
    }
}
