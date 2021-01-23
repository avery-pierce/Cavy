//
//  MainTabView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var rootModel: RootModel
    init(_ rootModel: RootModel) {
        self.rootModel = rootModel
    }
    
    var body: some View {
        TabView {
            ForEach(rootModel.clients, id: \.host) { client in
                NavigationView {
                    SiteSummaryLoaderView(client)
                }.tabItem {
                    Image(systemName: "globe")
                    Text(client.host)
                }
            }
            
            SettingsView(rootModel)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(RootModel())
    }
}
