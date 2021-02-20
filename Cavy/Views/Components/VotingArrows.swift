//
//  VotingArrows.swift
//  Cavy
//
//  Created by Avery Pierce on 2/20/21.
//

import SwiftUI

struct VotingArrows: View {
    @Environment(\.palette) var palette
    @State private var myVote: Int
    let onVoteChanged: (_ newVote: Int) -> Void

    init(myVote: Int, onVoteChanged: @escaping (_ newVote: Int) -> Void) {
        self.onVoteChanged = onVoteChanged
        self._myVote = .init(initialValue: myVote)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: voteUp, label: {
                Image(systemName: "arrow.up")
            })
            .padding(4)
            .foregroundColor(myVote == 1 ? .white : .secondary)
            .background(Circle().fill(palette.upvote).opacity(myVote == 1 ? 1.0 : 0.0))
            
            Button(action: voteDown, label: {
                Image(systemName: "arrow.down")
            })
            .padding(4)
            .foregroundColor(myVote == -1 ? .white : .secondary)
            .background(Circle().fill(palette.downvote).opacity(myVote == -1 ? 1.0 : 0.0))
        }
    }
    
    func voteUp() {
        if myVote == 1 {
            myVote = 0
        } else {
            myVote = 1
        }
        
        onVoteChanged(myVote)
    }
    
    func voteDown() {
        if myVote == -1 {
            myVote = 0
        } else {
            myVote = -1
        }
        
        onVoteChanged(myVote)
    }
}

struct VotingArrows_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Themed {
                HStack {
                    VotingArrows(myVote: 0, onVoteChanged: { _ in })
                    VotingArrows(myVote: 1, onVoteChanged: { _ in })
                    VotingArrows(myVote: -1, onVoteChanged: { _ in })
                }
                .padding()
            }
            
            Themed {
                HStack {
                    VotingArrows(myVote: 0, onVoteChanged: { _ in })
                    VotingArrows(myVote: 1, onVoteChanged: { _ in })
                    VotingArrows(myVote: -1, onVoteChanged: { _ in })
                }
                .padding()
                .background(Color.systemBackground)
            }
            .colorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
