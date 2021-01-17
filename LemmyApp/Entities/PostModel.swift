//
//  PostModel.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

class PostModel: ObservableObject {
    var client: LemmyAPIClient?
    let postID: String
    init(_ client: LemmyAPIClient? = nil, postID: String) {
        self.client = client
        self.postID = postID
    }
    
    @Published var loadState: LoadState<LemmyPostResponse, Error> = .idle
    
    func refresh() {
        guard let client = client else { return }
        
        loadState = .loading(nil)
        let request = client.fetchPost(id: postID)
        URLSession.shared.decodedDataTask(with: request) { (result: Result<LemmyPostResponse, Error>, response) in
            DispatchQueue.main.async {
                self.loadState = .complete(result)
            }
        }.resume()
    }
}
