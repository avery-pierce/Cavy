//
//  ListingView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct ListingView: View {
    @Environment(\.lemmyAPIClient) var client
    let posts: [CavyPost]
    let isNextPageLoading: Bool
    let onLoadNextPage: (() -> Void)?
    
    init(_ posts: [CavyPost], isNextPageLoading: Bool = false, onLoadNextPage: (() -> Void)? = nil) {
        self.posts = posts
        self.isNextPageLoading = isNextPageLoading
        self.onLoadNextPage = onLoadNextPage
    }
    
    init(_ postListing: CavyPostListing, isNextPageLoading: Bool = false, onLoadNextPage: (() -> Void)? = nil) {
        self.init(postListing.cavyPosts,
                  isNextPageLoading: isNextPageLoading,
                  onLoadNextPage: onLoadNextPage)
    }
    
    func vote(on post: CavyPost, score: Int) {
        switch client {
        case .v1(let spec): spec.vote(score, onPostID: post.id).load(completion: { _ in })
        case .v2(let spec): spec.vote(score, onPostID: post.id).load(completion: { _ in })
        }
    }
    
    var body: some View {
        // Had to jumpt through some strange hooks to hide the disclosure indicator
        // https://stackoverflow.com/a/61724540
        List {
            ForEach(posts, id: \.id) { post in
                ZStack {
                    PostItemView(post, onVoteChanged: { newVote in
                        self.vote(on: post, score: newVote)
                    })
                    
                    NavigationLink(
                        destination: PostDetailView(post: post).lemmyAPIClient(client)) {
                        EmptyView()
                    }
                    .frame(width: 0, height: 0)
                    .hidden()
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    if isNextPageLoading { ProgressView() }
                }
            }
            .frame(height: 80, alignment: .center)
            .frame(maxWidth: .infinity)
            .onAppear(perform: { onLoadNextPage?() })
        }
        .listStyle(PlainListStyle())
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListingView(LemmyPostItem.sampleDataList.map(\.cavyPost))
            ListingView(LemmyPostItem.sampleDataList.map(\.cavyPost))
                .preferredColorScheme(.dark)
        }
        .lemmyAPIClient(.lemmyML)
        .rootModel(RootModel())
    }
}
