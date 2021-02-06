//
//  LemmyV2APIConsumerTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/29/21.
//

import XCTest
@testable import LemmyApp

class LemmyV2SpecTests: XCTestCase {

    let client: LemmyV2Spec = .lemmyML
    
    func testListCommunities() throws {
        let e = expectation(description: "List Communities")
        let spec = client.listCommunities(sort: .hot)
        assertDecodes(spec) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testListPosts() throws {
        let e = expectation(description: "List Posts")
        let spec = client.listPosts(type: .all, sort: .hot)
        assertDecodes(spec) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testListPostsByCommunity() throws {
        let e = expectation(description: "List Posts")
        let spec = client.listPosts(type: .all, sort: .hot, communityID: 1)
        assertDecodes(spec) {
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
        let spec = client.fetchPost(id: 41391)
        assertDecodes(spec) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetSiteData() throws {
        let e = expectation(description: "Fetch Site")
        let spec = client.fetchSite()
        assertDecodes(spec) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

func assertDecodes<D: DataProvider, T: Codable>(_ dataPackage: Spec<D, T>, file: StaticString = #filePath, line: UInt = #line, completion: @escaping () -> Void) {
    dataPackage.dataProvider.getData { (result) in
        let data = assertSuccess(result, file: file, line: line)
        assertDecodes(to: dataPackage.type, from: data, file: file, line: line)
        completion()
    }
}
