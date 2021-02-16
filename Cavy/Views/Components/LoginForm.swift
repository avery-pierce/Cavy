//
//  LoginForm.swift
//  Cavy
//
//  Created by Avery Pierce on 2/15/21.
//

import SwiftUI

struct LoginForm: View {
    @State var username: String = ""
    @State var password: String = ""
    
    let anonymousClient: LemmyAPIClient
    let onSuccess: (LemmyAPIClient) -> Void
    init(anonymousClient: LemmyAPIClient, onSuccess: @escaping (LemmyAPIClient) -> Void) {
        self.anonymousClient = anonymousClient
        self.onSuccess = onSuccess
    }
    
    var body: some View {
        VStack {
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
        }
    }
    
    func login() {
        switch (anonymousClient) {
        case .v2(let spec):
            spec.login(usernameOrEmail: username, password: password).load { result in
                switch result {
                case .success(let jwtWrapper):
                    let jwt = jwtWrapper.jwt
                    
                    KeychainUseCase().storeJWT(jwt, forUser: username, onServer: anonymousClient.host)
                    onSuccess(anonymousClient.authenticated(as: username, jwt: jwtWrapper.jwt))
                    
                case .failure(let error):
                    print("Error \(error)")
                }
            }
            
        case .v1(let spec):
            spec.login(usernameOrEmail: username, password: password).load { result in
                switch result {
                case .success(let jwtWrapper):
                    let jwt = jwtWrapper.jwt
                    
                    KeychainUseCase().storeJWT(jwt, forUser: username, onServer: anonymousClient.host)
                    onSuccess(anonymousClient.authenticated(as: username, jwt: jwtWrapper.jwt))
                    
                case .failure(let error):
                    print("Error \(error)")
                }
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(anonymousClient: .lemmyML, onSuccess: { _ in })
    }
}
