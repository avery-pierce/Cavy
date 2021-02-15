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
                    Loader(CachingDataProvider(icon), parsedBy: imageParser) { state in
                        LoadStateView(state) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 200)
                                .padding(.horizontal, 12.0)
                        }
                    }
                }
                
                Text(site.name)
                    .font(.title)
                    .bold()
                
                Text(client.host).font(.title2)
                
                APILevelTidbit()
                
                if (client.isAuthenticated) {
                    NavigationLink(destination: LoadingPostListView(.subscribed(client))) {
                        ListCellView {
                            Image(systemName: "tray.full")
                            VStack(alignment: .leading) {
                                Text("Subscribed Communities")
                                    .font(.system(size: 14.0))
                                    .bold()
                                Text(client.host)
                                    .font(.system(size: 12.0))
                                    .opacity(0.8)
                            }
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.secondarySystemGroupedBackground))
                    .padding(.horizontal)
                }
                
                NavigationLink(destination: LoadingPostListView(.allPosts(of: client))) {
                    ListCellView {
                        Image(systemName: "tray.full")
                        VStack(alignment: .leading) {
                            Text("All Posts")
                                .font(.system(size: 14.0))
                                .bold()
                            Text(client.host)
                                .font(.system(size: 12.0))
                                .opacity(0.8)
                        }
                    }
                }
                .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.secondarySystemGroupedBackground))
                .padding(.horizontal)
                
                SiteKPIsRow(site: site)
                    .padding(.horizontal)
                    .buttonStyle(DefaultButtonStyle())
                    .lemmyAPIClient(client)
                
                if let description = site.descriptionMarkdown {
                    MarkdownText(description)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.secondarySystemGroupedBackground))
                        .padding(.horizontal)
                }
                
                if let admins = site.admins {
                    NavigationLink(destination: UsersListView(admins).navigationTitle("Admins")) {
                        ListCellView {
                            Text("\(admins.count) admins")
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.secondarySystemGroupedBackground))
                    .padding(.horizontal)
                }
            }
            .padding(.vertical, 12.0)
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
