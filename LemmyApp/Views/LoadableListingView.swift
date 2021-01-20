//
//  LoadableListingView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct LoadableListingView: View {
    let client: LemmyAPIClient
    @ObservedObject var listModel: ListModel
    init(_ client: LemmyAPIClient) {
        self.client = client
        self.listModel = ListModel(client)
    }
    
    var body: some View {
        LoadStateView(listModel.loadState) { posts in
            ListingView(posts)
        }
        .onAppear(perform: listModel.refreshIfNeeded)
        .navigationBarItems(trailing: Button(action: listModel.refresh) {
            Image(systemName: "arrow.clockwise")
        })
        .navigationTitle(listModel.client.host)
        .navigationBarTitleDisplayMode(.inline)
        .lemmyAPIClient(client)
    }
}

struct LoadableListingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoadableListingView(.lemmyML)
        }
    }
}
