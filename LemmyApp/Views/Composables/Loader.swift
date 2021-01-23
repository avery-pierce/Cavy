//
//  Loader.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

/// Immediately begins loading the data provider
/// and passes the observed state to the child view
struct Loader<T, V: View>: View {
    @ObservedObject var parsedResource: ParsedDataResource<T>
    let contentView: (LoadState<T, Error>) -> V
    
    init(_ dataProvider: DataProvider,
         parsedBy parser: (@escaping (Data) throws -> T),
         view: @escaping (LoadState<T, Error>) -> V) {
        
        self.parsedResource = ParsedDataResource(dataProvider, parsedBy: parser)
        self.contentView = view
        parsedResource.load()
    }
    
    var body: some View {
        contentView(parsedResource.state)
    }
}
