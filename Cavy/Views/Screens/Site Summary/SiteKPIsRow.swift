//
//  SiteKPIsRow.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/31/21.
//

import SwiftUI

struct SiteKPIsRow: View {
    let site: CavySite
    
    var body: some View {
        HStack {
            if let numberOfUsers = site.numberOfUsers {
                UsersCellTidbit(numberOfUsers: numberOfUsers)
                    .frame(maxWidth: .infinity)
            }
            
            if let numberOfCommunities = site.numberOfCommunities {
                CommunitiesCellTidbit(numberOfCommunities: numberOfCommunities)
                    .frame(maxWidth: .infinity)
            }
            
            if let federatedInstances = site.federatedInstances {
                FederatedIntancesCellTidbit(federatedInstances: federatedInstances)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
//        .buttonStyle(PlainButtonStyle())
    }
}

struct SiteKPIsRow_Previews: PreviewProvider {
    static let mockSite = LemmySiteResponse.sampleData.cavySite
    
    static var previews: some View {
        SiteKPIsRow(site: mockSite)
            .padding()
            .foregroundColor(.black)
            .accentColor(Color.blue.opacity(0.2))
            .background(Color.gray)
    }
}
