//
//  KeyValueTidbit.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct KeyValueTidbit: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(key)
                .padding(.vertical, 2.0)
                .padding(.leading, 6.0)
                .padding(.trailing, 4.0)
                .background(Color.accentColor.opacity(0.8))
            Text(value)
                .bold()
                .padding(.vertical, 2.0)
                .padding(.leading, 4.0)
                .padding(.trailing, 6.0)
                .background(Color.accentColor)
        }
        .font(.system(size: 12.0))
        .mask(RoundedRectangle(cornerRadius: 4.0))
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
        }
    }
}
