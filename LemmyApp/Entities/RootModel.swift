//
//  RootModel.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation
import SwiftUI

class RootModel: ObservableObject {
    @Published var clients = [LemmyAPIClient]() {
        didSet {
            serverStore.write(clients)
        }
    }
    
    @Published var savedListings = [ListingIntent]() {
        didSet {
            listingStore.write(savedListings)
        }
    }
    
    let serverStore = ClientStore()
    let listingStore = ListingIntentStore()
    
    init() {
        self.clients = serverStore.read()
        self.savedListings = listingStore.read()
    }
    
    // MARK: - Server management
    
    func addServer(_ server: LemmyAPIClient) {
        clients.append(server)
    }
    
    func removeServer(at index: Int) {
        clients.remove(at: index)
    }
    
    func removeServer(_ server: LemmyAPIClient) {
        guard let index = clients.firstIndex(where: { (client) -> Bool in
            return client.descriptor == server.descriptor
        }) else { return }
        removeServer(at: Int(index))
    }
    
    func createAddServerUseCase() -> AddServerUseCase {
        let useCase = AddServerUseCase()
        useCase.delegate = self
        return useCase
    }
    
    // MARK: - Saved Listings
    
    func addFavorite(_ listing: ListingIntent) {
        savedListings.append(listing)
    }
    
    func removeFavorite(at index: Int) {
        savedListings.remove(at: index)
    }
    
    func removeFavorite(_ listing: ListingIntent) {
        guard let index = savedListings.firstIndex(of: listing) else { return }
        removeFavorite(at: index)
    }
}

extension RootModel: AddServerDelegate {
    func useCase(_ useCase: AddServerUseCase, didAddServer server: String) {
        clients.append(LemmyAPIClient(descriptor: server))
    }
}

extension View {
    func rootModel(_ rootModel: RootModel) -> some View {
        environmentObject(rootModel)
    }
}
