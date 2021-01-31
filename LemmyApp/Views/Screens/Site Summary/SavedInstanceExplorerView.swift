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
                ForEach(rootModel.savedListings, id: \.self) { listing in
                    NavigationLink(
                        destination: ListingDescriptorView(listing),
                        label: {
                            Image(systemName: "tray.full")
                            Text(listing.name)
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
