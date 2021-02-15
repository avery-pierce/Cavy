//
//  AppTab.swift
//  Cavy
//
//  Created by Avery Pierce on 2/15/21.
//

import Foundation

enum AppTab {
    case listing(ListingIntent)
    
    init?(_ flatPack: FlatPack) {
        if let listingIntentFlatPack = flatPack.listingIntent {
            self = .listing(ListingIntent(listingIntentFlatPack))
        }
        return nil
    }
    
    func createFlatPack() -> FlatPack {
        switch self {
        case .listing(let listingIntent):
            var flatPack = FlatPack()
            flatPack.listingIntent = listingIntent.createFlatPack()
            return flatPack
        }
    }
    
    struct FlatPack: Codable {
        var listingIntent: ListingIntent.FlatPack? = nil
    }
}

extension AppTab {
    var id: String {
        switch self {
        case .listing(let listing):
            return "listing:\(listing.fakeHashValue)"
        }
    }
}
