//
//  CavyComment.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct CavyComment {
    var id: Int
    var parentID: Int?
    var score: Int?
    var submitterName: String?
    var publishDate: Date?
    var bodyMarkdown: String?
}

extension LemmyComment {
    var cavyComment: CavyComment {
        let publishDate = published.flatMap(parseLemmyDate(_:))
        return CavyComment(id: id!, parentID: parentID, score: score, submitterName: creatorPreferredUsername ?? creatorName, publishDate: publishDate, bodyMarkdown: content)
    }
}

extension LemmyCommentSummary {
    var cavyComment: CavyComment {
        let publishDate = comment?.published.flatMap(parseLemmyDate(_:))
        return CavyComment(id: comment!.id!, parentID: comment!.parentID!, score: counts.score, submitterName: creator?.name, publishDate: publishDate, bodyMarkdown: comment?.content)
    }
}

protocol CavyCommentListing {
    var cavyComments: [CavyComment] { get }
}

extension LemmyPostResponse: CavyCommentListing {
    var cavyComments: [CavyComment] {
        return comments.map(\.cavyComment)
    }
}

extension LemmyPostResponseV2: CavyCommentListing {
    var cavyComments: [CavyComment] {
        return comments?.map(\.cavyComment) ?? []
    }
}
