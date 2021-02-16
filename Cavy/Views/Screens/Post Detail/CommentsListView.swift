//
//  CommentsListView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import SwiftUI

struct CommentsListView: View {
    @ObservedObject var commentTree: CommentTree
    
    let post: CavyPost?
    
    init(_ comments: [CavyComment], post: CavyPost? = nil) {
        let commentTreeBuilder = CommentTreeUseCase(comments)
        self.commentTree = CommentTree(commentTreeBuilder.buildTree())
        self.post = post
    }
    
    func isPostedByOP(comment: CavyComment) -> Bool {
        guard let post = post else { return false }
        return post.submitterName == comment.submitterName
    }
    
    var body: some View {
        ForEach(commentTree.comments, id: \.comment.id) { comment in
            // FIXME: The tap target shrinks to fit the content instead
            // of filling the entire cell.
            CommentView(comment, isOP: isPostedByOP(comment: comment.comment))
                .onTapGesture {
                    self.commentTree.toggleHidden(comment.comment.id)
                }
        }
        .animation(.easeIn, value: commentTree.hiddenCommentIDs)
    }
}

struct CommentsListView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            LazyVStack {
                CommentsListView([
                    try! LemmyComment.fromJSON("""
                        {
                            "id": 1,
                            "creator_name": "jill",
                            "content": "Hello World! This is the first comment in the list. It's quite a long comment. Does it wrap around many times? This is a good comment."
                        }
                        """).cavyComment
                    ,
                    try! LemmyComment.fromJSON("""
                        {
                            "id": 2,
                            "creator_name": "jack",
                            "content": "Preview a second comment",
                            "parent_id": 1
                        }
                        """).cavyComment,
                    try! LemmyComment.fromJSON("""
                        {
                            "id": 3,
                            "creator_name": "jack",
                            "content": "Preview a third comment",
                            "parent_id": 1
                        }
                        """).cavyComment,
                    try! LemmyComment.fromJSON("""
                    {
                        "id": 4,
                        "creator_name": "jack",
                        "content": "Preview another reply",
                        "parent_id": 2
                    }
                    """).cavyComment
                ])
                .padding(.leading, 8)
                Spacer()
            }
        }
        .animation(.easeInOut)
        
    }
}
