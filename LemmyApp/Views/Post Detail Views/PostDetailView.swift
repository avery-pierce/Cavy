//
//  PostDetailView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct PostDetailView: View {
    let post: LemmyPostItem
    
    @Environment(\.lemmyAPIClient) var client: LemmyAPIClient
    @ObservedObject var postModel: PostModel
    
    init(post: LemmyPostItem) {
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
                                    leading: 8,
                                    bottom: 8,
                                    trailing: 8)
    
    func dumpIt() {
        do {
            let jsonData = try JSONEncoder().encode(post)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? "did not decode string"
            print(jsonString)
        } catch let error {
            print("Unable to encode post:", error)
        }
    }
    
    var body: some View {
        List() {
            PostContentView(post)
            LoadStateView(postModel.loadState) { post in
                CommentsListView(post.comments)
                    .listRowInsets(listEdgeInsets)
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
        .navigationBarItems(trailing: Button(action: dumpIt, label: { Image(systemName: "tray.and.arrow.down") }))
        .onAppear(perform: refresh)
        
        // FIXME: I want animation when a comment is collapsed/shown, but not anywhere else.
        .animation(.linear)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(post: sampleData)
        }.environment(\.lemmyAPIClient, .lemmyML)
    }
}
