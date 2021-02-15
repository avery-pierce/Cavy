//
//  SavedInstanceExplorerView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/24/21.
//

import SwiftUI

struct SavedInstanceExplorerView: View {
    @ScaledMetric(wrappedValue: 14.0) var headerFontSize: CGFloat
    @ScaledMetric(wrappedValue: 12.0) var subheadFontSize: CGFloat
    @EnvironmentObject var rootModel: RootModel
    
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("Saved Instances")) {
                ForEach(rootModel.clients, id: \.descriptor) { client in
                    NavigationLink(
                        destination: SiteSummaryLoaderView(client),
                        label: {
                            Image(systemName: "server.rack")
                            VStack(alignment: .leading, spacing: 2.0) {
                                
                                HStack(spacing: 2) {
                                    if let username = client.authenticatedUser {
                                        Text(username)
                                            .font(.system(size: headerFontSize))
                                            .bold()
                                        Text("@").opacity(0.5)
                                    }
                                    Text(client.host)
                                        .font(.system(size: headerFontSize))
                                }
                                APILevelTidbit(client)
                            }
                        })
                }
            }
            
            Section(header: Text("Saved listings")) {
                ForEach(rootModel.savedListings, id: \.fakeHashValue) { listing in
                    NavigationLink(
                        destination: LoadingPostListView(listing),
                        label: {
                            Image(systemName: "tray.full")
                            VStack(alignment: .leading) {
                                Text(listing.title)
                                    .font(.system(size: headerFontSize))
                                    .bold()
                                Text(listing.detail)
                                    .font(.system(size: subheadFontSize))
                                    .opacity(0.8)
                            }
                        })
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Saved Instances")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: { isSheetPresented = true }, label: { Image(systemName: "plus.circle") }))
        .sheet(isPresented: $isSheetPresented, content: {
            ChooseInstancePage() { client in
                rootModel.addServer(client)
                isSheetPresented = false
            }
        })
    }
}

struct SavedInstanceExplorerView_Previews: PreviewProvider {
    static let mockModel: RootModel = {
        let model = RootModel()
        model.clients = [
            LemmyAPIClient(descriptor: "chapo.chat/v1"),
            LemmyAPIClient(descriptor: "CavyTestUser@lemmy.ml/v2"),
        ]
        return model
    }()
    
    static var previews: some View {
        NavigationView {
            SavedInstanceExplorerView().rootModel(mockModel)
        }
        .environment(\.sizeCategory, .large)
        
        NavigationView {
            SavedInstanceExplorerView().rootModel(mockModel)
        }
        .environment(\.sizeCategory, .accessibilityLarge)
    }
}
