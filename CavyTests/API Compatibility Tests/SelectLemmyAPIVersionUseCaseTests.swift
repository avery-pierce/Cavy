//
//  SelectLemmyAPIVersionUseCaseTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/30/21.
//

import XCTest
@testable import Cavy

class SelectLemmyAPIVersionUseCaseTests: XCTestCase {

    func testV2API() {
        let e = expectation(description: "Select Lemmy API version")
        let useCase = SelectLemmyAPIVersionUseCase("lemmy.ml")
        useCase.determineAPI { (result) in
            // As of Jan 30, 2021, this should return V2
            switch result {
            case .success(let client):
                switch client {
                case .v2:
                    e.fulfill()
                default:
                    XCTFail("Did not resolve to V2")
                }
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testV1API() {
        let e = expectation(description: "Select Lemmy API version")
        let useCase = SelectLemmyAPIVersionUseCase("chapo.chat")
        useCase.determineAPI { (result) in
            // As of Jan 30, 2021, this should return V1
            switch result {
            case .success(let client):
                switch client {
                case .v1:
                    e.fulfill()
                default:
                    XCTFail("Did not resolve to V1")
                }
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidAPI() {
        let e = expectation(description: "Select Lemmy API version")
        let useCase = SelectLemmyAPIVersionUseCase("example.com")
        useCase.determineAPI { (result) in
            // As of Jan 30, 2021, this should return invalid
            switch result {
            case .success:
                XCTFail("Should not have succeeded")
            case .failure:
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
