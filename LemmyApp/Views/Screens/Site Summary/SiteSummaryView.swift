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
    
    var site: CavySite
    init(_ site: CavySite) {
        self.site = site
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if let icon = site.iconURL {
                    Loader(icon, parsedBy: imageParser) { state in
                        LoadStateView(state) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                
                Text(site.name)
                    .font(.title)
                    .bold()
                
                Text(client.descriptor).font(.title2)
                
                if let description = site.descriptionMarkdown {
                    HStack {
                        MarkdownText(description)
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.secondarySystemGroupedBackground))
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    
                    NavigationLink(destination: LoadableListingView(client)) {
                        ListCellView {
                            Text("Posts").bold()
                        }
                        .padding(.top, 8)
                    }
                    Divider()
                
                    if let numberOfUsers = site.numberOfUsers {
                        ListCellView {
                            Text("\(numberOfUsers) users")
                        }
                        Divider()
                    }
                    
                    if let numberOfCommunities = site.numberOfCommunities {
                        NavigationLink(destination: LoadableCommunitiesView().lemmyAPIClient(client)) {
                            ListCellView {
                                Text("\(numberOfCommunities) communities")
                            }
                        }
                        Divider()
                    }
                    
                    if let admins = site.admins {
                        NavigationLink(destination: UsersListView(admins).navigationTitle("Admins")) {
                            ListCellView {
                                Text("\(admins.count) admins")
                            }
                        }
                        Divider()
                    }
                    
                    if let bannedUsers = site.banned {
                        NavigationLink(destination: UsersListView(bannedUsers).navigationTitle("Banned Users")) {
                            ListCellView {
                                Text("\(bannedUsers.count) banned users")
                            }
                        }
                        Divider()
                    }
                    
                    if let federatedInstances = site.federatedInstances {
                        NavigationLink(destination: FederatedInstancesListView(federatedInstances)) {
                            ListCellView {
                                Text("\(federatedInstances.count) federated instances")
                            }
                        }
                        Divider()
                    }
                }
                .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.secondarySystemGroupedBackground))
                .padding(.horizontal)
            }
        }
        .background(Color.systemGroupedBackground.ignoresSafeArea())
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
                SiteSummaryView(LemmySiteResponse.sampleData.cavySite)
            }
            .navigationBarTitleDisplayMode(.inline)
            
            NavigationView {
                SiteSummaryView(LemmySiteResponse.sampleData.cavySite)
            }
            .navigationBarTitleDisplayMode(.inline)
            .colorScheme(.dark)
            
        }.rootModel(modelWithNoClients)
    }
}
