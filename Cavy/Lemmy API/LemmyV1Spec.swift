//
//  LemmyV1Spec.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

class LemmyV1Spec {
    private(set) var factory: LemmyAPIFactory
    
    init(_ host: String) {
        self.factory = LemmyAPIFactory(host, .v1)
    }
    
    func fetchSite() -> Spec<URLRequest, LemmySiteResponse> {
        Spec(factory.fetchSite())
    }

    func listPosts(type: LemmyAPIFactory.PostType, sort: LemmyAPIFactory.SortType, limit: Int = 50) -> Spec<URLRequest, LemmyPostItemResponse> {
        Spec(factory.listPosts(type: type, sort: sort, limit: limit))
    }

    func listPosts(type: LemmyAPIFactory.PostType, sort: LemmyAPIFactory.SortType, limit: Int = 50, communityID: Int) -> Spec<URLRequest, LemmyPostItemResponse> {
        Spec(factory.listPosts(type: type, sort: sort, limit: limit, communityID: communityID))
    }

    func listCommunities(sort: LemmyAPIFactory.SortType, page: Int = 1, limit: Int = 50) -> Spec<URLRequest, LemmyCommunitiesResponse> {
        Spec(factory.listCommunities(sort: sort, page: page, limit: limit))
    }

    func fetchPost(id: Int) -> Spec<URLRequest, LemmyPostResponse> {
        Spec(factory.fetchPost(id: id))
    }
    
    func login(usernameOrEmail: String, password: String) -> Spec<URLRequest, LemmyLoginResponse> {
        Spec(factory.login(usernameOrEmail: usernameOrEmail, password: password))
    }
}
