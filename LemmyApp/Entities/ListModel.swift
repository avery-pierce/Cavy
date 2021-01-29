//
//  ListModel.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import Foundation

class ListModel: ObservableObject {
    let client: LemmyAPIClient
    init(_ client: LemmyAPIClient) {
        self.client = client
    }
    
    @Published var loadState: LoadState<[LemmyPostItem], Error> = .idle
    
    lazy var listPosts: ParsedDataResource<[LemmyPostItem]> = {
        switch client {
        case .v1(let spec):
            let listPostsSpec = spec.listPosts(type: .all, sort: .hot)
            return ParsedDataResource(listPostsSpec.dataProvider, parsedBy: typeAdapter(parser: jsonParser(listPostsSpec.type), adapter: { (response) in
                return response.posts
            }))
            
        case .v2(let spec):
            let listPostsSpec = spec.listPosts(type: .all, sort: .hot)
            return ParsedDataResource(listPostsSpec.dataProvider, parsedBy: typeAdapter(parser: jsonParser(listPostsSpec.type), adapter: { (response) in
                return response.posts.compactMap(\.post)
            }))
        }
    }()
    
    func refresh() {
        loadState = .loading(nil)
        listPosts.$state.assign(to: &$loadState)
        listPosts.load()
    }
    
    var needsRefresh: Bool {
        return loadState.isIdle
    }
    
    func refreshIfNeeded() {
        if needsRefresh {
            refresh()
        }
    }
}
