//
//  KeyValueTidbit.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct KeyValueTidbit: View {
    @ScaledMetric(wrappedValue: 2.0) var padding: CGFloat
    @ScaledMetric(wrappedValue: 12.0) var fontPointSize: CGFloat
    
    var key: String
    var value: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(key)
                .padding(.vertical, padding)
                .padding(.leading, padding * 3)
                .padding(.trailing, padding * 2)
                .background(Color.accentColor.opacity(0.8))
            Text(value)
                .bold()
                .padding(.vertical, padding)
                .padding(.leading, padding * 2)
                .padding(.trailing, padding * 3)
                .background(Color.accentColor)
        }
        .font(.system(size: fontPointSize))
        .mask(RoundedRectangle(cornerRadius: padding * 2))
    }
}

struct KeyValueTidbit_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            KeyValueTidbit(key: "API", value: "v2")
                .previewLayout(.sizeThatFits)
                .accentColor(.blue)
                .foregroundColor(.white)
            
            KeyValueTidbit(key: "API", value: "v1")
                .previewLayout(.sizeThatFits)
                .accentColor(.purple)
                .foregroundColor(.white)
            
            KeyValueTidbit(key: "API", value: "v1")
                .environment(\.sizeCategory, .accessibilityLarge)
                .previewLayout(.sizeThatFits)
                .accentColor(.purple)
                .foregroundColor(.white)
        }
    }
}
