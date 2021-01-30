//
//  ListingDescriptorView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import SwiftUI

struct ListingDescriptorView: View {
    let listingDescriptor: ListingDescriptor
    init(_ listingDescriptor: ListingDescriptor) {
        self.listingDescriptor = listingDescriptor
    }
    
    var resource: ParsedDataResource<CavyPostListing> {
        let client = LemmyAPIClient(descriptor: listingDescriptor.client)
        if let communityID = listingDescriptor.communityID {
            switch client {
            case .v2(let spec): return ParsedDataResource(spec.listPosts(type: .all, sort: .hot, communityID: communityID))
            case .v1(let spec): return ParsedDataResource(spec.listPosts(type: .all, sort: .hot, communityID: communityID))
            }
        } else {
            switch client {
            case .v1(let spec): return ParsedDataResource(spec.listPosts(type: .all, sort: .hot))
            case .v2(let spec): return ParsedDataResource(spec.listPosts(type: .all, sort: .hot))
            }
        }
    }
    
    var body: some View {
        PostResultsView(resource)
    }
}

