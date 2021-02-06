//
//  LoadingThumbnailView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct LoadingThumbnailView<D: DataProvider>: View {
    let dataProvider: D
    
    init(_ dataProvider: D) {
        self.dataProvider = dataProvider
    }
    
    var body: some View {
        Loader(dataProvider, parsedBy: imageParser) { state in
            ThumbnailView(state)
        }
    }
}
