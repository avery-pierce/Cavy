//
//  SavedInstanceExplorerView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/24/21.
//

import SwiftUI

struct SavedInstanceExplorerView: View {
    @Environment(\.rootModel) var rootModel: RootModel
    
    var hosts: [String] {
        return rootModel.clients.map(\.host)
    }
    
    var body: some View {
        FederatedInstancesListView(hosts)
    }
}

struct SavedInstanceExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        SavedInstanceExplorerView().rootModel(RootModel())
    }
}
