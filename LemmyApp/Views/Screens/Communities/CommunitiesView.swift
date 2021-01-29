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
    
    func postResults(communityID: Int) -> ParsedDataResource<[LemmyPostItem]> {
        switch client {
        case .v1(let spec):
            let list = spec.listPosts(type: .community, sort: .hot, limit: 50, communityID: communityID)
            return ParsedDataResource(list.dataProvider, parsedBy: typeAdapter(parser: jsonParser(list.type), adapter: { response in
                return response.posts.compactMap(\.post)
            }))
            
        case .v2(let spec):
            let list = spec.listPosts(type: .community, sort: .hot, limit: 50, communityID: communityID)
            return ParsedDataResource(list.dataProvider, parsedBy: typeAdapter(parser: jsonParser(list.type), adapter: { (response) in
                return response.posts.compactMap(\.post)
            }))
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
