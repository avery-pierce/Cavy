//
//  LemmyAppApp.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import SwiftUI

@main
struct LemmyAppApp: App {
    @StateObject var rootModel = RootModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(rootModel.posts)
                    .onAppear(perform: rootModel.refresh)
                    .navigationBarItems(trailing: Button(action: rootModel.refresh) {
                        Image(systemName: "arrow.clockwise")
                    })
                    .navigationTitle("Lemmy")
            }
        }
    }
}
