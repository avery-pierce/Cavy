//
//  SiteSummaryLoaderView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct SiteSummaryLoaderView: View {
    let client: LemmyAPIClient
    
    init(_ client: LemmyAPIClient = .lemmyML) {
        self.client = client
    }
    
    var siteResource: ParsedDataResource<LemmySiteResponse> {
        switch client {
        case .v1(let spec): return ParsedDataResource(spec.fetchSite())
        case .v2(let spec):
            let fetchSite = spec.fetchSite()
            return ParsedDataResource(fetchSite.dataProvider, parsedBy: typeAdapter(parser: jsonParser(fetchSite.type), adapter: { (v2) -> LemmySiteResponse in
                
                let site = v2.siteView?.site
                let admins = v2.admins?.compactMap(\.user) ?? []
                let banned = v2.banned?.compactMap(\.user) ?? []
                let online = v2.online
                let version = v2.version
                let myUser = v2.myUser
                let federatedInstances = v2.federatedInstances ?? []
                
                return LemmySiteResponse(site: site, admins: admins, banned: banned, online: online, version: version, myUser: myUser, federatedInstances: federatedInstances)
            }))
        }
    }
    
    var body: some View {
        Loader(siteResource) { loadState in
        
            SiteSummaryView(siteResponseState: loadState)
                .environment(\.lemmyAPIClient, client)
        }
    }
}

struct SiteSummaryLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        SiteSummaryLoaderView()
    }
}
