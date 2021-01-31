//
//  LoadingPostListView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct LoadingPostListView<PostResource: Resource & ObservableObject>: View where PostResource.T == CavyPostListing {
    @Environment(\.lemmyAPIClient) var client
    let intent: ListingIntent?
    let resource: PostResource
    
    init(_ resource: PostResource) {
        self.intent = nil
        self.resource = resource
    }
    
    init(_ intent: ListingIntent) where PostResource == ParsedDataResource<CavyPostListing> {
        self.intent = intent
        self.resource = intent.createResource()
    }
    
    var barButtonItems: some View {
        HStack {
            if let intent = intent {
                ToggleSavedListIntent(intent)
            } else {
                EmptyView()
            }
        }
    }
    
    var activeClient: LemmyAPIClient {
        intent?.client ?? client
    }
    
    var title: some View {
        let title = intent?.title ?? client.host
        let detail = intent?.detail
        
        return VStack {
            Text(title).font(.headline)
            if let detail = detail {
                Text(detail).font(.subheadline)
            }
        }
    }
    
    var body: some View {
        Loader(resource) { loadState in
            LoadStateView(loadState) { listing in
                ListingView(listing.cavyPosts)
            }
            .lemmyAPIClient(activeClient)
            .navigationBarItems(trailing: barButtonItems)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    title
                }
            }
        }
    }
}
