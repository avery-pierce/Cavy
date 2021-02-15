//
//  Spec.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

struct Spec<D: DataProvider, Result: Codable> {
    var dataProvider: D
    var type: Result.Type
    
    init(_ dataProvider: D, as serializedType: Result.Type) {
        self.dataProvider = dataProvider
        self.type = serializedType
    }
    
    init(_ dataProvider: D) {
        self.dataProvider = dataProvider
        self.type = Result.self
    }
}

extension Spec {
    func load(completion: @escaping (Swift.Result<Result, Error>) -> Void) {
        dataProvider.getData { (result) in
            let parsed = result.flatMap { (data) -> Swift.Result<Result, Error> in
                Swift.Result { () -> Result in
                    try JSONDecoder().decode(Result.self, from: data)
                }
            }
            completion(parsed)
        }
    }
}
