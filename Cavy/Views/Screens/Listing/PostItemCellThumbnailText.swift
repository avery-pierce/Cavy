//
//  PostItemCellThumbnailText.swift
//  Cavy
//
//  Created by Avery Pierce on 2/7/21.
//

import SwiftUI

struct PostItemCellThumbnailText: View {
    @ScaledMetric(wrappedValue: 1.0) var scale: CGFloat
    
    var body: some View {
        Image(systemName: "text.justifyleft")
            .opacity(0.5)
            .font(.system(size: 28.0 * scale))
            .frame(width: 100 * scale, height: 60 * scale)
            .background(Color(UIColor.secondarySystemBackground))
            .mask(RoundedRectangle(cornerRadius: 8 * scale))
    }
}

struct PostItemCellThumbnailText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostItemCellThumbnailText()
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color(UIColor.systemBackground))
        
        
            PostItemCellThumbnailText()
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color(UIColor.systemBackground))
                .colorScheme(.dark)
            
        }
    }
}
