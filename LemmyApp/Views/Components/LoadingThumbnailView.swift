//
//  LoadingThumbnailView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct LoadingThumbnailView: View {
    let dataProvider: DataProvider
    
    init(_ dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    var body: some View {
        Loader(dataProvider, parsedBy: imageParser) { state in
            ThumbnailView(state)
        }
    }
}
