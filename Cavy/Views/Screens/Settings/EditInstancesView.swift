//
//  EditInstancesView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/14/20.
//

import SwiftUI

struct EditInstancesView: View {
    @EnvironmentObject var rootModel: RootModel
    
    var body: some View {
        Form {
            Section {
                ForEach(rootModel.clients, id: \.descriptor) { (client) in
                    Text(client.descriptor)
                }.onDelete(perform: { indexSet in
                    indexSet.forEach(rootModel.removeServer(at:))
                })
            }
            EditHostsView(rootModel.createAddServerUseCase())
            Section(header: Text("Good ones")) {
                ForEach(ClientStore.defaultServers, id: \.descriptor) { server in
                    Text(server.descriptor)
                }
            }
        }
        .navigationTitle("Edit Instances")
    }
}

struct EditInstancesView_Previews: PreviewProvider {
    static var previews: some View {
        EditInstancesView().rootModel(RootModel())
    }
}
