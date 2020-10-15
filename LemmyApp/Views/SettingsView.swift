//
//  SettingsView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/14/20.
//

import SwiftUI

struct SettingsView: View {
    let rootModel: RootModel
    init(_ rootModel: RootModel) {
        self.rootModel = rootModel
    }
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: EditInstancesView(rootModel)) {
                    Text("Edit Instances")
                }
            }.navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(RootModel())
    }
}
