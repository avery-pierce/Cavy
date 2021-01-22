//
//  LoadingThumbnailView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct LoadingThumbnailView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(_ imageURL: URL) {
        imageLoader = ImageLoader(imageURL)
    }
    
    var body: some View {
        ThumbnailView(imageLoader.state)
            .onAppear(perform: imageLoader.load)
    }
}
