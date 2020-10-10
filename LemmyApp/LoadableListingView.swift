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
        content
            .onAppear(perform: listModel.refresh)
            .navigationBarItems(trailing: Button(action: listModel.refresh) {
                Image(systemName: "arrow.clockwise")
            })
            .navigationTitle(listModel.client.host)
    }
    
    @ViewBuilder var content: some View {
        switch listModel.loadState {
        case .complete(let result):
            switch result {
            case .success(let posts):
                ListingView(posts)

            case .failure(let error):
                Text(error.localizedDescription)
            }
            
        case .idle, .loading:
            ProgressView()
        }
    }
}

struct LoadableListingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoadableListingView(.devLemmyMl)
        }
    }
}
