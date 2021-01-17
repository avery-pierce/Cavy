//
//  CommentView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import SwiftUI

struct CommentView: View {
    let comment: LemmyComment
    
    init(_ comment: LemmyComment) {
        self.comment = comment
    }
    
    var author: String {
        return comment.creatorPreferredUsername ?? comment.creatorName ?? "(user)"
    }
    
    var body: some View {
        HStack {
            Color(.red)
                .frame(width: 3)
                .cornerRadius(1.5)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(author)
                        .bold()
                        .padding(.bottom, 6)
                }
                Text(comment.content ?? "(content)")
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(.fromJSON("""
                        {
                            "creator_name": "john_appleseed",
                            "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah"
                        }
                        """))
            .previewLayout(.sizeThatFits)
    }
}
