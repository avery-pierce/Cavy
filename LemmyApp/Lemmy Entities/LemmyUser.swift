//
//  LemmyUser.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import Foundation

struct LemmyUser: Codable, Equatable {
    var id: Int
    var actorID: String?
    var name: String?
    var avatar: String?
    var banner: String?
    var email: String?
    var matrixUserID: String?
    var bio: String?
    var local: Bool?
    var admin: Bool?
    var banned: Bool?
    var showAvatars: Bool?
    var sendNotificationsToEmail: Bool?
    var published: String? // Date formatted
    var numberOfPosts: Int?
    var postScore: Int?
    var numberOfComments: Int?
    var commentScore: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case actorID = "actor_id"
        case name = "name"
        case avatar = "avatar"
        case banner = "banner"
        case email = "email"
        case matrixUserID = "matrix_user_id"
        case bio = "bio"
        case local = "local"
        case admin = "admin"
        case banned = "banned"
        case showAvatars = "show_avatars"
        case sendNotificationsToEmail = "send_notifications_to_email"
        case published = "published"
        case numberOfPosts = "number_of_posts"
        case postScore = "post_score"
        case numberOfComments = "number_of_comments"
        case commentScore = "comment_score"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        actorID = try values.decodeIfPresent(String.self, forKey: .actorID)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        banner = try values.decodeIfPresent(String.self, forKey: .banner)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        matrixUserID = try values.decodeIfPresent(String.self, forKey: .matrixUserID)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        local = try values.decodeIfPresent(Bool.self, forKey: .local)
        admin = try values.decodeIfPresent(Bool.self, forKey: .admin)
        banned = try values.decodeIfPresent(Bool.self, forKey: .banned)
        showAvatars = try values.decodeIfPresent(Bool.self, forKey: .showAvatars)
        sendNotificationsToEmail = try values.decodeIfPresent(Bool.self, forKey: .sendNotificationsToEmail)
        published = try values.decodeIfPresent(String.self, forKey: .published)
        numberOfPosts = try values.decodeIfPresent(Int.self, forKey: .numberOfPosts)
        postScore = try values.decodeIfPresent(Int.self, forKey: .postScore)
        numberOfComments = try values.decodeIfPresent(Int.self, forKey: .numberOfComments)
        commentScore = try values.decodeIfPresent(Int.self, forKey: .commentScore)
    }
}

