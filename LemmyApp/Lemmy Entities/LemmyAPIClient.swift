//
//  LemmyAPIClient.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation
import SwiftUI

class LemmyAPIClient: ObservableObject {
    var host: String
    init(_ host: String) {
        self.host = host
    }
    
    static let devLemmyMl = LemmyAPIClient("dev.lemmy.ml")
    static let lemmygradML = LemmyAPIClient("lemmygrad.ml")
    
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
    
    func listPosts(type: PostType, sort: SortType) -> URLRequest {
        return path("api/v1/post/list?type_=\(type.rawValue)&sort=\(sort.rawValue)")
    }
    
    func listCommunities(sort: SortType) -> URLRequest {
        return path("api/v1/community/list?sort=\(sort.rawValue)")
    }
    
    func fetchPost(id: String) -> URLRequest {
        return path("api/v1/post?id=\(id)")
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
}

private struct LemmyAPIClientEnvironmentKey: EnvironmentKey {
    static let defaultValue: LemmyAPIClient = .devLemmyMl
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
