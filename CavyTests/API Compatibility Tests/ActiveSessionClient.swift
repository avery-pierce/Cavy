//
//  ActiveSessionClient.swift
//  CavyTests
//
//  Created by Avery Pierce on 2/20/21.
//

import Foundation
import XCTest
@testable import Cavy

class ActiveSessionClient {
    var anonymousClient: LemmyAPIClient
    var activeClient: LemmyAPIClient?
    
    init(_ anonymousClient: LemmyAPIClient) {
        self.anonymousClient = anonymousClient
        self.activeClient = nil
    }
    
    func vend(_ completion: @escaping (LemmyAPIClient?) -> Void, file: StaticString = #filePath, line: UInt = #line) {
        if let activeClient = activeClient {
            completion(activeClient)
        }
        
        guard let (username, password) = getCredentials() else {
            completion(nil)
            return
        }
        
        let call: Spec<URLRequest, LemmyLoginResponse>
        
        switch anonymousClient {
        case .v2(let spec): call = spec.login(usernameOrEmail: username, password: password)
        case .v1(let spec): call = spec.login(usernameOrEmail: username, password: password)
        }
        
        call.load { (result) in
            switch result {
            case .success(let tokenWrapper):
                self.activeClient = self.anonymousClient.authenticated(as: username, jwt: tokenWrapper.jwt)
                
            case .failure(let error):
                print(error)
            }
            
            completion(self.activeClient)
        }
    }
    
    func getCredentials() -> (username: String, password: String)? {
        
        let versionString: String
        
        switch anonymousClient {
        case .v1: versionString = "loginV1"
        case .v2: versionString = "loginV2"
        }
        
        // Don't commit usernames and passwords to source control.
        // Instead, load them from (gitignore'd) secrets file.
        let secrets = Secrets.load()?[versionString] as? [String: String]
        let _username = secrets?["username"]
        let _password = secrets?["password"]
        
        guard let username = _username, let password = _password else { return nil }
        return (username: username, password: password)
    }
}
