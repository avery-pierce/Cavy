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
    
    var token: String? = nil
    var username: String? = nil
    
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
    
    enum PostType: String, Codable {
        case all = "All"
        case subscribed = "Subscribed"
        case community = "Community"
    }
    
    enum SortType: String, Codable {
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
        if let token = token {
            return path("api/\(v)/post/list?type_=\(type.rawValue)&sort=\(sort.rawValue)&limit=\(limit)&auth=\(token)")
        } else {
            return path("api/\(v)/post/list?type_=\(type.rawValue)&sort=\(sort.rawValue)&limit=\(limit)")
        }
    }
    
    func listPosts(type: PostType, sort: SortType, limit: Int = 50, communityID: Int) -> URLRequest {
        // It looks strange, but yes, the `type_` argument includes the underscore.
        return path("api/\(v)/post/list?type_=\(type.rawValue)&sort=\(sort.rawValue)&limit=\(limit)&community_id=\(communityID)")
    }
    
    func listCommunities(type: PostType = .all, sort: SortType, page: Int = 1, limit: Int = 50) -> URLRequest {
        return path("api/\(v)/community/list?type_=\(type.rawValue)&sort=\(sort.rawValue)&page=\(page)&limit=\(limit)")
    }
    
    func fetchPost(id: String) -> URLRequest {
        return path("api/\(v)/post?id=\(id)")
    }
    
    func login(usernameOrEmail: String, password: String) -> URLRequest {
        var request = path("api/\(v)/user/login")
        try! request.postData(LemmyLoginRequest(usernameOrEmail: usernameOrEmail, password: password))
        return request
    }
    
    func fetchPost(id: Int) -> URLRequest {
        return fetchPost(id: String(id))
    }
    
    func path(_ path: String) -> URLRequest {
        let url = URL(string: "https://\(host)/\(path)")!
        var request = URLRequest(url: url)
        request.addDefaultHeaders()
        return request
    }
    
    private var v: String {
        return version.rawValue
    }
}

private extension URLRequest {
    mutating func addDefaultHeaders() {
        addValue("application/json", forHTTPHeaderField: "Accepts")
        addValue("Cavy mobile app by @avery_pierce on lemmy.ml", forHTTPHeaderField: "User-Agent")
    }
    
    mutating func postData<BodyType: Encodable>(_ body: BodyType) throws {
        httpMethod = "POST"
        httpBody = try JSONEncoder().encode(body)
        addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
}

private struct LemmyAPIClientEnvironmentKey: EnvironmentKey {
    static let defaultValue: LemmyAPIClient = .lemmyML
}

extension EnvironmentValues {
    var lemmyAPIClient: LemmyAPIClient {
        get { self[LemmyAPIClientEnvironmentKey.self] }
        set { self[LemmyAPIClientEnvironmentKey.self] = newValue }
    }
}

extension View {
    func lemmyAPIClient(_ client: LemmyAPIClient) -> some View {
        environment(\.lemmyAPIClient, client)
    }
}

// MARK: - Deprecated
extension LemmyAPIFactory {
    @available(*, deprecated, message: "dev.lemmy.ml has been permanently moved to lemmy.ml")
    static let devLemmyMl = LemmyAPIFactory("dev.lemmy.ml")
}
