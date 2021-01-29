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
