//
//  ThreadedComment.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

struct ThreadedComment {
    var indentationLevel: Int = 0
    var comment: CavyComment
    var isHidden: Bool
    
    init(_ comment: LemmyComment, indentationLevel: Int = 0, isHidden: Bool = false) {
        self.init(comment.cavyComment, indentationLevel: indentationLevel, isHidden: isHidden)
    }
    
    init(_ comment: CavyComment, indentationLevel: Int = 0, isHidden: Bool = false) {
        self.comment = comment
        self.indentationLevel = indentationLevel
        self.isHidden = isHidden
    }
}
