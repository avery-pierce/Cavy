//
//  SiteSummaryView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct SiteSummaryView: View {
    @EnvironmentObject var rootModel: RootModel
    @Environment(\.lemmyAPIClient) var client
    @Environment(\.colorScheme) var colorScheme
    
    var siteResponseState: LoadState<LemmySiteResponse, Error>
    
    var siteResponse: LemmySiteResponse? {
        siteResponseState.value
    }
    
    var site: LemmySite? {
        siteResponse?.site
    }
    
    var backgroundColor: Color {
        switch colorScheme {
        case .dark:
            return Color(hue: 0.6, saturation: 0.1, brightness: 0.1)
        default:
            return Color(hue: 0.6, saturation: 0.04, brightness: 0.97)
        }
    }
    
    var backdropColor: Color {
        switch colorScheme {
        case .dark:
            return .black
        default:
            return .white
        }
    }
    
    var saveInstanceButton: some View {
        Button(action: toggleSiteSaved) {
            isServerSaved ? Image(systemName: "star.fill") : Image(systemName: "star")
        }
    }

    var isServerSaved: Bool {
        return rootModel.clients.contains(where: { $0.descriptor == client.descriptor })
    }
    
    func toggleSiteSaved() {
        if isServerSaved {
            rootModel.removeServer(client)
        } else {
            rootModel.addServer(client)
        }
    }
    
    var body: some View {
        LoadStateView(siteResponseState) { (siteResponse) in
            ScrollView {
                LazyVStack {
                    if let icon = site?.icon.flatMap(URL.init(string:)) {
                        Loader(icon, parsedBy: imageParser) { state in
                            LoadStateView(state) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                    
                    Text(siteResponse.site?.name ?? "")
                        .font(.title)
                        .bold()
                    
                    Text(client.descriptor).font(.title2)
                    
                    if let description = siteResponse.site?.description {
                        HStack {
                            MarkdownText(description)
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8.0).fill(backdropColor))
                        .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading) {
                        if site != nil {
                            NavigationLink(destination: LoadableListingView(client)) {
                                ListCellView {
                                    Text("Posts").bold()
                                }
                                .padding(.top, 8)
                            }
                            Divider()
                        }
                        
                        if let numberOfUsers = site?.numberOfUsers {
                            ListCellView {
                                Text("\(numberOfUsers) users")
                            }
                            Divider()
                        }
                        
                        if let numberOfCommunities = site?.numberOfCommunities {
                            NavigationLink(destination: LoadableCommunitiesView().lemmyAPIClient(client)) {
                                ListCellView {
                                    Text("\(numberOfCommunities) communities")
                                }
                            }
                            Divider()
                        }
                        
                        if let admins = siteResponse.admins {
                            NavigationLink(destination: UsersListView(admins).navigationTitle("Admins")) {
                                ListCellView {
                                    Text("\(admins.count) admins")
                                }
                            }
                            Divider()
                        }
                        
                        if let bannedUsers = siteResponse.banned {
                            NavigationLink(destination: UsersListView(bannedUsers).navigationTitle("Banned Users")) {
                                ListCellView {
                                    Text("\(bannedUsers.count) banned users")
                                }
                            }
                            Divider()
                        }
                        
                        if let federatedInstances = siteResponse.federatedInstances {
                            NavigationLink(destination: FederatedInstancesListView(federatedInstances)) {
                                ListCellView {
                                    Text("\(federatedInstances.count) federated instances")
                                }
                            }
                            Divider()
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 8.0).fill(backdropColor))
                    .padding(.horizontal)
                }
            }
            .background(backgroundColor.ignoresSafeArea())
            
        }
        .navigationBarItems(trailing: saveInstanceButton)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SiteSummaryView_Previews: PreviewProvider {
    static let modelWithNoClients: RootModel = {
        var model = RootModel()
        while model.clients.count > 0 {
            model.removeServer(at: 0)
        }
        return model
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                SiteSummaryView(siteResponseState: .success(LemmySiteResponse.sampleData))
            }
            .navigationBarTitleDisplayMode(.inline)
            
            NavigationView {
                SiteSummaryView(siteResponseState: .success(LemmySiteResponse.sampleData))
            }
            .navigationBarTitleDisplayMode(.inline)
            .colorScheme(.dark)
            
        }.rootModel(modelWithNoClients)
    }
}
