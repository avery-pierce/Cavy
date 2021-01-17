//
//  PostItemView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import SwiftUI

struct PostItemView: View {
    let postItem: PostItem
    @ObservedObject var imageLoader: ImageLoader
    
    init(_ postItem: PostItem) {
        self.postItem = postItem
        
        imageLoader = ImageLoader(postItem.imageURL ?? URL(string: "https://www.example.com")!)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if postItem.imageURL != nil {
                LoadStateView(imageLoader.state) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .onAppear(perform: imageLoader.load)
                .frame(width: 44, height: 44, alignment: .center)
                .background(Color(white: 0.5).opacity(0.2))
                .cornerRadius(4.0)
            }
                
            VStack(alignment: .leading, spacing: 4.0) {
                Text(postItem.title)
                    .bold()
                    .font(.system(size: 14.0))
                
                HStack {
                    Text(postItem.authorName)
                        .foregroundColor(.accentColor)
                    
                    Text(postItem.domain)
                        .italic()
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
            }
        }
        
    }
}

struct PostItemView_Previews: PreviewProvider {
    static var previews: some View {
        PostItemView(sampleData)
            .previewLayout(.fixed(width: 500, height: 140))
    }
}
