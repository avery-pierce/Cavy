//
//  LoadableListingView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct LoadableListingView: View {
    @EnvironmentObject var rootModel: RootModel
    let client: LemmyAPIClient
    @ObservedObject var listModel: ListModel
    init(_ client: LemmyAPIClient) {
        self.client = client
        self.listModel = ListModel(client)
    }
    
    var body: some View {
        LoadStateView(listModel.loadState) { listing in
            ListingView(listing.cavyPosts)
        }
        .onAppear(perform: listModel.refreshIfNeeded)
        .navigationBarItems(trailing: HStack {
            Button(action: listModel.refresh) {
                Image(systemName: "arrow.clockwise")
            }
            Button(action: toggleSaved) {
                isListingSaved ? Image(systemName: "star.fill") : Image(systemName: "star")
            }
        })
        .navigationTitle(listModel.client.descriptor)
        .navigationBarTitleDisplayMode(.inline)
        .lemmyAPIClient(client)
    }

    var listing: ListingDescriptor { ListingDescriptor(client, communityID: nil, favorite: true, label: client.host) }
    
    var isListingSaved: Bool {
        return rootModel.savedListings.contains(listing)
    }
    
    func toggleSaved() {
        if isListingSaved {
            rootModel.removeFavorite(listing)
        } else {
            rootModel.addFavorite(listing)
        }
    }
}

struct LoadableListingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoadableListingView(.lemmyML)
        }
    }
}
