//
//  EditInstancesView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/14/20.
//

import SwiftUI

struct EditInstancesView: View {
    @ObservedObject var rootModel: RootModel
    
    
    init(_ rootModel: RootModel) {
        self.rootModel = rootModel
    }
    
    var body: some View {
        Form {
            Section {
                ForEach(rootModel.clients, id: \.host) { (client) in
                    Text(client.host)
                }.onDelete(perform: { indexSet in
                    indexSet.forEach(rootModel.removeServer(at:))
                })
            }
            EditHostsView(rootModel.createAddServerUseCase())
        }
        .navigationTitle("Edit Instances")
    }
}

struct EditInstancesView_Previews: PreviewProvider {
    static var previews: some View {
        EditInstancesView(RootModel())
    }
}
