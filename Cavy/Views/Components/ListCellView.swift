//
//  ListCellView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct ListCellView<V: View>: View {
    let contentView: () -> V
    init(@ViewBuilder contentView: @escaping () -> V) {
        self.contentView = contentView
    }
    
    var body: some View {
        HStack {
            contentView()
            Spacer()
            Image(systemName: "chevron.right")
                .opacity(0.8)
        }
        .padding(EdgeInsets(top: 4.0, leading: 12.0, bottom: 4.0, trailing: 12.0))
        .frame(minHeight: 44.0)
    }
}

struct ListCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListCellView {
                VStack(alignment: .leading) {
                    Text("Hello World!").font(.headline)
                    Text("Goodbye World!").font(.subheadline)
                }
            }
            .previewLayout(.sizeThatFits)
            
            ListCellView {
                VStack(alignment: .leading) {
                    Text("Hello World!").font(.headline)
                    Text("Goodbye World!").font(.subheadline)
                }
            }
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        }
    }
}
