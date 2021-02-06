//
//  Decodable++.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

extension Decodable {
    static func fromJSON(_ data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
    
    static func fromJSON(_ string: String) throws -> Self {
        let jsonData = string.data(using: .utf8)!
        return try fromJSON(jsonData)
    }
    
    static func fromJSON(fileURL: URL) throws -> Self {
        let data = try! Data(contentsOf: fileURL)
        return try fromJSON(data)
    }
    
    static func fromJSON(fileNamed fileName: String, withExtension fileExtension: String, in bundle: Bundle = .main) throws -> Self {
        let url = bundle.url(forResource: fileName, withExtension: fileExtension)!
        return try fromJSON(fileURL: url)
    }
}
