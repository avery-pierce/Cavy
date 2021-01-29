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
    
    @Published var loadState: LoadState<CavyPostListing, Error> = .idle
    
    lazy var listPosts: ParsedDataResource<CavyPostListing> = {
        switch client {
        case .v1(let spec): return ParsedDataResource(spec.listPosts(type: .all, sort: .hot))
        case .v2(let spec): return ParsedDataResource(spec.listPosts(type: .all, sort: .hot))
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
