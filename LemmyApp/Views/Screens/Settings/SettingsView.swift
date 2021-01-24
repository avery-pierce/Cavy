//
//  SettingsView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/14/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var rootModel: RootModel
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: EditInstancesView()) {
                    Text("Edit Instances")
                }
            }.navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().rootModel(RootModel())
    }
}
