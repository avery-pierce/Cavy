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
                .background(Color.secondarySystemGroupedBackground)
                .mask(RoundedRectangle(cornerRadius: 8.0))
                .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(Color.accentColor, lineWidth: 1.0))
                .onTapGesture {
                    self.committedLemmyServer = Classy("lemmy.ml")
                }
                
                LabeledDivider(content: Text("OR")).padding(.vertical)
                
                Text("Enter another intance")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .opacity(0.8)
                
                TextField("lemmy.ml", text: $lemmyServer, onCommit: {
                    self.committedLemmyServer = Classy(lemmyServer)
                })
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.URL)
                .frame(height: 44)
                .padding(.horizontal, 10.0)
                .background(Color.secondarySystemGroupedBackground)
                .mask(RoundedRectangle(cornerRadius: 8.0))
                .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(Color.accentColor, lineWidth: 1.0))
                
                Text("Enter the host name of the instance you want to connect to. You can alway add more instances later")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            .padding()
        }
        .background(Color.systemGroupedBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Choose Instance")
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
        NavigationView {
            ChooseInstancePage()
        }
    }
}
