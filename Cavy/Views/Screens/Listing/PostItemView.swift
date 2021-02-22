//
//  PostItemView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import SwiftUI

struct PostItemView: View {
    @Environment(\.palette) var palette
    @EnvironmentObject var rootModel: RootModel
    
    @State private var horizontalOffset: CGFloat = 0.0
    @State private var myVote: Int
    private let thumbnailResource: ParsedDataResource<UIImage>?
    
    let postItem: CavyPost
    
    typealias VoteChangedCallback = ((_ newVote: Int) -> Void)
    let onVoteChanged: VoteChangedCallback?
    
    init(_ postItem: CavyPost, onVoteChanged: VoteChangedCallback? = nil) {
        if let thumbnailURL = postItem.thumbnailURL {
            let thumbnailCacher = CachingDataProvider(thumbnailURL)
            self.thumbnailResource = ParsedDataResource(thumbnailCacher, parsedBy: imageParser)
        } else {
            self.thumbnailResource = nil
        }
        
        self.postItem = postItem
        self.onVoteChanged = onVoteChanged
        self._myVote = .init(wrappedValue: postItem.myVote ?? 0)
    }
    
    var timeAgoText: String {
        guard let publishedDate = postItem.publishDate else { return "??" }
        
        let now = Date()
        let interval = now.timeIntervalSince(publishedDate)
        return abbreviatedTimeInterval(of: interval)
    }
    
    var timeAgoDetail: some View {
        Text(timeAgoText)
            .foregroundColor(.secondary)
    }
    
    var commentsDetail: some View {
        HStack(spacing: 2) {
            Image(systemName: "bubble.right")
            Text("\(postItem.numComments ?? 0) \(postItem.numComments == 1 ? "comment" : "comments")")
        }.foregroundColor(.secondary)
    }
    
    func authorDetail(_ authorName: String) -> some View {
        Text(authorName)
            .foregroundColor(postItem.isSubmitterAdmin ? palette.adminUsername : palette.opCommentUsername)
    }
    
    func communityDetail(_ communityName: String) -> some View {
        Text(communityName)
            .foregroundColor(palette.communityName)
    }
    
    var bulletSeperator: some View {
        return BulletSeperator()
            .foregroundColor(.secondary)
            .opacity(0.5)
    }
    
    var isRead: Bool {
        postItem.isRead || rootModel.readIds.contains(postItem.apID)
    }
    
    var resolvedScore: Int? {
        guard let actualScore = postItem.score else { return nil }
        
        // remove my vote from the lemmy total, and replace it with the
        // vote in app state, which may be ahead of the actual score
        return actualScore - (postItem.myVote ?? 0) + myVote
    }
    
    var metadataView: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            HStack {
                if let author = postItem.submitterName {
                    authorDetail(author)
                }
                
                if let communityName = postItem.communityName {
                    communityDetail(communityName)
                }
                
                Spacer()
            }
            
            HStack(spacing: 4) {
                ScoreView(score: resolvedScore, myVote: myVote)
                bulletSeperator
                commentsDetail
                bulletSeperator
                timeAgoDetail
                Spacer()
            }
        }
        .font(.system(size: 12.0))
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let thumbnailResource = thumbnailResource {
                Loader(thumbnailResource) { loadState in
                    PostItemCellThumbnailView(loadState)
                }
            } else {
                PostItemCellThumbnailText()
            }
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(postItem.title ?? "")
                    .bold()
                    .font(.system(size: 14.0))
                    .foregroundColor(isRead ? .secondary : .primary)
                
                metadataView
            }
            
            if let onVoteChanged = onVoteChanged {
                VotingArrows(myVote: myVote) { (newVote) in
                    myVote = newVote
                    onVoteChanged(newVote)
                }
            }
        }
        .padding(EdgeInsets(top: 12.0, leading: 8.0, bottom: 12.0, trailing: 8.0))
    }
}

struct PostItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            Themed {
                PostItemView(postUpvoted, onVoteChanged: { _ in })
                    .previewLayout(.fixed(width: 400.0, height: 100.0))
                
                PostItemView(postUpvoted, onVoteChanged: { _ in })
                    .preferredColorScheme(.dark)
                    .previewLayout(.fixed(width: 400.0, height: 100.0))
                
                PostItemView(postDownvoted, onVoteChanged: { _ in })
                    .previewLayout(.fixed(width: 400.0, height: 100.0))
                
                PostItemView(postDownvoted, onVoteChanged: { _ in })
                    .preferredColorScheme(.dark)
                    .previewLayout(.fixed(width: 400.0, height: 100.0))
                
                PostItemView(postWithoutThumbnail)
                    .previewLayout(.fixed(width: 400.0, height: 100.0))
                
                PostItemView(postWithoutThumbnail)
                    .preferredColorScheme(.dark)
                    .previewLayout(.fixed(width: 400.0, height: 100.0))
            }
        }.rootModel(RootModel())
    }
    
    static var postWithoutThumbnail: CavyPost {
        var p = self.post
        p.thumbnailURL = nil
        return p
    }
    
    static var postUpvoted: CavyPost {
        var upvotedPost = post
        upvotedPost.score! += 1
        upvotedPost.myVote = 1
        return upvotedPost
    }
    
    static var postDownvoted: CavyPost {
        var downvotedPost = post
        downvotedPost.score! -= 1
        downvotedPost.myVote = -1
        return downvotedPost
    }
    
    static let post = try! LemmyPostItem.fromJSON("""
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
                    "my_vote": 0,
                    "subscribed": null,
                    "read": null,
                    "saved": null
                }
                """).cavyPost
    

}
