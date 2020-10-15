//
//  RootModel.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation

class RootModel: ObservableObject {
    @Published var clients = [
        LemmyAPIClient.devLemmyMl,
        LemmyAPIClient.lemmygradML
    ]
    
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
