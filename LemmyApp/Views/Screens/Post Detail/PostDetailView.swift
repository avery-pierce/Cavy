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
    
    init(post: CavyPost) {
        self.post = post
        self.postModel = PostModel(postID: post.id)
    }
    
    func refresh() {
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
    
    let listEdgeInsets = EdgeInsets(top: 8,
                                    leading: 8,
                                    bottom: 8,
                                    trailing: 8)
    
    var body: some View {
        List() {
            PostContentView(post)
            LoadStateView(postModel.loadState) { listing in
                CommentsListView(listing.cavyComments)
                    .listRowInsets(listEdgeInsets)
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
        .onAppear(perform: refresh)
        
        // FIXME: I want animation when a comment is collapsed/shown, but not anywhere else.
        .animation(.linear)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(post: LemmyPostItem.sampleData.cavyPost)
        }.environment(\.lemmyAPIClient, .lemmyML)
    }
}
