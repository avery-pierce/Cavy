//
//  SiteLoader.swift
//  Cavy
//
//  Created by Avery Pierce on 2/14/21.
//

import SwiftUI

struct InstanceSiteLoader<Content: View>: View {
    let client: LemmyAPIClient
    let content: (LoadState<CavySiteConvertable, Error>) -> Content
    
    init(_ client: LemmyAPIClient = .lemmyML, @ViewBuilder content: @escaping (LoadState<CavySiteConvertable, Error>) -> Content) {
        self.client = client
        self.content = content
    }
    
    var siteResource: ParsedDataResource<CavySiteConvertable> {
        switch client {
        case .v1(let spec): return ParsedDataResource(spec.fetchSite())
        case .v2(let spec): return ParsedDataResource(spec.fetchSite())
        }
    }
    
    var body: some View {
        Loader(siteResource) { loadState in
            content(loadState)
        }
    }
}
