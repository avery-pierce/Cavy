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
    
    lazy var commentsResource: ParsedDataResource<[LemmyComment]> = {
        switch client! {
        case .v1(let spec):
            let post = spec.fetchPost(id: postID)
            return ParsedDataResource(post.dataProvider, parsedBy: typeAdapter(parser: jsonParser(post.type), adapter: { (response) in
                return response.comments
            }))
        case .v2(let spec):
            let post = spec.fetchPost(id: postID)
            return ParsedDataResource(post.dataProvider, parsedBy: typeAdapter(parser: jsonParser(post.type), adapter: { (response) in
                return response.comments?.compactMap(\.comment) ?? []
            }))
        }
    }()
    
    @Published var loadState: LoadState<[LemmyComment], Error> = .idle
    
    func refresh() {
        loadState = .loading(nil)
        commentsResource.$state.assign(to: &$loadState)
        commentsResource.load()
    }
}
