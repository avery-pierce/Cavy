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
    
    var body: some View {
        LoadStateView(loadState) { client in
            InstanceSiteLoader(client) { siteLoadState in
                LoadStateView(siteLoadState.map(\.cavySite)) { site in
                    ScrollView {
                        LazyVStack {
                            if let icon = site.iconURL {
                                Loader(CachingDataProvider(icon), parsedBy: imageParser) { state in
                                    LoadStateView(state) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxHeight: 200)
                                            .padding(.horizontal, 12.0)
                                    }
                                }
                            }
                            
                            Text(site.name)
                                .font(.title)
                                .bold()
                            
                            Text(client.host).font(.title2)
                            
                            APILevelTidbit()
                            
                            FillButton("Select \(site.name)")
                                .onTapGesture {
                                    onConfirm(client)
                                }
                                .padding(.horizontal)
                            
                            if let description = site.descriptionMarkdown {
                                MarkdownText(description)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.secondarySystemGroupedBackground))
                                    .padding(.horizontal)
                            }
                            
                            
                        }
                        .padding(.vertical, 12.0)
                    }
                    .background(Color.systemGroupedBackground.ignoresSafeArea())
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
