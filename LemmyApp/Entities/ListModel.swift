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
    
    @Published var loadState: LoadState<[PostItem], Error> = .idle
    
    func refresh() {
        loadState = .loading(nil)
        let request = client.listPosts(type: .all, sort: .hot)
        URLSession.shared.decodedDataTask(with: request) { (result: Result<LemmyPostItemResponse, Error>, response) in
            DispatchQueue.main.async {
                let postResult = result.map(\.posts).map({ $0 as [PostItem] })
                self.loadState = .complete(postResult)
            }
        }.resume()
    }
}