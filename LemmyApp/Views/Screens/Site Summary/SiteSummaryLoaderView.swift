//
//  SiteSummaryLoaderView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct SiteSummaryLoaderView: View {
    let client: LemmyAPIFactory
    
    init(_ client: LemmyAPIFactory = .lemmyML) {
        self.client = client
    }
    
    var body: some View {
        Loader(client.fetchSite(), parsedBy: LemmySiteResponse.fromJSON) { loadState in
        
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
