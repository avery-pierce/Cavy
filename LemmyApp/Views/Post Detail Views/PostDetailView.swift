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
    @ObservedObject var imageLoader: ImageLoader
    
    init(post: LemmyPostItem) {
        self.post = post
        self.postModel = PostModel(postID: post.id)
        
        // FIXME: Handle this better
        let thumbnailURL = post.imageURL ?? URL(string: "https://www.example.com")!
        self.imageLoader = ImageLoader(thumbnailURL)
        
        if hasThumbnail {
            self.imageLoader.load()
        }
    }
    
    var hasThumbnail: Bool {
        return post.imageURL != nil
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
    
    var webLink: URL? {
        switch post.destination {
        case .web(let url):
            return url
        default: return nil
        }
    }
    
    let listEdgeInsets = EdgeInsets(top: 8,
                                    leading: 8,
                                    bottom: 8,
                                    trailing: 8)
    
    var timeAgoText: String {
        guard let publishedDate = post.publishedDate else { return "??" }
        
        let now = Date()
        let interval = now.timeIntervalSince(publishedDate)
        return abbreviatedTimeInterval(of: interval)
    }
    
    var body: some View {
        List() {
            VStack(alignment: .leading, spacing: 12) {
                if let title = post.title {
                    Text(title)
                        .font(.system(size: 18.0))
                        .bold()
                }
                
                if let body = post.body {
                    Text(body).font(.system(size: 14.0))
                }
                
                if let url = webLink {
                    Link(destination: url) {
                        ArticleSummaryView(post, thumbnailState: self.hasThumbnail ? imageLoader.state : nil)
                    }
                }
                
                HStack {
                    Text(post.authorName)
                        .foregroundColor(.accentColor)
                    
                    if let communityName = post.communityName {
                        Text(communityName)
                            .foregroundColor(.green)
                    }
                    
                    Text(timeAgoText)
                        .foregroundColor(.secondary)
                    
                    Text(post.domain)
                        .italic()
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .font(.system(size: 12.0))
            }
            .padding(.top, 4)
            .listRowInsets(listEdgeInsets)
            
            LoadStateView(postModel.loadState) { post in
                CommentsListView(post.comments)
                    .listRowInsets(listEdgeInsets)
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
        .onAppear(perform: refresh)
        
        // FIXME: I want animation when a comment is collapsed/shown, but not anywhere else.
        .animation(.linear)
    }
    
    func printMe() {
        print(post)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(post: sampleData)
        }.environment(\.lemmyAPIClient, .lemmyML)
    }
}
