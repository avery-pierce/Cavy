//
//  LabeledDivider.swift
//  Cavy
//
//  Created by Avery Pierce on 2/14/21.
//

import SwiftUI
import UIKit

struct LabeledDivider<Children: View>: View {
    var children: Children
    init(@ViewBuilder _ content: @escaping () -> Children) {
        self.children = content()
    }
    
    init(content: Children) {
        self.children = content
    }
    
    var body: some View {
        HStack {
            Rectangle().frame(height: 1)
            children
            Rectangle().frame(height: 1)
        }
        .foregroundColor(Color(UIColor.separator))
        .font(.system(.footnote))
    }
}

struct LabeledDivider_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
            LabeledDivider {
                Text("OR")
            }
            
            LabeledDivider(content: Text("AND"))
        }
    }
}
