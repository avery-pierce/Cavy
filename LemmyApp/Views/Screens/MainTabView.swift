//
//  MainTabView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var rootModel: RootModel
    
    var body: some View {
        TabView {
            NavigationView {
                SavedInstanceExplorerView()
            }.tabItem {
                Label("Instances", systemImage: "binoculars")
            }
            
            ForEach(rootModel.clients, id: \.descriptor) { client in
                NavigationView {
                    SiteSummaryLoaderView(client)
                }.tabItem {
                    Label(client.descriptor, systemImage: "globe")
                }
            }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().rootModel(RootModel())
    }
}