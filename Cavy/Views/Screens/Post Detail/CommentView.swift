//
//  CommentView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import SwiftUI

struct CommentView: View {
    @Environment(\.palette) var palette
    
    let threadedComment: ThreadedComment
    let isOP: Bool
    var comment: CavyComment { threadedComment.comment }
    
    init(_ threadedComment: ThreadedComment, isOP: Bool) {
        self.threadedComment = threadedComment
        self.isOP = isOP
    }
    
    var author: String {
        return comment.submitterName ?? "(user)"
    }
    
    var authorColor: Color {
        if isHidden {
            return .secondary
        } else if comment.isSubmitterAdmin {
            return palette.adminUsername
        } else if isOP {
            return palette.opCommentUsername
        } else {
            return .primary
        }
    }
    
    var isHidden: Bool {
        return threadedComment.isHidden
    }
    
    var barColor: Color {
        guard !threadedComment.isHidden else { return .secondary }
        
        let colorCycle: [Color] = [
            palette.red,
            palette.orange,
            palette.yellow,
            palette.green,
            palette.blue,
            palette.purple,
        ]
        
        let choice = threadedComment.indentationLevel - 1 % colorCycle.count
        return colorCycle[choice]
    }
    
    var scoreText: String {
        guard let score = comment.score else { return "-" }
        return "\(score)"
    }
    
    var inset: CGFloat {
        guard threadedComment.indentationLevel > 0 else { return 0 }
        return 8.0 * CGFloat(threadedComment.indentationLevel - 1)
    }
    
    var timeAgoText: String {
        guard let publishedDate = comment.publishDate else { return "??" }
        
        let now = Date()
        let interval = now.timeIntervalSince(publishedDate)
        return abbreviatedTimeInterval(of: interval)
    }
    
    var body: some View {
        HStack {
            if (threadedComment.indentationLevel > 0) {
            RoundedRectangle(cornerRadius: 1.5)
                .fill(barColor)
                .frame(width: 3)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                VStack {
                    HStack(alignment: .center, spacing: 12) {
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2) {
                            Image(systemName: "arrow.up")
                            Text(scoreText)
                        }
                        
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                            Text(author).bold()
                                .foregroundColor(authorColor)
                        }
                        
                        Spacer()
                        
                        Text(timeAgoText)
                            .foregroundColor(.secondary)
                    }
                }
                .font(.system(size: 14.0))
                .foregroundColor(isHidden ? .secondary : .primary)
                
                if !isHidden {
                    MarkdownText(comment.bodyMarkdown ?? "(content)")
                        .font(.system(size: 14.0))
                        .multilineTextAlignment(.leading)
                    
                }
            }
            .padding(.vertical, 4)
        }
        .padding(.leading, inset)
        .padding(.trailing, 12)

    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        Themed {
            Group {
                Group {
                    ForEach(0..<7) { i in
                        CommentView(ThreadedComment(try! LemmyComment.fromJSON("""
                                    {
                                        "id": 1,
                                        "creator_name": "john_appleseed",
                                        "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah",
                                        "score": 15,
                                        "creator_published": "2021-01-18T23:42:26.673844"
                                    }
                                    """), indentationLevel: i), isOP: true)
                            .previewLayout(.fixed(width: 300, height: 100))
                    }
                    
                    CommentView(ThreadedComment(try! LemmyComment.fromJSON("""
                                    {
                                        "id": 2,
                                        "creator_name": "john_appleseed",
                                        "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah"
                                    }
                                    """), indentationLevel: 0, isHidden: true), isOP: true)
                        .previewLayout(.fixed(width: 300, height: 100))
                }
                
                Group {
                    ForEach(0..<7) { i in
                        CommentView(ThreadedComment(try! LemmyComment.fromJSON("""
                                    {
                                        "id": 3,
                                        "creator_name": "john_appleseed",
                                        "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah",
                                        "score": 15,
                                    }
                                    """), indentationLevel: i), isOP: false)
                            .previewLayout(.fixed(width: 300, height: 100))
                    }
                    
                    CommentView(ThreadedComment(try! LemmyComment.fromJSON("""
                                    {
                                        "id": 4,
                                        "creator_name": "john_appleseed",
                                        "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah"
                                    }
                                    """), indentationLevel: 0, isHidden: true), isOP: true)
                        
                        .previewLayout(.fixed(width: 300, height: 100))
                }
                .preferredColorScheme(.dark)
            } 
        }
    }
}
