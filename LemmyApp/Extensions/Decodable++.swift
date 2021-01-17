//
//  Decodable++.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

extension Decodable {
    static func fromJSON(_ string: String) -> Self {
        let jsonData = string.data(using: .utf8)!
        return try! JSONDecoder().decode(Self.self, from: jsonData)
    }
}
