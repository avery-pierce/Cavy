//
//  PostResultsView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct PostResultsView: View {
    
    let dataProvider: DataProvider
    init(_ dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    var body: some View {
        Loader(dataProvider, parsedBy: LemmyPostItemResponse.fromJSON) { state in
            LoadStateView(state) { result in
                ListingView(result.posts)
            }
        }
    }
}

