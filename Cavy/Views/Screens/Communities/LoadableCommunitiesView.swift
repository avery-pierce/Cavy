//
//  LoadableCommunitiesView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct LoadableCommunitiesView: View {
    @Environment(\.lemmyAPIClient) var client
    
    var listCommunities: ParsedDataResource<CavyCommunityListing> {
        switch client {
        case .v1(let spec): return ParsedDataResource(spec.listCommunities(sort: .topAll))
        case .v2(let spec): return ParsedDataResource(spec.listCommunities(sort: .topAll))
        }
    }
    
    var body: some View {
        Loader(listCommunities) { state in
            LoadStateView(state) { communities in
                CommunitiesView(communities.cavyCommunities)
            }
        }
    }
}

struct LoadableCommunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        LoadableCommunitiesView()
    }
}
