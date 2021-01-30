//
//  ListingStore.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

class ListingStore {
    private let store: UserDefaults = .standard
    private let key = "FavoriteListings"
    
    func read() -> [ListingDescriptor] {
        guard let rawListings = store.array(forKey: key) as? [String] else {
            return ListingStore.defaultListings
        }
        return rawListings.compactMap { (listingString) -> ListingDescriptor? in
            try? ListingDescriptor.fromJSON(listingString)
        }
    }
    
    func write(_ listings: [ListingDescriptor]) {
        let serializedArray = listings.compactMap { (descriptor) -> String? in
            guard let data = try? JSONEncoder().encode(descriptor) else { return nil }
            return String(data: data, encoding: .utf8)
        }
        store.set(serializedArray, forKey: key)
    }
    
    static let defaultListings = [
        ListingDescriptor.lemmyMain
    ]
}
