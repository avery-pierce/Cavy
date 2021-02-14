//
//  ChooseInstancePage.swift
//  Cavy
//
//  Created by Avery Pierce on 2/13/21.
//

import SwiftUI

struct ChooseInstancePage: View {
    @State var lemmyServer: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Select an instance")
                
                HStack {
                    VStack(alignment: .leading, spacing: 8.0) {
                        HStack {
                            Text("lemmy.ml")
                                .font(.headline)
                            
                            Text("(recommended)")
                                .opacity(0.5)
                        }
                        Text("The flagship lemmy server. If you've never used Lemmy before, this is a good place to start.")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 2)
                )
                
                LabeledDivider(content: Text("OR")).padding(.vertical)
                
                Text("Enter another intance")
                TextField("lemmy.ml", text: $lemmyServer)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
            }
            .padding()
        }
    }
}

struct ChooseInstancePage_Previews: PreviewProvider {
    static var previews: some View {
        ChooseInstancePage()
    }
}
