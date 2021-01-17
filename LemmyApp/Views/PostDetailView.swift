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
    
    var title: String {
        switch postModel.loadState {
        case .complete(let result):
            switch result {
            case .success(let post):
                return "\(post.comments.count) Comments"
            case .failure:
                return "Post Detail"
            }
        default:
            return "Loading"
        }
    }
    
    let listEdgeInsets = EdgeInsets(top: 8,
                                    leading: 12,
                                    bottom: 8,
                                    trailing: 8)
    
    var body: some View {
        List() {
            VStack(alignment: .leading, spacing: 12) {
                if let title = post.title {
                    Text(title)
                        .font(.system(size: 18.0))
                        .bold()
                }
                Text(post.body ?? "No Body Content")
                    .font(.system(size: 14.0))
            }
            .padding(.top, 4)
            .listRowInsets(listEdgeInsets)
            
            LoadStateView(postModel.loadState) { post in
                CommentsListView(comments: post.comments).listRowInsets(listEdgeInsets)
            }
        }
        
        .navigationBarTitle(title, displayMode: .inline)
        .onAppear(perform: refresh)
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
