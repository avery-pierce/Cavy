//
//  ArticleSummaryView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct ArticleSummaryView<E: Error>: View {
    
    var title: String?
    var description: String?
    var thumbnailState: LoadState<UIImage, E>?
    var destinationURL: String?
    
    init(_ post: LemmyPostItem, thumbnailState: LoadState<UIImage, E>?) {
        self.init(title: post.embedTitle, description: post.embedDescription, destinationURL: post.url, thumbnailState: thumbnailState)
    }
    
    init(title: String?, description: String?, destinationURL: URL?, thumbnailState: LoadState<UIImage, E>?) {
        self.init(title: title, description: description, destinationURL: destinationURL?.absoluteString, thumbnailState: thumbnailState)
    }
    
    init(title: String?, description: String?, destinationURL: String?, thumbnailState: LoadState<UIImage, E>?) {
        self.title = title
        self.description = description
        self.destinationURL = destinationURL
        self.thumbnailState = thumbnailState
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12.0) {
            if let thumbnailState = thumbnailState {
                LoadStateView(thumbnailState) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 60.0, height: 60.0)
                .background(Color(white: 0.8))
            }
            
            VStack(alignment: .leading, spacing: 4.0) {
                if let title = title {
                    Text(title)
                        .font(.system(size: 14.0, weight: .bold))
                        
                }
                
                if let description = description {
                    Text(description)
                        .font(.system(size: 14.0, weight: .regular))
                }
                
                if let destinationURL = destinationURL {
                    Text(destinationURL)
                        .lineLimit(1)
                        .font(.system(size: 14.0, weight: .regular))
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.vertical, 8.0)
            .padding(.trailing, 8.0)
            
            Spacer()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.secondary, lineWidth: 1)
        )
        .cornerRadius(8.0)
    }
}

struct ArticleSummaryView_Previews: PreviewProvider {
    static let samplePost = LemmyPostItem.fromJSON("""
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
    
    static var previews: some View {
        Group {
            ArticleSummaryView<Error>(title: "New Post", description: "Hello World", destinationURL: "http://www.example.com", thumbnailState: .loading(nil))
                .padding()
                .previewLayout(.sizeThatFits)
            
            ArticleSummaryView<Error>(samplePost, thumbnailState: .loading(50))
        }
    }
}
