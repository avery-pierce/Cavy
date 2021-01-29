//
//  PostContentView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct PostContentView: View {
    let post: CavyPost

    // TODO: Refactor these to use Loader pattern
    @ObservedObject var thumbnailImageLoader: ImageLoader
    @ObservedObject var imageLoader: ImageLoader

    init(_ post: CavyPost) {
        self.post = post
        
        let thumbnailURL = post.thumbnailURL ?? URL(string: "http://www.example.com")!
        self.thumbnailImageLoader = ImageLoader(thumbnailURL)
        
        let url = post.linkURL ?? URL(string: "http://www.example.com")!
        self.imageLoader = ImageLoader(url)
        
        if hasThumbnail {
            self.thumbnailImageLoader.load()
        }
        
        if post.linkURL?.kind == LinkKind.image {
            self.imageLoader.load()
        }
    }
    
    var hasThumbnail: Bool {
        return post.thumbnailURL != nil
    }
    
    let listEdgeInsets = EdgeInsets(top: 8,
                                    leading: 8,
                                    bottom: 8,
                                    trailing: 8)
    
    var articleSummaryView: some View {
        let summaryTitle = post.embed?.title == post.title ? nil : post.embed?.title
        let thumbnailState = post.thumbnailURL != nil ? thumbnailImageLoader.state : nil
        
        return ArticleSummaryView(title: summaryTitle, description: post.embed?.description, destinationURL: post.linkURL, thumbnailState: thumbnailState)
    }
    
    var timeAgoText: String {
        guard let publishedDate = post.publishDate else { return "??" }
        
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
            
            if let url = post.linkURL, url.kind == LinkKind.image {
                Link(destination: url) {
                    HStack(alignment: .center) {
                        Spacer()
                        largeImageView
                        Spacer()
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                if let body = post.bodyMarkdown {
                    MarkdownText(body).font(.system(size: 14.0))
                }
                
                if let url = post.linkURL, url.kind == LinkKind.web {
                    Link(destination: url) {
                        articleSummaryView
                    }
                }
                
                HStack {
                    if let submitter = post.submitterName {
                        Text(submitter)
                            .foregroundColor(.accentColor)
                    }
                    
                    if let communityName = post.communityName {
                        Text(communityName)
                            .foregroundColor(.green)
                    }
                    
                    Text(timeAgoText)
                        .foregroundColor(.secondary)
                    
                    if let domain = post.domain {
                        Text(domain)
                            .italic()
                            .foregroundColor(.secondary)
                    }
                    
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
            PostContentView(LemmyPostItem.sampleData.cavyPost)
        }.previewLayout(.sizeThatFits)
    }
}
