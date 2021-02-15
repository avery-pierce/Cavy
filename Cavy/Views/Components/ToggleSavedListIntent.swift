//
//  ToggleSavedListIntent.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct ToggleSavedListIntent: View {
    @EnvironmentObject var rootModel: RootModel
    
    var intent: ListingIntent
    init(_ intent: ListingIntent) {
        self.intent = intent
    }
    
    var body: some View {
        Button(action: toggleSaved) {
            isIntentSaved ? Image(systemName: "star.fill") : Image(systemName: "star")
        }
    }
    
    var isIntentSaved: Bool {
        return rootModel.savedListings.contains(intent)
    }
    
    func toggleSaved() {
        if isIntentSaved {
            rootModel.removeFavorite(intent)
        } else {
            rootModel.addFavorite(intent)
        }
    }
}

struct ToggleSavedListIntent_Previews: PreviewProvider {
    static var previews: some View {
        ToggleSavedListIntent(.allPosts(of: .lemmyML))
    }
}
