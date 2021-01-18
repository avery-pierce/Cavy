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
    var isHidden: Bool
    
    init(_ comment: LemmyComment, indentationLevel: Int = 0, isHidden: Bool = false) {
        self.comment = comment
        self.indentationLevel = indentationLevel
        self.isHidden = isHidden
    }
}
