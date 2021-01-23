//
//  SiteSummaryView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct SiteSummaryView: View {
    @Environment(\.lemmyAPIClient) var client
    var siteResponseState: LoadState<LemmySiteResponse, Error>
    
    var siteResponse: LemmySiteResponse? {
        return siteResponseState.value
    }
    
    var site: LemmySite? {
        siteResponse?.site
    }
    
    var body: some View {
        List {
            if let siteResponse = siteResponse {
                if let icon = site?.icon {
                    Loader(icon, parsedBy: imageParser) { state in
                        LoadStateView(state) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                
                Section {
                    if let name = site?.name {
                        Text(name)
                    }
                    
                    if let description = site?.description {
                        Text(description)
                    }
                }
                
                Section {
                    if site != nil {
                        NavigationLink("Posts", destination: LoadableListingView(client))
                    }
                    
                    if let numberOfUsers = site?.numberOfUsers {
                        Text("\(numberOfUsers) users")
                    }
                    
                    if let numberOfCommunities = site?.numberOfCommunities {
                        NavigationLink("\(numberOfCommunities) communities", destination: LoadableCommunitiesView().lemmyAPIClient(client))
                    }
                    
                    if let admins = siteResponse.admins {
                        NavigationLink("\(admins.count) admins", destination: UsersListView(admins).navigationTitle("Admins"))
                    }
                    
                    if let bannedUsers = siteResponse.banned {
                        NavigationLink("\(bannedUsers.count) banned users", destination: UsersListView(bannedUsers).navigationTitle("Banned Users"))
                    }
                    
                    if let federatedInstances = siteResponse.federatedInstances {
                        NavigationLink("\(federatedInstances.count) federated instances", destination: FederatedInstancesListView(federatedInstances))
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(client.host)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SiteSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SiteSummaryView(siteResponseState: .success(LemmySiteResponse.sampleData))
            }
        }
    }
}
