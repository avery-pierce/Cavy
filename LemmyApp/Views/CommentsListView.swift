//
//  CommentsListView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import SwiftUI

struct CommentsListView: View {
    let comments: [LemmyComment]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(comments, id: \.id) { comment in
                CommentView(comment)
            }
        }
    }
}

struct CommentsListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsListView(comments: [
            .fromJSON("""
                        {
                            "id": 1,
                            "creator_name": "jill",
                            "content": "Hello World! This is the first comment in the list"
                        }
                        """),
            .fromJSON("""
                        {
                            "id": 2,
                            "creator_name": "jack",
                            "content": "Preview a second comment"
                        }
                        """)
        ])
    }
}
