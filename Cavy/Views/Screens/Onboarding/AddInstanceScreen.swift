//
//  AddInstanceScreen.swift
//  Cavy
//
//  Created by Avery Pierce on 2/15/21.
//

import SwiftUI

struct AddInstanceScreen: View {
    let site: CavySite
    let anonymousClient: LemmyAPIClient
    let onConfirm: (LemmyAPIClient) -> Void
    
    @State var username: String = ""
    @State var password: String = ""
    
    init(anonymousClient: LemmyAPIClient, site: CavySite, onConfirm: @escaping (LemmyAPIClient) -> Void) {
        self.site = site
        self.anonymousClient = anonymousClient
        self.onConfirm = onConfirm
    }
    
    var body: some View {
        ScrollView {
            VStack {
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
                
                Text(anonymousClient.host).font(.title2)
                
                APILevelTidbit()
                
                LoginForm(anonymousClient: anonymousClient, onSuccess: onConfirm)
                
                LabeledDivider(content: Text("OR")).padding(.horizontal)
                
                FillButton("Continue as guest")
                    .onTapGesture(perform: continueAsGuest)
                    .padding(.horizontal)
            }
            .padding(.vertical, 12.0)
        }
        .background(Color.systemGroupedBackground.ignoresSafeArea())
    }
    
    func continueAsGuest() {
        onConfirm(anonymousClient)
    }
}

struct AddInstanceScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddInstanceScreen(anonymousClient: .lemmyML, site: LemmySiteResponse.sampleData.cavySite, onConfirm: { _ in })
    }
}
