//
//  FillButton.swift
//  Cavy
//
//  Created by Avery Pierce on 2/14/21.
//

import SwiftUI

struct FillButton<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder _ contentBuilder: () -> Content) {
        self.content = contentBuilder()
    }
    
    init(_ content: Content) {
        self.content = content
    }
    
    init<S: StringProtocol>(_ string: S) where Content == Text {
        self.content = Text(string).bold()
    }
    
    init(_ localizedStringKey: LocalizedStringKey) where Content == Text {
        self.content = Text(localizedStringKey).bold()
    }
    
    var body: some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.blue))
        .foregroundColor(.white)
    }
}

struct FillButton_Previews: PreviewProvider {
    static var previews: some View {
        FillButton("Test Message")
            .padding()
    }
}
