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
    
    @Published var posts: [PostItem] = []
    
    func refresh() {
        posts = []
        let request = client.listPosts(type: .all, sort: .hot)
        URLSession.shared.decodedDataTask(with: request) { (result: Result<LemmyPostItemResponse, Error>, response) in
            DispatchQueue.main.async {
                self.posts = (try? result.map(\.posts).get()) ?? []
                print(self.posts)
            }
        }.resume()
    }
}
