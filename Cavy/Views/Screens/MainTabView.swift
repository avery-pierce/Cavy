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
            ForEach(rootModel.appTabs, id: \.id) { (appTab) in
                switch appTab {
                case .listing(let listing):
                    NavigationView {                    
                        LoadingPostListView(listing)
                    }
                        .tabItem {
                            Label(listing.title, systemImage: "globe")
                        }
                }
            }
            
            NavigationView {
                SavedInstanceExplorerView()
            }.tabItem {
                Label("Instances", systemImage: "binoculars")
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().rootModel(RootModel())
    }
}
