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
