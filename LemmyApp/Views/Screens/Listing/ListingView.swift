//
//  ListingView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct ListingView: View {
    let posts: [CavyPost]
    init(_ posts: [CavyPost]) {
        self.posts = posts
    }
    
    init(_ postListing: CavyPostListing) {
        self.posts = postListing.cavyPosts
    }
    
    var body: some View {
        // Had to jumpt through some strange hooks to hide the disclosure indicator
        // https://stackoverflow.com/a/61724540
        List {
            ForEach(posts, id: \.id) { post in
                ZStack {
                    PostItemView(post)
                        .padding(.vertical, 8)
                    NavigationLink(
                        destination: PostDetailView(post: post)) {
                        EmptyView()
                    }
                    .frame(width: 0, height: 0)
                    .hidden()
                }
            }
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
    }
}
