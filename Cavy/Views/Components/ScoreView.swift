//
//  ScoreView.swift
//  Cavy
//
//  Created by Avery Pierce on 2/20/21.
//

import SwiftUI

struct ScoreView: View {
    @Environment(\.palette) var palette
    
    var score: Int?
    var myVote: Int?
    
    init(score: Int?, myVote: Int? = nil) {
        self.score = score
        self.myVote = myVote
    }
    
    init(_ post: CavyPost) {
        self.score = post.score
        self.myVote = post.myVote
    }
    
    init(_ comment: CavyComment) {
        self.score = comment.score
        self.myVote = nil // TODO: Add "myVote" here
    }
    
    var scoreText: String {
        guard let score = score else { return "-" }
        return "\(score)"
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            if myVote == 1 {
                Image(systemName: "arrow.up").foregroundColor(palette.upvote)
                Text(scoreText).foregroundColor(palette.upvote)
            } else if myVote == -1 {
                Image(systemName: "arrow.down").foregroundColor(palette.downvote)
                Text(scoreText).foregroundColor(palette.downvote)
            } else {
                Image(systemName: "arrow.up")
                Text(scoreText)
            }
        }
        .font(.system(size: 12.0, weight: (myVote ?? 0) == 0 ? .regular : .bold))
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                ScoreView(score: 16, myVote: 1)
                ScoreView(score: 15, myVote: 0)
                ScoreView(score: 14, myVote: -1)
                ScoreView(score: nil, myVote: nil)
            }
            .padding()
            
            Themed {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                    ScoreView(score: 16, myVote: 1)
                    ScoreView(score: 15, myVote: 0)
                    ScoreView(score: 14, myVote: -1)
                    ScoreView(score: nil, myVote: nil)
                }
                .padding()
                .background(Color.secondarySystemGroupedBackground)
            }
            .colorScheme(.dark)
            .palette(LemmyDarkTheme())
        }
        .previewLayout(.sizeThatFits)
    }
}
