//
//  LemmyAPIClient.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation
import SwiftUI

class LemmyAPIFactory: ObservableObject {
    var host: String
    var version: APIVersion
    init(_ host: String, _ version: APIVersion = .v1) {
        self.host = host
        self.version = version
    }
    
    static let lemmyML = LemmyAPIFactory("lemmy.ml")
    static let lemmygradML = LemmyAPIFactory("lemmygrad.ml")
    
    enum APIVersion: String {
        case v1 = "v1"
        case v2 = "v2"
    }
    
    enum PostType: String {
        case all = "All"
        case subscribed = "Subscribed"
        case community = "Community"
    }
    
    enum SortType: String {
        case active = "Active"
        case hot = "Hot"
        case new = "New"
        case topDay = "TopDay"
        case topWeek = "TopWeek"
        case topMonth = "TopMonth"
        case topYear = "TopYear"
        case topAll = "TopAll"
    }
    
    func fetchSite() -> URLRequest {
        return path("api/\(v)/site")
    }
    
    func fetchSiteConfig() -> URLRequest {
        // TODO: Requires auth
        return path("api/\(v)/site/config")
    }
    
    func listPosts(type: PostType, sort: SortType, limit: Int = 50) -> URLRequest {
        // It looks strange, but yes, the `type_` argument includes the underscore.
        return path("api/\(v)/post/list?type_=\(type.rawValue)&sort=\(sort.rawValue)&limit=\(limit)")
    }
    
    func listPosts(type: PostType, sort: SortType, limit: Int = 50, communityID: Int) -> URLRequest {
        // It looks strange, but yes, the `type_` argument includes the underscore.
        return path("api/\(v)/post/list?type_=\(type.rawValue)&sort=\(sort.rawValue)&limit=\(limit)&community_id=\(communityID)")
    }
    
    func listCommunities(sort: SortType, page: Int = 1, limit: Int = 50) -> URLRequest {
        return path("api/\(v)/community/list?sort=\(sort.rawValue)&page=\(page)&limit=\(limit)")
    }
    
    func fetchPost(id: String) -> URLRequest {
        return path("api/\(v)/post?id=\(id)")
    }
    
    func fetchPost(id: Int) -> URLRequest {
        return fetchPost(id: String(id))
    }
    
    func path(_ path: String) -> URLRequest {
        let url = URL(string: "https://\(host)/\(path)")!
        let request = URLRequest(url: url)
        return updateHeaders(of: request)
    }
    
    func updateHeaders(of request: URLRequest) -> URLRequest {
        var newRequest = request
        newRequest.addValue("application/json", forHTTPHeaderField: "Accepts")
        newRequest.addValue("Unnammed Lemmy Mobile Client by @AveryPierceApps", forHTTPHeaderField: "User-Agent")
        return newRequest
    }
    
    private var v: String {
        return version.rawValue
    }
}

private struct LemmyAPIClientEnvironmentKey: EnvironmentKey {
    static let defaultValue: LemmyAPIFactory = .lemmyML
}

extension EnvironmentValues {
    var lemmyAPIClient: LemmyAPIFactory {
        get { self[LemmyAPIClientEnvironmentKey.self] }
        set { self[LemmyAPIClientEnvironmentKey.self] = newValue }
    }
}

extension View {
    func lemmyAPIClient(_ client: LemmyAPIFactory) -> some View {
        environment(\.lemmyAPIClient, client)
    }
}

// MARK: - Deprecated
extension LemmyAPIFactory {
    @available(*, deprecated, message: "dev.lemmy.ml has been permanently moved to lemmy.ml")
    static let devLemmyMl = LemmyAPIFactory("dev.lemmy.ml")
}
