//
//  CommentView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import SwiftUI

struct CommentView: View {
    let threadedComment: ThreadedComment
    var comment: LemmyComment { threadedComment.comment }
    
    init(_ threadedComment: ThreadedComment) {
        self.threadedComment = threadedComment
    }
    
    var author: String {
        return comment.creatorPreferredUsername ?? comment.creatorName ?? "(user)"
    }
    
    var isHidden: Bool {
        return threadedComment.isHidden
    }
    
    var barColor: UIColor {
        guard !threadedComment.isHidden else { return .gray }
        
        let colorCycle: [UIColor] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .purple,
        ]
        
        let choice = threadedComment.indentationLevel % colorCycle.count
        return colorCycle[choice]
    }
    
    var inset: CGFloat {
        return 8.0 * CGFloat(threadedComment.indentationLevel)
    }
    
    var body: some View {
        HStack {
            Color(barColor)
                .frame(width: 3)
                .cornerRadius(1.5)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(author)
                        .bold()
                        .padding(.bottom, 6)
                        .font(.system(size: 14.0))
                        .foregroundColor(isHidden ? .gray : .black)
                }
                if !isHidden {
                    Text(comment.content ?? "(content)")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 14.0))
                }
            }
        }
        .padding(.leading, inset)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(0..<10) { i in
                CommentView(ThreadedComment(.fromJSON("""
                            {
                                "creator_name": "john_appleseed",
                                "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah"
                            }
                            """), indentationLevel: i))
                    .previewLayout(.fixed(width: 300, height: 100))
            }
            CommentView(ThreadedComment(.fromJSON("""
                            {
                                "creator_name": "john_appleseed",
                                "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah"
                            }
                            """), indentationLevel: 0, isHidden: true))
                .previewLayout(.fixed(width: 300, height: 100))
        }
        
    }
}
