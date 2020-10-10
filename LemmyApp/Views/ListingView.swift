//
//  ListingView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct ListingView: View {
    let posts: [PostItem]
    init(_ posts: [PostItem]) {
        self.posts = posts
    }
    
    var body: some View {
        List(posts, id: \.id) { post in
            if let destination = post.destination {
                switch destination {
                case .web(let url):
                    Link(destination: url) {
                        PostItemView(post)
                            .padding(.vertical, 8)
                    }
                    
                case .selfDetail:
                    NavigationLink(
                        destination: PostDetailView(post: post)) {
                        PostItemView(post)
                            .padding(.vertical, 8)
                    }
                }
                
            } else {
                PostItemView(post)
                    .padding(.vertical, 8)
            }
        }.listStyle(PlainListStyle())
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListingView(sampleDataList)
            ListingView(sampleDataList)
                .preferredColorScheme(.dark)
        }
    }
}