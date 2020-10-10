//
//  LoadableListingView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct LoadableListingView: View {
    @ObservedObject var listModel: ListModel
    init(_ client: LemmyAPIClient) {
        listModel = ListModel(client)
    }
    
    var body: some View {
        LoadStateView(listModel.loadState) { posts in
            ListingView(posts)
        }
        .onAppear(perform: listModel.refresh)
        .navigationBarItems(trailing: Button(action: listModel.refresh) {
            Image(systemName: "arrow.clockwise")
        })
        .navigationTitle(listModel.client.host)
    }
}

struct LoadableListingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoadableListingView(.devLemmyMl)
        }
    }
}
