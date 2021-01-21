//
//  CommentsListView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import SwiftUI

struct CommentsListView: View {
    @ObservedObject var commentTree: CommentTree
    
    init(_ comments: [LemmyComment]) {
        let commentTreeBuilder = CommentTreeUseCase(comments)
        self.commentTree = CommentTree(commentTreeBuilder.buildTree())
    }
    
    var body: some View {
        ForEach(commentTree.comments, id: \.comment.id) { comment in
            // FIXME: The tap target shrinks to fit the content instead
            // of filling the entire cell.
            CommentView(comment)
                .onTapGesture {
                    self.commentTree.toggleHidden(comment.comment.id!)
                }
        }
    }
}

struct CommentsListView_Previews: PreviewProvider {
    static var previews: some View {
        List() {
            CommentsListView([
                .fromJSON("""
                        {
                            "id": 1,
                            "creator_name": "jill",
                            "content": "Hello World! This is the first comment in the list"
                        }
                        """)
                ,
                .fromJSON("""
                        {
                            "id": 2,
                            "creator_name": "jack",
                            "content": "Preview a second comment",
                            "parent_id": 1
                        }
                        """),
                .fromJSON("""
                        {
                            "id": 3,
                            "creator_name": "jack",
                            "content": "Preview a second comment",
                            "parent_id": 1
                        }
                        """),
                .fromJSON("""
                    {
                        "id": 4,
                        "creator_name": "jack",
                        "content": "Preview a second comment",
                        "parent_id": 2
                    }
                    """)
            ])
        }
        .animation(.easeInOut)
        
    }
}
