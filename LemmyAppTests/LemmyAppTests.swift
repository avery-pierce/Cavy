//
//  LemmyAppTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 10/9/20.
//

import XCTest
@testable import LemmyApp

class LemmyAppTests: XCTestCase {
    
    let client: LemmyAPIClient = .devLemmyMl

    func testListCommunities() throws {
        let e = expectation(description: "List Communities")
        let request = client.listCommunities(sort: .hot)
        assertDecodes(to: LemmyCommunitiesResponse.self, fromDataProvidedBy: request) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testListPosts() throws {
        let e = expectation(description: "List Posts")
        let request = client.listPosts(type: .all, sort: .hot)
        assertDecodes(to: LemmyPostItemResponse.self, fromDataProvidedBy: request) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testListComments() throws {
        /*
         Some good examples:
         Post ID: 41391
         post ID: 41326
         */
        let e = expectation(description: "Get post")
        let request = client.fetchPost(id: 41391)
        assertDecodes(to: LemmyPostResponse.self, fromDataProvidedBy: request) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDocumentsFolder() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls)
    }
}

func prettyPrintJSON(_ data: Data) throws -> String {
    let object = try JSONSerialization.jsonObject(with: data, options: [])
    let prettyData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
    let string = String(data: prettyData, encoding: .utf8)!
    return string
}


