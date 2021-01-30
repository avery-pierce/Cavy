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
            ForEach(rootModel.clients, id: \.descriptor) { client in
                NavigationLink(client.descriptor, destination: SiteSummaryLoaderView(client))
            }
        }
        .navigationTitle("Saved Instances")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SavedInstanceExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        SavedInstanceExplorerView().rootModel(RootModel())
    }
}
