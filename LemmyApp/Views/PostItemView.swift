//
//  PostItemView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import SwiftUI

struct PostItemView: View {
    let postItem: LemmyPostItem
    
    init(_ postItem: LemmyPostItem) {
        self.postItem = postItem
    }
    
    var timeAgoText: String {
        guard let publishedDate = postItem.publishedDate else { return "??" }
        
        let now = Date()
        let interval = now.timeIntervalSince(publishedDate)
        return abbreviatedTimeInterval(of: interval)
    }
    
    var timeAgoDetail: some View {
        Text(timeAgoText)
            .foregroundColor(.secondary)
    }
    
    var commentsDetail: some View {
        HStack(spacing: 4) {
            Image(systemName: "bubble.left")
            Text("\(postItem.numberOfComments ?? 0) \(postItem.numberOfComments == 1 ? "comment" : "comments")")
        }.foregroundColor(.secondary)
    }
    
    var authorDetail: some View {
        Text(postItem.authorName)
            .foregroundColor(.accentColor)
    }
    
    func communityDetail(_ communityName: String) -> some View {
        Text(communityName)
            .foregroundColor(.green)
    }
    
    var domainDetail: some View {
        Text(postItem.domain)
            .italic()
            .foregroundColor(.secondary)
    }
    
    var scoreText: String {
        "\(postItem.score)"
    }
    
    var scoreDetail: some View {
        HStack(alignment: .center, spacing: 2) {
            Image(systemName: "arrow.up")
            Text(scoreText)
        }.font(.system(size: 12.0, weight: .regular))
    }
    
    var bulletSeperator: some View {
        return BulletSeperator()
            .foregroundColor(.secondary)
            .opacity(0.5)
    }
    
    var metadataView: some View {
        VStack(spacing: 4.0) {
            HStack {
                authorDetail
                if let communityName = postItem.communityName {
                    communityDetail(communityName)
                }
                domainDetail
                Spacer()
            }
            .font(.system(size: 12.0))
            
            HStack(spacing: 4) {
                scoreDetail
                bulletSeperator
                commentsDetail
                bulletSeperator
                timeAgoDetail
                Spacer()
            }
            .font(.system(size: 12.0))
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if let thumbnailURL = postItem.imageURL {
                LoadingThumbnailView(thumbnailURL)
            }

            VStack(alignment: .leading, spacing: 4.0) {
                Text(postItem.title)
                    .bold()
                    .font(.system(size: 14.0))
                
                metadataView
            }
        }
    }
}

struct LoadingThumbnailView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(_ imageURL: URL) {
        imageLoader = ImageLoader(imageURL)
    }
    
    var body: some View {
        LoadStateView(imageLoader.state) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .onAppear(perform: imageLoader.load)
        .frame(width: 44, height: 44, alignment: .center)
        .background(Color(white: 0.5).opacity(0.2))
        .cornerRadius(4.0)
    }
}

struct PostItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            PostItemView(post)
                .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
            
            PostItemView(post)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
        }
    }
    
    static let post = LemmyPostItem.fromJSON("""
                {
                    "id": 48420,
                    "name": "Parler partially reappears with support from Russian technology firm",
                    "url": "https://www.reuters.com/article/us-usa-trump-parler-russia/parler-partially-reappears-with-support-from-russian-technology-firm-idUSKBN29N23N",
                    "body": null,
                    "creator_id": 15857,
                    "community_id": 14788,
                    "removed": false,
                    "locked": false,
                    "published": "2021-01-19T03:07:42.264058",
                    "updated": null,
                    "deleted": false,
                    "nsfw": false,
                    "stickied": false,
                    "embed_title": "Parler partially reappears with support from Russian technology firm",
                    "embed_description": "Parler, a social media website and app popular with the American far right, has partially returned online with the help of a Russian-owned technology company.",
                    "embed_html": null,
                    "thumbnail_url": "https://lemmy.ml/pictrs/image/wIrbfyFVRE.jpg",
                    "ap_id": "https://lemmy.ca/post/1718",
                    "local": false,
                    "creator_actor_id": "https://lemmy.ca/u/Rumblestiltskin",
                    "creator_local": false,
                    "creator_name": "Rumblestiltskin",
                    "creator_preferred_username": null,
                    "creator_published": "2021-01-12T14:40:01.101692",
                    "creator_avatar": null,
                    "banned": false,
                    "banned_from_community": false,
                    "community_actor_id": "https://lemmy.ml/c/worldnews",
                    "community_local": true,
                    "community_name": "worldnews",
                    "community_icon": null,
                    "community_removed": false,
                    "community_deleted": false,
                    "community_nsfw": false,
                    "number_of_comments": 12,
                    "score": 1,
                    "upvotes": 1,
                    "downvotes": 0,
                    "hot_rank": 1635,
                    "hot_rank_active": 1635,
                    "newest_activity_time": "2021-01-19T03:07:42.264058",
                    "user_id": null,
                    "my_vote": null,
                    "subscribed": null,
                    "read": null,
                    "saved": null
                }
                """)
}
