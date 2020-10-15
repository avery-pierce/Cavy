//
//  DecodableResource.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import Foundation

class DecodableResource<T: Decodable>: Resource, ObservableObject {
    @Published var state: LoadState<T, Error> = .idle
    
    let dataProvider: DataProvider
    init(_ dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func load() {
        self.state = .loading(nil)
        dataProvider.getData { (result) in
            let decodeResult = result.flatMap { (data) -> Result<T, Error> in
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    return .success(decoded)
                } catch let error {
                    return .failure(error)
                }
            }
            
            DispatchQueue.main.async {
                self.state = .complete(decodeResult)
            }
        }
    }
}
