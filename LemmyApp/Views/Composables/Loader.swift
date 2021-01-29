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
        
        self.init(ParsedDataResource(dataProvider, parsedBy: parser), view: view)
    }
    
    init<D>(_ spec: Spec<D, T>, view: @escaping (LoadState<T, Error>) -> V) {
        self.init(ParsedDataResource(spec), view: view)
    }
    
    init(_ parsedDataResource: ParsedDataResource<T>, view: @escaping (LoadState<T, Error>) -> V) {
        self.parsedResource = parsedDataResource
        self.contentView = view
        parsedResource.load()
    }
    
    var body: some View {
        contentView(parsedResource.state)
    }
}
