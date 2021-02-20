//
//  PostItem.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import Foundation

struct CavyPost {
    var id: Int
    var apID: String
    var title: String?
    var visited: Bool?
    var submitterName: String?
    var isSubmitterAdmin: Bool
    var communityName: String?
    var score: Int?
    var numComments: Int?
    var publishDate: Date?
    var thumbnailURL: URL?
    var linkURL: URL?
    var bodyMarkdown: String?
    var embed: Embed?
    var myVote: Int?
    var isRead: Bool
    
    struct Embed {
        var title: String?
        var description: String?
    }
}

extension CavyPost {
    var domain: String? {
        return linkURL?.host
    }
}

protocol CavyPostListing {
    var cavyPosts: [CavyPost] { get }
}

extension LemmyPostItem {
    var cavyPost: CavyPost {
        let publishedDate = published.flatMap(parseLemmyDate(_:))
        let embed = CavyPost.Embed(title: embedTitle, description: embedDescription)
        return CavyPost(id: id,
                        apID: apID ?? UUID().uuidString,
                        title: name,
                        visited: false,
                        submitterName: creatorPreferredUsername ?? creatorName,
                        isSubmitterAdmin: false,
                        communityName: communityName,
                        score: score,
                        numComments: numberOfComments,
                        publishDate: publishedDate,
                        thumbnailURL: thumbnailURL.flatMap(URL.init(string:)),
                        linkURL: url.flatMap(URL.init(string:)),
                        bodyMarkdown: body,
                        embed: embed,
                        myVote: myVote,
                        isRead: read ?? false)
    }
}

extension LemmyPostItemResponse: CavyPostListing {
    var cavyPosts: [CavyPost] { posts.map(\.cavyPost) }
}

extension LemmyPostItemSummary {
    var cavyPost: CavyPost {
        let publishedDate = counts.published.flatMap(parseLemmyDate(_:))
        let embed = CavyPost.Embed(title: post?.embedTitle, description: post?.embedDescription)
        return CavyPost(id: post!.id,
                        apID: post!.apID ?? UUID().uuidString,
                        title: post?.name,
                        visited: read,
                        submitterName: creator?.name,
                        isSubmitterAdmin: creator?.admin ?? false,
                        communityName: community?.name,
                        score: counts.score,
                        numComments: counts.comments,
                        publishDate: publishedDate,
                        thumbnailURL: post?.thumbnailURL.flatMap(URL.init(string:)),
                        linkURL: post?.url.flatMap(URL.init(string:)),
                        bodyMarkdown: post?.body,
                        embed: embed,
                        myVote: myVote,
                        isRead: read ?? false)
    }
}

extension LemmyPostItemResponseV2: CavyPostListing {
    var cavyPosts: [CavyPost] { posts.map(\.cavyPost) }
}
