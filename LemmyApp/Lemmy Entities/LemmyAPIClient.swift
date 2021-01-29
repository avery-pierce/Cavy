//
//  LemmyAPIClient.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

class LemmyV2APIClient {
    static let lemmyML = LemmyV2APIClient("lemmy.ml")
    
    private(set) var factory: LemmyAPIFactory
    
    init(_ host: String) {
        self.factory = LemmyAPIFactory(host, .v2)
    }
    
    func fetchSite() -> Spec<URLRequest, LemmySiteResponseV2> {
        return Spec(factory.fetchSite())
    }

    func listPosts(type: LemmyAPIFactory.PostType, sort: LemmyAPIFactory.SortType, limit: Int = 50) -> Spec<URLRequest, LemmyPostItemResponseV2> {
        return Spec(factory.listPosts(type: type, sort: sort, limit: limit), as: LemmyPostItemResponseV2.self)
    }

    func listPosts(type: LemmyAPIFactory.PostType, sort: LemmyAPIFactory.SortType, limit: Int = 50, communityID: Int) -> Spec<URLRequest, LemmyPostItemResponseV2> {
        return Spec(factory.listPosts(type: type, sort: sort, limit: limit, communityID: communityID), as: LemmyPostItemResponseV2.self)
    }

    func listCommunities(sort: LemmyAPIFactory.SortType, page: Int = 1, limit: Int = 50) -> Spec<URLRequest, LemmyCommunitiesResponseV2> {
        return Spec(factory.listCommunities(sort: sort, page: page, limit: limit), as: LemmyCommunitiesResponseV2.self)
    }

    func fetchPost(id: Int) -> Spec<URLRequest, LemmyPostResponseV2> {
        return Spec(factory.fetchPost(id: id), as: LemmyPostResponseV2.self)
    }
}

