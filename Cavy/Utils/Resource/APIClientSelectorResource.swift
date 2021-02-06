//
//  APIClientSelectorResource.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

class APIClientSelectorResource: ObservableObject, Resource {
    @Published var state: LoadState<LemmyAPIClient, Error> = .idle
    
    let host: String
    init(_ host: String) {
        self.host = host
    }
    
    func load() {
        state = .loading(nil)
        let useCase = SelectLemmyAPIVersionUseCase(host)
        useCase.determineAPI { result in
            self.state = .complete(result)
        }
    }
}
