//
//  LemmyAPIClient.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct APIDataProvider<D: DataProvider, T: Codable> {
    var dataProvider: D
    var serializedType: T.Type
    
    init(_ dataProvider: D, as serializedType: T.Type) {
        self.dataProvider = dataProvider
        self.serializedType = serializedType
    }
}

class LemmyV2APIClient {
    static let lemmyML = LemmyV2APIClient("lemmy.ml")
    
    private(set) var factory: LemmyAPIFactory
    
    init(_ host: String) {
        self.factory = LemmyAPIFactory(host, .v2)
    }
    
//    func fetchSite() -> URLRequest {
//        return path("api/\(v)/site")
//    }
//
//    func fetchSiteConfig() -> URLRequest {
//        // TODO: Requires auth
//        return path("api/\(v)/site/config")
//    }

    func listPosts(type: LemmyAPIFactory.PostType, sort: LemmyAPIFactory.SortType, limit: Int = 50) -> APIDataProvider<URLRequest, LemmyPostItemResponseV2> {
        return APIDataProvider(factory.listPosts(type: type, sort: sort, limit: limit), as: LemmyPostItemResponseV2.self)
    }

    func listPosts(type: LemmyAPIFactory.PostType, sort: LemmyAPIFactory.SortType, limit: Int = 50, communityID: Int) -> APIDataProvider<URLRequest, LemmyPostItemResponseV2> {
        return APIDataProvider(factory.listPosts(type: type, sort: sort, limit: limit, communityID: communityID), as: LemmyPostItemResponseV2.self)
    }

    func listCommunities(sort: LemmyAPIFactory.SortType, page: Int = 1, limit: Int = 50) -> APIDataProvider<URLRequest, LemmyCommunitiesResponseV2> {
        return APIDataProvider(factory.listCommunities(sort: sort, page: page, limit: limit), as: LemmyCommunitiesResponseV2.self)
    }

//    func fetchPost(id: String) -> URLRequest {
//        return path("api/\(v)/post?id=\(id)")
//    }
//
//    func fetchPost(id: Int) -> URLRequest {
//        return fetchPost(id: String(id))
//    }
    
}

