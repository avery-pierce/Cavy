//
//  LemmyAppTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 10/9/20.
//

import XCTest
@testable import LemmyApp

class LemmyAppTests: XCTestCase {

    func testListCommunities() throws {
        let e = expectation(description: "List Communities")
        let request = LemmyAPIClient.devLemmyMl.listCommunities(sort: .hot)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return XCTFail(error.localizedDescription)
            }
            
            guard let data = data else {
                debugPrint(response ?? "(no response)")
                return XCTFail("An error did not occur, but data was nil")
            }
            
            do {
                let _ = try JSONDecoder().decode(LemmyCommunitiesResponse.self, from: data)
                e.fulfill()
            } catch let error {
                XCTFail("Error occurred during parsing: \(error.localizedDescription)")
            }
        }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testListPosts() throws {
        let e = expectation(description: "List Posts")
        let request = LemmyAPIClient.devLemmyMl.listPosts(type: .all, sort: .hot)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return XCTFail(error.localizedDescription)
            }
            
            guard let data = data else {
                debugPrint(response ?? "(no response)")
                return XCTFail("An error did not occur, but data was nil")
            }
            
            do {
                let _ = try JSONDecoder().decode(LemmyPostItemResponse.self, from: data)
                e.fulfill()
            } catch let error {
                XCTFail("Error occurred during parsing: \(error.localizedDescription)")
            }
        }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testListComments() throws {
        let e = expectation(description: "Get post")
        let request = LemmyAPIClient.devLemmyMl.path("api/v1/post?id=41326")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return XCTFail(error.localizedDescription)
            }
            
            guard let data = data else {
                debugPrint(response ?? "(no response)")
                return XCTFail("An error did not occur, but data was nil")
            }
            
            do {
                let _ = try JSONDecoder().decode(LemmyPostResponse.self, from: data)
                e.fulfill()
            } catch let error {
                XCTFail("Error occurred during parsing: \(error.localizedDescription)")
            }
        }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

func prettyPrintJSON(_ data: Data) throws -> String {
    let object = try JSONSerialization.jsonObject(with: data, options: [])
    let prettyData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
    let string = String(data: prettyData, encoding: .utf8)!
    return string
}


