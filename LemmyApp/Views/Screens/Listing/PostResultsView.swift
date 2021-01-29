//
//  PostResultsView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct PostResultsView: View {
    
    let parsedDataResource: ParsedDataResource<CavyPostListing>
    init(_ parsedDataResource: ParsedDataResource<CavyPostListing>) {
        self.parsedDataResource = parsedDataResource
    }
    
    var body: some View {
        Loader(parsedDataResource) { state in
            LoadStateView(state) { result in
                ListingView(result.cavyPosts)
            }
        }
    }
}

