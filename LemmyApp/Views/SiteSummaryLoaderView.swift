//
//  SiteSummaryLoaderView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import SwiftUI

struct SiteSummaryLoaderView: View {
    let client: LemmyAPIClient
    
    @ObservedObject var loader: JSONLoader<LemmySiteResponse>
    
    init(_ client: LemmyAPIClient = .lemmyML) {
        self.client = client
        self.loader = JSONLoader<LemmySiteResponse>(client.fetchSite())
    }
    
    var body: some View {
        SiteSummaryView(siteResponseState: loader.state)
    }
}

struct SiteSummaryLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        SiteSummaryLoaderView()
    }
}
