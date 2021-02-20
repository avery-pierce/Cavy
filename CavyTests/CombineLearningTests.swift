//
//  CombineLearningTests.swift
//  CavyTests
//
//  Created by Avery Pierce on 2/19/21.
//

import XCTest
import Combine
@testable import Cavy

class CombineLearningTests: XCTestCase {
    func testCombineLatestAll() throws {
        
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        let letterSubjects = alphabet.map(CurrentValueSubject<String.Element, Never>.init)
        let letterPublishers = letterSubjects.map({ $0.eraseToAnyPublisher() })
        
        let e = expectation(description: "Collect published")
        let cancelable = combineLatestAll(letterPublishers).collect(4).sink { (charArrays) in
            let strings = charArrays.map(String.init(_:))
            XCTAssertEqual(strings, [
                "abcdefghijklmnopqrstuvwxyz",
                "Xbcdefghijklmnopqrstuvwxyz",
                "XXcdefghijklmnopqrstuvwxyz",
                "XXXdefghijklmnopqrstuvwxyz",
            ])
            e.fulfill()
        }
        
        letterSubjects[0].value = "X"
        letterSubjects[1].value = "X"
        letterSubjects[2].value = "X"
        
        cancelable.cancel()
        waitForExpectations(timeout: 1, handler: nil)
    }
}


