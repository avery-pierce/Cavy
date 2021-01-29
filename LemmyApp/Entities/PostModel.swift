//
//  PostModel.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

class PostModel: ObservableObject {
    var client: LemmyAPIClient?
    let postID: Int
    init(_ client: LemmyAPIClient? = nil, postID: Int) {
        self.client = client
        self.postID = postID
    }
    
    lazy var commentsResource: ParsedDataResource<CavyCommentListing> = {
        switch client! {
        case .v1(let spec): return ParsedDataResource(spec.fetchPost(id: postID))
        case .v2(let spec): return ParsedDataResource(spec.fetchPost(id: postID))
        }
    }()
    
    @Published var loadState: LoadState<CavyCommentListing, Error> = .idle
    
    func refresh() {
        loadState = .loading(nil)
        commentsResource.$state.assign(to: &$loadState)
        commentsResource.load()
    }
}
