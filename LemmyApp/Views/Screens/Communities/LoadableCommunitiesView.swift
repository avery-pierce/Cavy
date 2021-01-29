//
//  LoadableCommunitiesView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct LoadableCommunitiesView: View {
    @Environment(\.lemmyAPIClient) var client
    
    var listCommunities: ParsedDataResource<[LemmyCommunity]> {
        switch client {
        case .v2(let spec):
            let listCommunities = spec.listCommunities(sort: .topAll)
            return ParsedDataResource(listCommunities.dataProvider, parsedBy: typeAdapter(parser: jsonParser(listCommunities.type), adapter: { (response) -> [LemmyCommunity] in
                return response.communities.compactMap(\.community)
            }))
            
        case .v1(let spec):
            let listCommunities = spec.listCommunities(sort: .topAll)
            return ParsedDataResource(listCommunities.dataProvider, parsedBy: typeAdapter(parser: jsonParser(listCommunities.type), adapter: { (response) -> [LemmyCommunity] in
                return response.communities
            }))
        }
    }
    
    var body: some View {
        Loader(listCommunities) { state in
            LoadStateView(state) { communities in
                CommunitiesView(communities)
            }
        }
    }
}

struct LoadableCommunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        LoadableCommunitiesView()
    }
}
