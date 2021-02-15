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
                
                VStack(spacing: 0) {
                    TextField("Username", text: $username)
                        .frame(height: 44)
                        .padding(.horizontal)
                    Rectangle().frame(height: 1.0).foregroundColor(.accentColor)
                    SecureField("Password", text: $password)
                        .frame(height: 44)
                        .padding(.horizontal)
                }
                .background(Color.secondarySystemGroupedBackground)
                .mask(RoundedRectangle(cornerRadius: 8.0))
                .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(Color.accentColor, lineWidth: 1.0))
                .padding(.horizontal)
                
                FillButton("Login")
                    .onTapGesture(perform: login)
                    .padding(.horizontal)
                
                LabeledDivider(content: Text("OR")).padding(.horizontal)
                
                FillButton("Continue as guest")
                    .onTapGesture(perform: continueAsGuest)
                    .padding(.horizontal)
            }
            .padding(.vertical, 12.0)
        }
        .background(Color.systemGroupedBackground.ignoresSafeArea())
    }
    
    func login() {
        switch (anonymousClient) {
        case .v2(let spec):
            spec.login(usernameOrEmail: username, password: password).load { (result) in
                switch result {
                case .success(let jwtWrapper):
                    let jwt = jwtWrapper.jwt
                    
                    KeychainUseCase().storeJWT(jwt, forUser: username, onServer: anonymousClient.host)
                    
                    onConfirm(anonymousClient.authenticated(as: username, jwt: jwtWrapper.jwt))
                    
                case .failure(let error):
                    print("Error \(error)")
                }
            }
            
        case .v1: return
        }
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
