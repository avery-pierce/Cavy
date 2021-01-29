//
//  PostResultsView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct PostResultsView: View {
    
    let parsedDataResource: ParsedDataResource<[LemmyPostItem]>
    init(_ parsedDataResource: ParsedDataResource<[LemmyPostItem]>) {
        self.parsedDataResource = parsedDataResource
    }
    
    var body: some View {
        Loader(parsedDataResource) { state in
            LoadStateView(state) { result in
                ListingView(result.map(\.cavyPost))
            }
        }
    }
}

