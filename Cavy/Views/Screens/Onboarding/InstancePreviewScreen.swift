//
//  InstancePreviewScreen.swift
//  Cavy
//
//  Created by Avery Pierce on 2/14/21.
//

import SwiftUI

struct InstancePreviewScreen: View {
    let host: String
    let onConfirm: (LemmyAPIClient) -> Void
    init(host: String, onConfirm: @escaping (LemmyAPIClient) -> Void) {
        self.host = host
        self.onConfirm = onConfirm
    }
    
    @State var loadState: LoadState<LemmyAPIClient, Error> = .idle
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        LoadStateView(loadState) { client in
            InstanceSiteLoader(client) { siteLoadState in
                LoadStateView(siteLoadState.map(\.cavySite)) { site in
                    AddInstanceScreen(anonymousClient: client, site: site, onConfirm: onConfirm)
                }
            }
        }
        .onAppear(perform: {
            loadState = .loading(nil)
            SelectLemmyAPIVersionUseCase(host).determineAPI { (result) in
                self.loadState = .complete(result)
            }
        })
    }
}
