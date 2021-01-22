//
//  PostContentView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct PostContentView: View {
    let post: LemmyPostItem

    @ObservedObject var imageLoader: ImageLoader

    init(_ post: LemmyPostItem) {
        self.post = post
        
        let url = post.url ?? URL(string: "http://www.example.com")!
        self.imageLoader = ImageLoader(url)
        
        if hasThumbnail {
            self.imageLoader.load()
        }
    }
    
    var hasThumbnail: Bool {
        return post.imageURL != nil
    }
    
    let listEdgeInsets = EdgeInsets(top: 8,
                                    leading: 8,
                                    bottom: 8,
                                    trailing: 8)
    
    var articleSummaryView: some View {
        let summaryTitle = post.embedTitle == post.title ? nil : post.embedTitle
        let thumbnailState = post.thumbnailURL != nil ? imageLoader.state : nil
        
        return ArticleSummaryView(title: summaryTitle, description: post.embedDescription, destinationURL: post.url, thumbnailState: thumbnailState)
    }
    
    var timeAgoText: String {
        guard let publishedDate = post.publishedDate else { return "??" }
        
        let now = Date()
        let interval = now.timeIntervalSince(publishedDate)
        return abbreviatedTimeInterval(of: interval)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title = post.title {
                Text(title)
                    .font(.system(size: 18.0))
                    .bold()
            }
            
            if let body = post.body {
                Text(body).font(.system(size: 14.0))
            }
            
            if let url = post.url {
                Link(destination: url) {
                    articleSummaryView
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
    }
}
