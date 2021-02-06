//
//  SavedInstanceExplorerView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/24/21.
//

import SwiftUI

struct SavedInstanceExplorerView: View {
    @EnvironmentObject var rootModel: RootModel
    
    var body: some View {
        List {
            Section(header: Text("Saved Instances")) {
                ForEach(rootModel.clients, id: \.descriptor) { client in
                    NavigationLink(
                        destination: SiteSummaryLoaderView(client),
                        label: {
                            Image(systemName: "server.rack")
                            Text(client.descriptor)
                        })
                }
            }
            
            Section(header: Text("Saved listings")) {
                ForEach(rootModel.savedListings, id: \.fakeHashValue) { listing in
                    NavigationLink(
                        destination: LoadingPostListView(listing),
                        label: {
                            Image(systemName: "tray.full")
                            VStack(alignment: .leading) {
                                Text(listing.title)
                                    .font(.system(size: 14.0))
                                    .bold()
                                Text(listing.detail)
                                    .font(.system(size: 12.0))
                                    .opacity(0.8)
                            }
                        })
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Saved Instances")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SavedInstanceExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedInstanceExplorerView().rootModel(RootModel())
        }
    }
}
