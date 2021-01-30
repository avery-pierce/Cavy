//
//  Loader.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

/// Immediately begins loading the data provider
/// and passes the observed state to the child view
struct Loader<SomeResource: ObservableObject & Resource, V: View>: View {
    @ObservedObject var resource: SomeResource
    let contentView: (LoadState<SomeResource.T, SomeResource.E>) -> V
    
    init<D: DataProvider, T>(_ dataProvider: D,
         parsedBy parser: (@escaping (Data) throws -> T),
         view: @escaping (LoadState<T, Error>) -> V) where SomeResource == ParsedDataResource<T> {

        self.resource = ParsedDataResource(dataProvider, parsedBy: parser)
        self.contentView = view
        resource.load()
    }

    init<D, T>(_ spec: Spec<D, T>, view: @escaping (LoadState<T, Error>) -> V) where SomeResource == ParsedDataResource<T> {
        self.resource = ParsedDataResource(spec)
        self.contentView = view
        resource.load()
    }
    
    init(_ resource: SomeResource, view: @escaping (LoadState<SomeResource.T, SomeResource.E>) -> V) {
        self.resource = resource
        self.contentView = view
        resource.load()
    }
    
    var body: some View {
        contentView(resource.state)
    }
}
