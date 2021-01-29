//
//  CommunitiesView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct CommunitiesView: View {
    @Environment(\.lemmyAPIClient) var client
    let communities: [LemmyCommunity]
    init(_ communities: [LemmyCommunity]) {
        self.communities = communities
    }
    
    func postResults(communityID: Int) -> ParsedDataResource<CavyPostListing> {
        switch client {
        case .v1(let spec): return ParsedDataResource(spec.listPosts(type: .community, sort: .hot, limit: 50, communityID: communityID))
        case .v2(let spec): return ParsedDataResource(spec.listPosts(type: .community, sort: .hot, limit: 50, communityID: communityID))
        }
    }
    
    var body: some View {
        List {
            ForEach(communities, id: \.id) { community in
                if let communityID = community.id {
                    NavigationLink(community.name ?? "", destination: PostResultsView(postResults(communityID: communityID)).lemmyAPIClient(client))
                } else {
                    Text(community.name ?? "")
                }
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
