//
//  XCTestCaseExtension.swift
//  CavyTests
//
//  Created by Avery Pierce on 3/26/21.
//

import Foundation
import XCTest

extension XCTestCase {
    
    /// Wraps `block` in expectations
    open func expect(_ name: String, timeout: TimeInterval = 10, _ block: @escaping (_ completion: @escaping (Error?) -> Void) -> Void) {
        let e = expectation(description: name)
        
        block { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            } else {
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
