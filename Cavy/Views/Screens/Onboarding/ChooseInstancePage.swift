//
//  ChooseInstancePage.swift
//  Cavy
//
//  Created by Avery Pierce on 2/13/21.
//

import SwiftUI

struct ChooseInstancePage: View {
    @EnvironmentObject var rootModel: RootModel
    @State var lemmyServer: String = ""
    @State var committedLemmyServer: Classy<String>? = nil
    
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
                .onTapGesture {
                    rootModel.onboardingDidComplete(.lemmyML)
                }
                
                LabeledDivider(content: Text("OR")).padding(.vertical)
                
                Text("Enter another intance")
                TextField("lemmy.ml", text: $lemmyServer, onCommit: {
                    self.committedLemmyServer = Classy(lemmyServer)
                })
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.URL)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
                    
                Text("You can also add more instances later")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $committedLemmyServer) { host in
            InstancePreviewScreen(host: host.value) { client in
                rootModel.onboardingDidComplete(client)
                committedLemmyServer = nil
            }
        }
    }
}

struct ChooseInstancePage_Previews: PreviewProvider {
    static var previews: some View {
        ChooseInstancePage()
    }
}
