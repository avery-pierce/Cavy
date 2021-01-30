//
//  PostResultsView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct PostResultsView: View {
    @Environment(\.lemmyAPIClient) var client
    let parsedDataResource: ParsedDataResource<CavyPostListing>
    let descriptor: ListingDescriptor?
    init(_ parsedDataResource: ParsedDataResource<CavyPostListing>, descriptor: ListingDescriptor? = nil) {
        self.parsedDataResource = parsedDataResource
        self.descriptor = descriptor
    }
    
    var saveListingButton: some View {
        HStack {
            if let descriptor = descriptor {
                ToggleSavedListingButton(descriptor)
            } else {
                EmptyView()
            }
        }
    }
    
    var body: some View {
        Loader(parsedDataResource) { state in
            LoadStateView(state) { result in
                ListingView(result.cavyPosts)
            }
        }
        .navigationBarItems(trailing: saveListingButton)
        .navigationTitle(client.descriptor)
        .navigationBarTitleDisplayMode(.inline)
        .lemmyAPIClient(client)
    }
}

