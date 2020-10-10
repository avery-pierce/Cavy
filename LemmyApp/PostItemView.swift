//
//  PostItemView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import SwiftUI

struct PostItemView: View {
    let postItem: PostItem
    init(_ postItem: PostItem) {
        self.postItem = postItem
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if (postItem.imageURL != nil) {
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(8.0)
            }
                
            VStack(alignment: .leading, spacing: 4.0) {
                Text(postItem.title)
                    .bold()
                    .font(.system(size: 13.0))
                
                HStack {
                    Text(postItem.authorName)
                        .foregroundColor(.accentColor)
                    
                    Text(postItem.domain)
                        .italic()
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .font(.system(size: 11.0))

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
