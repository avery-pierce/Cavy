//
//  JSONLoader.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import Foundation

class JSONLoader<T: Codable>: ObservableObject, Resource {
    @Published var state: LoadState<T, Error> = .idle
    
    let dataProvider: DataProvider
    init(_ dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    convenience init(_ url: URL) {
        let request = URLRequest(url: url)
        self.init(request)
    }
    
    func load() {
        state = .loading(nil)
        dataProvider.getData { (result) in
            
            // Decode the result into JSON
            let decodedResult = result.flatMap { (data) -> Result<T, Error> in
                return Result<T, Error> { () -> T in
                    return try JSONDecoder().decode(T.self, from: data)
                }
            }
            
            DispatchQueue.main.async {
                self.state = .complete(decodedResult)
            }
        }
    }
}
