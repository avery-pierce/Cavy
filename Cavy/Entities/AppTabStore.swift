//
//  AppTabStore.swift
//  Cavy
//
//  Created by Avery Pierce on 2/15/21.
//

import Foundation

class AppTabStore {
    private let store: UserDefaults = .standard
    private let key = "AppTabs"
    
    func read() -> [AppTab] {
        guard let rawListings = store.array(forKey: key) as? [String] else {
            return []
        }
        return rawListings.compactMap { (listingString) -> AppTab? in
            guard let tabFlatPack = try? AppTab.FlatPack.fromJSON(listingString) else { return nil }
            return AppTab(tabFlatPack)
        }
    }
    
    func write(_ tabs: [AppTab]) {
        let serializedArray = tabs.compactMap { (tab) -> String? in
            guard let data = try? JSONEncoder().encode(tab.createFlatPack()) else { return nil }
            return String(data: data, encoding: .utf8)
        }
        store.set(serializedArray, forKey: key)
    }
}
