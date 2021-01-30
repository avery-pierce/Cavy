//
//  ClientStore.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

class ClientStore {
    private let store: UserDefaults = .standard
    private let key = "LemmyServers"
    
    func read() -> [LemmyAPIClient] {
        guard let rawServers = store.array(forKey: key) as? [String] else {
            return ClientStore.defaultServers
        }
        
        return rawServers.map(LemmyAPIClient.init(descriptor:))
    }
    
    func write(_ servers: [LemmyAPIClient]) {
        let serializedArray = servers.map(\.descriptor)
        store.set(serializedArray, forKey: key)
    }
    
    static let defaultServers = [
        LemmyAPIClient.lemmyML,
        LemmyAPIClient.lemmygradML
    ]
}
