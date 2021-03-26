//
//  LemmySpecTestCase.swift
//  CavyTests
//
//  Created by Avery Pierce on 3/26/21.
//

import Foundation
import XCTest
@testable import Cavy

open class LemmySpecTestCase: XCTestCase {
    
    static let localhostSpec = LemmyV2Spec("localhost:8536", https: false)
    
    let client: LemmyV2Spec = LemmyV2SpecTests.localhostSpec
    let activeSession = ActiveSessionClient(LemmyAPIClient(LemmyV2SpecTests.localhostSpec))
    
    public enum ClientScope {
        case anonymous
        case authenticated
    }
    
    open func expectWithAuthedV2Client(_ name: String, timeout: TimeInterval = 10, _ block: @escaping (LemmyV2Spec, @escaping (Error?) -> Void) -> Void) {
        expectWithV2Client(.authenticated, description: name, timeout: timeout, block)
    }
    
    open func expectWithAnonV2Client(_ name: String, timeout: TimeInterval = 10, _ block: @escaping (LemmyV2Spec, @escaping (Error?) -> Void) -> Void) {
        expectWithV2Client(.anonymous, description: name, timeout: timeout, block)
    }
    
    open func expectWithV2Client(_ scope: ClientScope, description: String, timeout: TimeInterval = 10, _ block: @escaping (LemmyV2Spec, @escaping (Error?) -> Void) -> Void) {
        expect(name, timeout: timeout) { onComplete in
            self.withV2Client(scope) { client in
                block(client, onComplete)
            }
        }
    }
    
    open func withV2Client(_ scope: ClientScope, _ block: @escaping (LemmyV2Spec) -> Void) {
        switch scope {
        case .authenticated:
            activeSession.vend { (authClient) in
                guard let authClient = authClient, case .v2(let client) = authClient else { return XCTFail() }
                block(client)
            }
            
        case .anonymous:
            block(client)
        }
    }
}
