//
//  ThreadedComment.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

struct ThreadedComment {
    var indentationLevel: Int = 0
    var comment: LemmyComment
    
    init(_ comment: LemmyComment, indentationLevel: Int = 0) {
        self.comment = comment
        self.indentationLevel = indentationLevel
    }
}
