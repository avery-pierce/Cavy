//
//  ResourceLoader.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import Foundation

class ResourceLoader: ObservableObject {
    @Published var state: LoadState<Data, Error> = .idle
    
    let dataProvider: DataProvider
    init(_ dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    convenience init(_ url: URL) {
        let request = URLRequest(url: url)
        self.init(request)
    }
    
    func load() {
        state = .loading(nil)
        dataProvider.getData { (result) in
            DispatchQueue.main.async {            
                self.state = .complete(result)
            }
        }
    }
}
