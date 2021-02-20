//
//  PostDetailView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct PostDetailView: View {
    let post: CavyPost
    
    @Environment(\.lemmyAPIClient) var client: LemmyAPIClient
    @ObservedObject var postModel: PostModel
    @EnvironmentObject var rootModel: RootModel
    
    init(post: CavyPost) {
        self.post = post
        self.postModel = PostModel(postID: post.id)
    }
    
    func refresh() {
        rootModel.markAsRead(post)
        postModel.client = client
        postModel.refresh()
    }
    
    var title: String {
        switch postModel.loadState {
        case .complete(let result):
            switch result {
            case .success(let listing):
                return "\(listing.cavyComments.count) Comments"
            case .failure:
                return "Post Detail"
            }
        default:
            return "Loading"
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                PostContentView(post)
                LoadStateView(postModel.loadState) { listing in
                    CommentsListView(listing.cavyComments, post: post)
                        .padding(.leading, 8)
                }
                Spacer()
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
        .onAppear(perform: refresh)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(post: LemmyPostItem.sampleData.cavyPost)
        }.environment(\.lemmyAPIClient, .lemmyML)
    }
}
