//
//  FederatedIntancesCellTidbit.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct FederatedIntancesCellTidbit: View {
    let federatedInstances: [String]
    
    var body: some View {
        NavigationLink(destination: FederatedInstancesListView(federatedInstances)) {
            ImageCellTidbit(image: Image(systemName: "network"), line1: "\(federatedInstances.count)", line2: "Instances")
        }
    }
}

struct FederatedIntancesCellTidbit_Previews: PreviewProvider {
    static let mockSite = LemmySiteResponse.sampleData.cavySite
    
    static var previews: some View {
        FederatedIntancesCellTidbit(federatedInstances: mockSite.federatedInstances!)
    }
}
