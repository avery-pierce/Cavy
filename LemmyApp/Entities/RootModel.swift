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
            sync()
        }
    }
    
    let serverStore = ServerStore()
    
    init() {
        self.clients = serverStore.read()
    }
    
    func sync() {
        serverStore.write(clients)
    }
    
    func addServer(_ server: LemmyAPIClient) {
        clients.append(server)
    }
    
    func removeServer(at index: Int) {
        clients.remove(at: index)
    }
    
    func removeServer(_ server: LemmyAPIClient) {
        guard let index = clients.firstIndex(where: { (client) -> Bool in
            return client.host == server.host
        }) else { return }
        removeServer(at: Int(index))
    }
    
    func createAddServerUseCase() -> AddServerUseCase {
        let useCase = AddServerUseCase()
        useCase.delegate = self
        return useCase
    }
}

extension RootModel: AddServerDelegate {
    func useCase(_ useCase: AddServerUseCase, didAddServer server: String) {
        clients.append(LemmyAPIClient(server))
    }
}

class ServerStore {
    private let store: UserDefaults = .standard
    private let key = "LemmyServers"
    
    func read() -> [LemmyAPIClient] {
        guard let rawServers = store.array(forKey: key) as? [String] else {
            return ServerStore.defaultServers
        }
        
        return rawServers.map(LemmyAPIClient.init)
    }
    
    func write(_ servers: [LemmyAPIClient]) {
        let serializedArray = servers.map(\.host)
        store.set(serializedArray, forKey: key)
    }
    
    static let defaultServers = [
        LemmyAPIClient.lemmyML,
        LemmyAPIClient.lemmygradML
    ]
}

extension View {
    func rootModel(_ rootModel: RootModel) -> some View {
        environmentObject(rootModel)
    }
}
