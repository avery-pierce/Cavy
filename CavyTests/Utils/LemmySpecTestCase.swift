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
    
    static let localhostV2Spec = LemmyV2Spec("localhost:8536", https: false)
    let v2Client: LemmyV2Spec = LemmySpecTestCase.localhostV2Spec
    let v2ActiveSession = ActiveSessionClient(LemmyAPIClient(LemmySpecTestCase.localhostV2Spec))
    
    static let localhostV1Spec = LemmyV1Spec("localhost:8536", https: false)
    let v1Client: LemmyV1Spec = LemmySpecTestCase.localhostV1Spec
    let v1ActiveSession = ActiveSessionClient(LemmyAPIClient(LemmySpecTestCase.localhostV1Spec))
    
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
            v2ActiveSession.vend { (authClient) in
                guard let authClient = authClient, case .v2(let client) = authClient else { return XCTFail() }
                block(client)
            }
            
        case .anonymous:
            block(v2Client)
        }
    }
    
    open func expectWithAuthedV1Client(_ name: String, timeout: TimeInterval = 10, _ block: @escaping (LemmyV1Spec, @escaping (Error?) -> Void) -> Void) {
        expectWithV1Client(.authenticated, description: name, timeout: timeout, block)
    }
    
    open func expectWithAnonV1Client(_ name: String, timeout: TimeInterval = 10, _ block: @escaping (LemmyV1Spec, @escaping (Error?) -> Void) -> Void) {
        expectWithV1Client(.anonymous, description: name, timeout: timeout, block)
    }
    
    open func expectWithV1Client(_ scope: ClientScope, description: String, timeout: TimeInterval = 10, _ block: @escaping (LemmyV1Spec, @escaping (Error?) -> Void) -> Void) {
        expect(name, timeout: timeout) { onComplete in
            self.withV1Client(scope) { client in
                block(client, onComplete)
            }
        }
    }
    
    open func withV1Client(_ scope: ClientScope, _ block: @escaping (LemmyV1Spec) -> Void) {
        switch scope {
        case .authenticated:
            v1ActiveSession.vend { (authClient) in
                guard let authClient = authClient, case .v1(let client) = authClient else { return XCTFail() }
                block(client)
            }
            
        case .anonymous:
            block(v1Client)
        }
    }
}
