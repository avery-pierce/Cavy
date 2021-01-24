//
//  PostContentView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct PostContentView: View {
    let post: LemmyPostItem

    @ObservedObject var thumbnailImageLoader: ImageLoader
    @ObservedObject var imageLoader: ImageLoader

    init(_ post: LemmyPostItem) {
        self.post = post
        
        let thumbnailURL = post.thumbnailURL.flatMap(URL.init) ?? URL(string: "http://www.example.com")!
        self.thumbnailImageLoader = ImageLoader(thumbnailURL)
        
        let url = post.url ?? URL(string: "http://www.example.com")!
        self.imageLoader = ImageLoader(url)
        
        if hasThumbnail {
            self.thumbnailImageLoader.load()
        }
        
        if post.kind == LinkKind.image {
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
        let thumbnailState = post.thumbnailURL != nil ? thumbnailImageLoader.state : nil
        
        return ArticleSummaryView(title: summaryTitle, description: post.embedDescription, destinationURL: post.url, thumbnailState: thumbnailState)
    }
    
    var timeAgoText: String {
        guard let publishedDate = post.publishedDate else { return "??" }
        
        let now = Date()
        let interval = now.timeIntervalSince(publishedDate)
        return abbreviatedTimeInterval(of: interval)
    }
    
    var largeImageView: some View {
        VStack(alignment: .center) {
            LoadStateView(imageLoader.state) { image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(minHeight: 300, idealHeight: 500, maxHeight: 800, alignment: .center)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 12) {
                if let title = post.title {
                    Text(title)
                        .font(.system(size: 18.0))
                        .bold()
                }
            }
            .padding(EdgeInsets(top: 12, leading: 8, bottom: 8, trailing: 8))
            
            if let url = post.url, url.kind == LinkKind.image {
                Link(destination: url) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Spacer()
                        largeImageView
                        Spacer()
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                if let body = post.body {
                    MarkdownText(body).font(.system(size: 14.0))
                }
                
                if let url = post.url, url.kind == LinkKind.web {
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
            .padding(EdgeInsets(top: 12, leading: 8, bottom: 8, trailing: 8))
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct PostContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostContentView(sampleData)
        }.previewLayout(.sizeThatFits)
    }
}
