//
//  PostItemCellThumbnailView.swift
//  Cavy
//
//  Created by Avery Pierce on 2/7/21.
//

import SwiftUI

struct PostItemCellThumbnailView: View {
    @ScaledMetric(wrappedValue: 1.0) var scale: CGFloat
    
    let loadState: LoadState<UIImage, Error>
    init(_ loadState: LoadState<UIImage, Error>) {
        self.loadState = loadState
    }
    
    var body: some View {
        LoadStateView(loadState) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: 100 * scale, height: 60 * scale)
        .background(Color(UIColor.secondarySystemBackground))
        .mask(RoundedRectangle(cornerRadius: 8 * scale))
    }
}

struct PostItemCellThumbnailView_Previews: PreviewProvider {
    
    static let thumbnailImage = UIImage(named: "ExampleThumbnail_1")!
    
    static var previews: some View {
        Group {
            PostItemCellThumbnailView(.loading(nil))
            PostItemCellThumbnailView(.complete(.success(thumbnailImage)))
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color(UIColor.systemBackground))
        
        Group {
            PostItemCellThumbnailView(.loading(nil))
            PostItemCellThumbnailView(.complete(.success(thumbnailImage)))
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color(UIColor.systemBackground))
        .colorScheme(.dark)
    }
}
