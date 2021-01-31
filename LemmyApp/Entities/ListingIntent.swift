//
//  ListingIntent.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import Foundation

/// Provides all arguments necessary to get a listing.
struct ListingIntent {
    let client: LemmyAPIClient
    
    var postType: LemmyAPIFactory.PostType = .all
    var sortType: LemmyAPIFactory.SortType = .hot
    var communityID: Int? = nil
    var limit: Int = 50
    
    /// The explicit title of the intent when presented to the user
    var explicitTitle: String? = nil
    
    /// The explicit detail of the intent when presented to the user
    var explicitDetail: String? = nil
    
    /// User-friendly string to communicate where this intent goes. Suitable for presenting in UI
    var title: String {
        if let title = explicitTitle { return title }
        
        switch postType {
        case .community: return "Community"
        case .all: return "All Posts"
        case .subscribed: return "Subscribed"
        }
    }
    
    /// User-friendly string to communicate where this intent goes. Suitable for presenting in UI
    var detail: String {
        return explicitDetail ?? client.host
    }
    
    init(_ client: LemmyAPIClient, postType: LemmyAPIFactory.PostType = .all, sortType: LemmyAPIFactory.SortType = .hot, limit: Int = 50) {
        self.client = client
        self.postType = postType
        self.sortType = sortType
        self.limit = limit
    }
    
    static func frontPage(of client: LemmyAPIClient) -> ListingIntent {
        var intent = ListingIntent(client)
        intent.explicitTitle = "Front Page"
        return intent
    }
    
    static func community(_ client: LemmyAPIClient, _ community: CavyCommunity) -> ListingIntent {
        var intent = ListingIntent(client, postType: .community)
        intent.communityID = community.id
        intent.explicitTitle = community.title ?? community.name
        intent.explicitDetail = "\(client.host)/c/\(community.name)"
        return intent
    }
    
    func createResource() -> ParsedDataResource<CavyPostListing> {
        switch client {
        case .v1(let spec):
            if let communityID = communityID {
                return ParsedDataResource(spec.listPosts(type: postType, sort: sortType, limit: limit, communityID: communityID))
            } else {
                return ParsedDataResource(spec.listPosts(type: postType, sort: sortType, limit: limit))
            }
        case .v2(let spec):
            if let communityID = communityID {
                return ParsedDataResource(spec.listPosts(type: postType, sort: sortType, limit: limit, communityID: communityID))
            } else {
                return ParsedDataResource(spec.listPosts(type: postType, sort: sortType, limit: limit))
            }
        }
    }
    
    func createFlatPack() -> FlatPack {
        FlatPack(clientDescriptor: client.descriptor, postType: postType, sortType: sortType, communityID: communityID, limit: limit, explicitTitle: explicitTitle, explicitDetail: explicitDetail)
    }
    
    init(_ flatPack: FlatPack) {
        self.client = LemmyAPIClient(descriptor: flatPack.clientDescriptor)
        self.postType = flatPack.postType
        self.sortType = flatPack.sortType
        self.communityID = flatPack.communityID
        self.limit = flatPack.limit ?? 50
        self.explicitTitle = flatPack.explicitTitle
        self.explicitDetail = flatPack.explicitDetail
    }
    
    struct FlatPack: Codable, Equatable, Hashable {
        var clientDescriptor: String
        var postType: LemmyAPIFactory.PostType
        var sortType: LemmyAPIFactory.SortType
        var communityID: Int?
        var limit: Int?
        var explicitTitle: String?
        var explicitDetail: String?
    }
    
    /// Should be unique
    var fakeHashValue: Int {
        return createFlatPack().hashValue
    }
}

extension ListingIntent: Equatable {
    static func == (lhs: ListingIntent, rhs: ListingIntent) -> Bool {
        return lhs.createFlatPack() == rhs.createFlatPack()
    }
}
