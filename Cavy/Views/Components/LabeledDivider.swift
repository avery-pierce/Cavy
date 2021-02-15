//
//  LabeledDivider.swift
//  Cavy
//
//  Created by Avery Pierce on 2/14/21.
//

import SwiftUI
import UIKit

struct LabeledDivider<Children: View>: View {
    let children: Children
    let alignment: Alignment
    init(alignment: Alignment = .center, @ViewBuilder _ content: @escaping () -> Children) {
        self.alignment = alignment
        self.children = content()
    }
    
    init(alignment: Alignment = .center, content: Children) {
        self.alignment = alignment
        self.children = content
    }
    
    var body: some View {
        HStack {
            if alignment != .leading {
                Rectangle().frame(height: 1)
            }
            children
            if alignment != .trailing {
                Rectangle().frame(height: 1)
            }
        }
        .foregroundColor(Color(UIColor.separator))
        .font(.system(.footnote))
    }
    
    enum Alignment {
        case center
        case leading
        case trailing
    }
}

struct LabeledDivider_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20.0) {
            LabeledDivider {
                Text("OR")
            }
            LabeledDivider(content: Text("AND"))
            LabeledDivider(alignment: .leading, content: Image(systemName: "star.fill"))
            LabeledDivider(alignment: .trailing, content: Image(systemName: "heart.fill"))
        }
    }
}
