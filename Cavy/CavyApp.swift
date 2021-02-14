//
//  LemmyAppApp.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import SwiftUI

@main
struct CavyApp: App {
    @StateObject var rootModel = RootModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if (rootModel.needsOnboarding) {
                    OnboardingNavigationView()
                        .environmentObject(rootModel)
                } else {
                    MainTabView()
                        .environmentObject(rootModel)
                }
            }
            .animation(.easeIn, value: rootModel.needsOnboarding)
        }
    }
}
