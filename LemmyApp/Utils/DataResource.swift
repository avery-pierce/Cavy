//
//  DataResource.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import Foundation

class DataResource: ObservableObject, Resource {
    @Published var state: LoadState<Data, Error> = .idle
    
    let dataProvider: DataProvider
    init(_ dataProvider: DataProvider) {
        self.dataProvider = dataProvider
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
