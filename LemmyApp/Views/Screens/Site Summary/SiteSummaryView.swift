//
//  SiteSummaryView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct SiteSummaryView: View {
    var siteResponseState: LoadState<LemmySiteResponse, Error>
    
    var siteResponse: LemmySiteResponse? {
        return siteResponseState.value
    }
    
    var site: LemmySite? {
        siteResponse?.site
    }
    
    var body: some View {
        List {
            
            if let siteResponse = siteResponse {
                Section {
                    if let name = site?.name {
                        Text(name)
                    }
                    
                    if let numberOfUsers = site?.numberOfUsers {
                        Text("\(numberOfUsers) users")
                    }
                    
                    Text("\(siteResponse.admins.count) admins")
                    
                    Text("\(siteResponse.banned.count) banned users")
                    
                    Text("\(siteResponse.federatedInstances.count) federated instances")
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

struct SiteSummaryView_Previews: PreviewProvider {
    static let previewSite = try! LemmySiteResponse.fromJSON(fileNamed: "20210122_lemmy_ml_stite", withExtension: ".json")
    
    static var previews: some View {
        Group {
            NavigationView {
                SiteSummaryView(siteResponseState: .success(previewSite))
            }
        }
    }
}
