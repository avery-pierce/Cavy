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
    
    var body: some View {
        LoadingPostListView(listingDescriptor.createIntent())
    }
}

