//
//  PostContentView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct PostContentView: View {
    @Environment(\.palette) var palette
    
    let post: CavyPost

    init(_ post: CavyPost) {
        self.post = post
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
        return VStack {
            if let thumbnailURL = post.thumbnailURL {
                Loader(CachingDataProvider(thumbnailURL), parsedBy: imageParser) { thumbnailState in
                    ArticleSummaryView(title: summaryTitle, description: post.embed?.description, destinationURL: post.linkURL, thumbnailState: thumbnailState)
                }
            } else {
                ArticleSummaryView(title: summaryTitle, description: post.embed?.description, destinationURL: post.linkURL, thumbnailState: nil)
            }
        }
    }
    
    var timeAgoText: String {
        guard let publishedDate = post.publishDate else { return "??" }
        
        let now = Date()
        let interval = now.timeIntervalSince(publishedDate)
        return abbreviatedTimeInterval(of: interval)
    }
    
    var largeImageView: some View {
        VStack(alignment: .center) {
            if let imageURL = post.linkURL, imageURL.kind == LinkKind.image {
                Link(destination: imageURL) {
                    Loader(CachingDataProvider(imageURL), parsedBy: imageParser) { state in
                        HStack(alignment: .center) {
                            LoadStateView(state) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                }
            } else {
                EmptyView()
            }
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
            
            largeImageView 
            
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
                    ScoreView(post)
                    
                    if let submitter = post.submitterName {
                        Text(submitter)
                            .foregroundColor(palette.opCommentUsername)
                    }
                    
                    if let communityName = post.communityName {
                        Text(communityName)
                            .foregroundColor(palette.communityName)
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
    }
}

struct PostContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostContentView(LemmyPostItem.sampleData.cavyPost)
        }.previewLayout(.sizeThatFits)
    }
}
