//
//  DecodableResource.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import Foundation

class DecodableResource<T: Codable>: Resource {
    
    let request: URLRequest
    let session: URLSession
    init(loading request: URLRequest, as Type: T.Type, session: URLSession = .shared) {
        self.request = request
        self.session = session
    }
    
    @Published var state: LoadState<T, Error> = .idle
    
    func load() {
        self.state = .loading(nil)
        session.decodedDataTask(with: request) { (result: Result<T, Error>, _) in
            DispatchQueue.main.async {
                self.state = .complete(result)
            }
        }.resume()
    }
}
