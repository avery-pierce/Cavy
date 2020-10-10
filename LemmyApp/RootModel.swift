//
//  RootModel.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation

class RootModel: ObservableObject {
    let client = LemmyAPIClient.devLemmyMl
    
    @Published var posts: [PostItem] = []
    
    func refresh() {
        print("Refreshing!")
        posts = []
        let request = client.listPosts(type: .all, sort: .hot)
        URLSession.shared.decodedDataTask(with: request) { (result: Result<LemmyPostItemResponse, Error>, response) in
            DispatchQueue.main.async {
                self.posts = (try? result.map(\.posts).get()) ?? []
            }
        }.resume()
    }
}
