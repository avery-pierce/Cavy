//
//  LemmyAPIClient.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

class LemmyV2Spec {
    static let lemmyML = LemmyV2Spec("lemmy.ml")
    
    private(set) var factory: LemmyAPIFactory
    
    init(_ host: String) {
        self.factory = LemmyAPIFactory(host, .v2)
    }
    
    func fetchSite() -> Spec<URLRequest, LemmySiteResponseV2> {
        Spec(factory.fetchSite())
    }

    func listPosts(type: LemmyAPIFactory.PostType, sort: LemmyAPIFactory.SortType, limit: Int = 50, page: Int = 1) -> Spec<URLRequest, LemmyPostItemResponseV2> {
        Spec(factory.listPosts(type: type, sort: sort, limit: limit, page: page))
    }

    func listPosts(type: LemmyAPIFactory.PostType, sort: LemmyAPIFactory.SortType, limit: Int = 50, page: Int = 1, communityID: Int) -> Spec<URLRequest, LemmyPostItemResponseV2> {
        Spec(factory.listPosts(type: type, sort: sort, limit: limit, page: page, communityID: communityID))
    }

    func listCommunities(sort: LemmyAPIFactory.SortType, page: Int = 1, limit: Int = 50) -> Spec<URLRequest, LemmyCommunitiesResponseV2> {
        Spec(factory.listCommunities(sort: sort, page: page, limit: limit))
    }

    func fetchPost(id: Int) -> Spec<URLRequest, LemmyPostResponseV2> {
        Spec(factory.fetchPost(id: id))
    }
    
    func login(usernameOrEmail: String, password: String) -> Spec<URLRequest, LemmyLoginResponse> {
        Spec(factory.login(usernameOrEmail: usernameOrEmail, password: password))
    }
    
    /// `score` can be 0, -1, or 1
    func vote(_ score: Int, onPostID postID: Int) -> Spec<URLRequest, LemmyPostResponseV2> {
        Spec(factory.vote(score, postID: postID))
    }
}


