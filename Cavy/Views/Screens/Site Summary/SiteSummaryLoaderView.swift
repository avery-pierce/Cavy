//
//  SiteSummaryLoaderView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct SiteSummaryLoaderView: View {
    @EnvironmentObject var rootModel: RootModel
    let client: LemmyAPIClient
    
    init(_ client: LemmyAPIClient = .lemmyML) {
        self.client = client
    }
    
    var body: some View {
        InstanceSiteLoader(client) { loadState in
            LoadStateView(loadState.map(\.cavySite)) { site in
                SiteSummaryView(site)
                    .environment(\.lemmyAPIClient, client)
            }
        }
        .navigationBarItems(trailing: saveInstanceButton)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var saveInstanceButton: some View {
        Button(action: toggleSiteSaved) {
            isServerSaved ? Image(systemName: "star.fill") : Image(systemName: "star")
        }
    }
    
    var isServerSaved: Bool {
        return rootModel.clients.contains(where: { $0.descriptor == client.descriptor })
    }
    
    func toggleSiteSaved() {
        if isServerSaved {
            rootModel.removeServer(client)
        } else {
            rootModel.addServer(client)
        }
    }
}

struct SiteSummaryLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        SiteSummaryLoaderView()
    }
}
