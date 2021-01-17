//
//  PostDetailView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct PostDetailView: View {
    let post: PostItem
    @Environment(\.lemmyAPIClient) var client: LemmyAPIClient
    @ObservedObject var postModel: PostModel
    
    init(post: PostItem) {
        self.post = post
        self.postModel = PostModel(postID: post.id)
    }
    
    func refresh() {
        print("Refreshing")
        postModel.client = client
        postModel.refresh()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(post.body ?? "No Body Content")
            }
            
            LoadStateView(postModel.loadState) { post in
                CommentsListView(comments: post.comments)
            }
        }.onAppear(perform: refresh)
    }
    
    func printMe() {
        print(post)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(post: sampleData)
        }.environmentObject(LemmyAPIClient.devLemmyMl)
    }
}
