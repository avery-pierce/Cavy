//
//  CommunitiesView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct CommunitiesView: View {
    @Environment(\.lemmyAPIClient) var client
    let communities: [CavyCommunity]
    init(_ communities: [CavyCommunity]) {
        self.communities = communities
    }
    
    var body: some View {
        List {
            ForEach(communities, id: \.id) { community in
                NavigationLink(community.name, destination: LoadingPostListView(.community(client, community)))
            }
        }
        .navigationTitle("Communities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CommunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesView([])
    }
}
