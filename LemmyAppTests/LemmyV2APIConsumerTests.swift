//
//  LemmyV2APIConsumerTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/29/21.
//

import XCTest
@testable import LemmyApp

class LemmyV2APIConsumerTests: XCTestCase {

    let client: LemmyV2APIClient = .lemmyML
    
    func testListCommunities() throws {
        let e = expectation(description: "List Communities")
        let spec = client.listCommunities(sort: .hot)
        assertDecodes(spec) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
//    func testListPosts() throws {
//        let e = expectation(description: "List Posts")
//        let request = client.listPosts(type: .all, sort: .hot)
//        assertDecodes(to: LemmyPostItemResponse.self, fromDataProvidedBy: request) {
//            e.fulfill()
//        }
//        
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//    
//    func testListComments() throws {
//        /*
//         Some good examples:
//         Post ID: 41391
//         post ID: 41326
//         */
//        let e = expectation(description: "Get post")
//        let request = client.fetchPost(id: 41391)
//        assertDecodes(to: LemmyPostResponse.self, fromDataProvidedBy: request) {
//            e.fulfill()
//        }
//        
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//    
//    func testGetSiteData() throws {
//        let e = expectation(description: "Fetch Site")
//        let request = client.fetchSite()
//        assertDecodes(to: LemmySiteResponse.self, fromDataProvidedBy: request) {
//            e.fulfill()
//        }
//        
//        waitForExpectations(timeout: 5, handler: nil)
//    }
}

func assertDecodes<D: DataProvider, T: Codable>(_ dataPackage: APIDataProvider<D, T>, file: StaticString = #filePath, line: UInt = #line, completion: @escaping () -> Void) {
    dataPackage.dataProvider.getData { (result) in
        let data = assertSuccess(result, file: file, line: line)
        assertDecodes(to: dataPackage.serializedType, from: data, file: file, line: line)
        completion()
    }
}
