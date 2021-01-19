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
    
    var barColor: Color {
        guard !threadedComment.isHidden else { return .secondary }
        
        let colorCycle: [Color] = [
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
    
    var scoreText: String {
        guard let score = comment.score else { return "-" }
        return "\(score)"
    }
    
    var inset: CGFloat {
        return 8.0 * CGFloat(threadedComment.indentationLevel)
    }
    
    var timeAgoText: String {
        guard let publishedDate = comment.creatorPublishedDate else { return "??" }
        
        let now = Date()
        let interval = now.timeIntervalSince(publishedDate)
        return abbreviatedForm(of: interval)
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 1.5)
                .fill(barColor)
                .frame(width: 3)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center, spacing: 12) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2) {
                        Image(systemName: "arrow.up")
                        Text(scoreText)
                    }
                    
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                        Text(author).bold()
                    }
                    
                    Spacer()
                    
                    Text(timeAgoText)
                        .foregroundColor(.secondary)
                }
                .font(.system(size: 14.0))
                .foregroundColor(isHidden ? .secondary : .primary)
                .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
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
            Group {
                ForEach(0..<4) { i in
                    CommentView(ThreadedComment(.fromJSON("""
                                {
                                    "creator_name": "john_appleseed",
                                    "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah",
                                    "score": 15,
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
            
            Group {
                ForEach(0..<4) { i in
                    CommentView(ThreadedComment(.fromJSON("""
                                {
                                    "creator_name": "john_appleseed",
                                    "content": "This is a new comment. Hello world! Lorem Ipsum Dolor mit blah blah blah",
                                    "score": 15,
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
            .preferredColorScheme(.dark)
        }
    }
}
