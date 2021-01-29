//
//  ListingView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct ListingView: View {
    let posts: [LemmyPostItem]
    init(_ posts: [LemmyPostItem]) {
        self.posts = posts
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
            ListingView(LemmyPostItem.sampleDataList)
            ListingView(LemmyPostItem.sampleDataList)
                .preferredColorScheme(.dark)
        }
    }
}
