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
    
    @State var safariURL: URL? = nil
    @State var isSafariShown: Bool = false
    
    var body: some View {
        List(posts, id: \.id) { post in
            if let destination = post.destination {
                switch destination {
                case .web:
                    NavigationLink(
                        destination: PostDetailView(post: post)) {
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
        }
        .listStyle(PlainListStyle())
        .sheet(isPresented: $isSafariShown) {
            OptionalSafariView(url:safariURL)
        }
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
