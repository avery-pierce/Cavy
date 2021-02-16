//
//  LemmyV2APIConsumerTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/29/21.
//

import XCTest
@testable import Cavy

class LemmyV2SpecTests: XCTestCase {

    let client: LemmyV2Spec = .lemmyML
    
    func testLogin() throws {
        // Don't commit usernames and passwords to source control.
        // Instead, load them from (gitignore'd) secrets file.
        let secrets = Secrets.load()?["loginV2"] as? [String: String]
        let username = secrets?["username"]
        let password = secrets?["password"]
        try XCTSkipUnless(username != nil && password != nil, "username and password not found in secrets.json")
        
        let e = expectation(description: "Login")
        let spec = client.login(usernameOrEmail: username!, password: password!)
        assertDecodes(spec) {
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
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
    
    func testListPostsAuthed() throws {
        // Don't commit usernames and passwords to source control.
        // Instead, load them from (gitignore'd) secrets file.
        let secrets = Secrets.load()?["loginV2"] as? [String: String]
        let username = secrets?["username"]
        let password = secrets?["password"]
        try XCTSkipUnless(username != nil && password != nil, "username and password not found in secrets.json")
        
        let e = expectation(description: "list posts")
        let spec = client.login(usernameOrEmail: username!, password: password!)
        spec.load { (result) in
            switch result {
            case .success(let jwtWrapper):
                let authClient = LemmyV2Spec.lemmyML
                authClient.factory.token = jwtWrapper.jwt
                authClient.factory.username = username
                
                let spec = authClient.listPosts(type: .subscribed, sort: .hot)
                assertDecodes(spec) {
                    e.fulfill()
                }
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
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
