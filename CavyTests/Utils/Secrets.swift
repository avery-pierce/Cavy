//
//  Secrets.swift
//  CavyTests
//
//  Created by Avery Pierce on 2/15/21.
//

import Foundation

class Secrets {
    static func load() -> [String: Any]? {
        guard let url = Bundle(for: Self.self).url(forResource: "secrets", withExtension: "json") else { return nil }
        guard let loadedData = try? Data(contentsOf: url) else { return nil }
        guard let object = try? JSONSerialization.jsonObject(with: loadedData, options: []) as? [String: Any] else { return nil }
        return object
    }
}
