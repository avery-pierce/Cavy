//
//  LoadableCommunitiesView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct LoadableCommunitiesView: View {
    @Environment(\.lemmyAPIClient) var client
    
    var body: some View {
        Loader(client.listCommunities(sort: .topAll), parsedBy: LemmyCommunitiesResponse.fromJSON) { state in
            
            LoadStateView(state) { listing in
                CommunitiesView(listing.communities)
            }
        }
    }
}

struct LoadableCommunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        LoadableCommunitiesView()
    }
}
