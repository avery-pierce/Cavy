//
//  ListingStore.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

class ListingIntentStore {
    private let store: UserDefaults = .standard
    private let key = "FavoriteListings"
    
    func read() -> [ListingIntent] {
        guard let rawListings = store.array(forKey: key) as? [String] else {
            return ListingIntentStore.defaultIntents
        }
        return rawListings.compactMap { (listingString) -> ListingIntent? in
            guard let flatPack = try? ListingIntent.FlatPack.fromJSON(listingString) else { return nil }
            return ListingIntent(flatPack)
        }
    }
    
    func write(_ listings: [ListingIntent]) {
        let serializedArray = listings.compactMap { (intent) -> String? in
            guard let data = try? JSONEncoder().encode(intent.createFlatPack()) else { return nil }
            return String(data: data, encoding: .utf8)
        }
        store.set(serializedArray, forKey: key)
    }
    
    static let defaultIntents = [
        ListingIntent.allPosts(of: LemmyAPIClient.lemmyML)
    ]
}
