//
//  ThumbnailView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import SwiftUI

struct ThumbnailView: View {
    var loadState: LoadState<UIImage, Error>
    
    init(_ loadState: LoadState<UIImage, Error>) {
        self.loadState = loadState
    }
    
    var body: some View {
        LoadStateView(loadState) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: 44, height: 44, alignment: .center)
        .background(Color(white: 0.5).opacity(0.2))
        .cornerRadius(4.0)
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThumbnailView(.idle)
            ThumbnailView(.loading(nil))
            ThumbnailView(.loading(0.75))
            ThumbnailView(.complete(.failure(PlainError("Example Error"))))
        }.previewLayout(.sizeThatFits)
    }
}
