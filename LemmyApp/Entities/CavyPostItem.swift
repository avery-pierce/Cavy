//
//  PostItem.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import Foundation

struct CavyPost {
    var id: Int
    var title: String?
    var visited: Bool?
    var submitterName: String?
    var communityName: String?
    var score: Int?
    var numComments: Int?
    var publishDate: Date?
    var thumbnailURL: URL?
    var linkURL: URL?
    var bodyMarkdown: String?
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
        return CavyPost(id: id, title: name, visited: false, submitterName: creatorPreferredUsername ?? creatorName, communityName: communityName, score: score, numComments: numberOfComments, publishDate: publishedDate, thumbnailURL: thumbnailURL.flatMap(URL.init(string:)), linkURL: url, bodyMarkdown: body)
    }
}

extension LemmyPostItemResponse: CavyPostListing {
    var cavyPosts: [CavyPost] { posts.map(\.cavyPost) }
}

extension LemmyPostItemSummary {
    var cavyPost: CavyPost {
        let publishedDate = counts.published.flatMap(parseLemmyDate(_:))
        return CavyPost(id: post!.id, title: post?.name, visited: read, submitterName: creator?.name, communityName: community?.name, score: counts.score, numComments: counts.comments, publishDate: publishedDate, thumbnailURL: post?.thumbnailURL.flatMap(URL.init(string:)), linkURL: post?.url, bodyMarkdown: post?.body)
    }
}

extension LemmyPostItemResponseV2: CavyPostListing {
    var cavyPosts: [CavyPost] { posts.map(\.cavyPost) }
}
