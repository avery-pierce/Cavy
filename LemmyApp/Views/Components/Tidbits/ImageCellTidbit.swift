//
//  ImageButtonTidbit.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct ImageCellTidbit: View {
    var image: Image?
    var line1: String
    var line2: String
    
    init(image: Image? = nil, line1: String, line2: String) {
        self.image = image
        self.line1 = line1
        self.line2 = line2
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 4.0) {
            image
            
            VStack(spacing: 0) {
                Text(line1)
                    .bold()
                    .font(.system(size: 14.0))
                
                Text(line2)
                    .font(.system(size: 10.0))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 4.0)
        .padding(.vertical, 8.0)
        .background(Color.secondarySystemGroupedBackground)
        .mask(RoundedRectangle(cornerRadius: 8.0))
    }
}

struct ImageButtonTidbit_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImageCellTidbit(image: Image(systemName: "person.3"), line1: "12k", line2: "Users")
            ImageCellTidbit(image: Image(systemName: "bubble.left.and.bubble.right"), line1: "8k", line2: "Communities")
                .accentColor(Color.green)
            ImageCellTidbit(image: Image(systemName: "network"), line1: "12", line2: "Instances")
                .accentColor(Color.purple)
            ImageCellTidbit(line1: "8k", line2: "Communities")
                .accentColor(Color.orange)
        }.previewLayout(.sizeThatFits)
    }
}
