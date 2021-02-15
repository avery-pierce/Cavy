//
//  AddAnotherInstanceView.swift
//  Cavy
//
//  Created by Avery Pierce on 2/15/21.
//

import SwiftUI

struct AddAnotherInstanceView: View {
    @State var lemmyServer: String = ""
    @State var didNavigate: Bool = false
    
    let onClient: (LemmyAPIClient) -> Void
    init(_ onClient: @escaping (LemmyAPIClient) -> Void) {
        self.onClient = onClient
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Enter an intance")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .opacity(0.8)
                
                TextField("lemmy.ml", text: $lemmyServer, onCommit: {
                    didNavigate = true
                })
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.URL)
                .frame(height: 44)
                .padding(.horizontal, 10.0)
                .background(Color.secondarySystemGroupedBackground)
                .mask(RoundedRectangle(cornerRadius: 8.0))
                .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(Color.accentColor, lineWidth: 1.0))
                
                Text("Enter the host name of the instance you want to connect to.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                NavigationLink(
                    destination: InstancePreviewScreen(host: lemmyServer, onConfirm: onClient),
                    isActive: $didNavigate,
                    label: {
                        EmptyView()
                    })
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct AddAnotherInstanceView_Previews: PreviewProvider {
    static var previews: some View {
        AddAnotherInstanceView({ _ in })
    }
}
