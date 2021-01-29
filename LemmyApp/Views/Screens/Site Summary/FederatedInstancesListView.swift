//
//  FederatedInstancesListView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct FederatedInstancesListView: View {
    let federatedInstances: [String]
    init(_ federatedInstances: [String]) {
        self.federatedInstances = federatedInstances
    }
    
    var body: some View {
        List {
            ForEach(federatedInstances, id: \.self) { instance in
                NavigationLink(instance, destination: SiteSummaryLoaderView(LemmyAPIFactory(instance)))
            }
        }
        .navigationTitle("Federated Instances")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FederatedInstancesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FederatedInstancesListView(LemmySiteResponse.sampleData.federatedInstances)
        }
    }
}
