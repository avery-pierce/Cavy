//
//  ToggleSavedListingButton.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import SwiftUI

struct ToggleSavedListingButton: View {
    @EnvironmentObject var rootModel: RootModel
    
    var listing: ListingDescriptor
    init(_ listing: ListingDescriptor) {
        self.listing = listing
    }

    var body: some View {
        Button(action: toggleSaved) {
            isListingSaved ? Image(systemName: "star.fill") : Image(systemName: "star")
        }
    }
    
    var isListingSaved: Bool {
        return rootModel.savedListings.contains(listing)
    }
    
    func toggleSaved() {
        if isListingSaved {
            rootModel.removeFavorite(listing)
        } else {
            rootModel.addFavorite(listing)
        }
    }
}

struct ToggleSavedListingButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleSavedListingButton(.lemmyMain)
    }
}
