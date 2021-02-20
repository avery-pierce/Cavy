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
    let activeSession = ActiveSessionClient(.lemmyML)
    
    func testLogin() throws {
        let credentials = activeSession.getCredentials()
        try XCTSkipUnless(credentials != nil, "username and password not found in secrets.json")
        
        let (username, password) = credentials!
        let e = expectation(description: "Login")
        let spec = client.login(usernameOrEmail: username, password: password)
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
        
        let e = expectation(description: "list posts")
        activeSession.vend { (authClient) in
            guard let authClient = authClient, case .v2(let client) = authClient else { return XCTFail() }
            let spec = client.listPosts(type: .subscribed, sort: .hot)
            assertDecodes(spec) {
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 50, handler: nil)
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
    
    func testVote() throws {
        let e = expectation(description: "Vote")
        activeSession.vend { (authClient) in
            guard let authClient = authClient, case .v2(let client) = authClient else { return XCTFail() }
            let spec = client.vote(1, onPostID: 41167)
            assertDecodes(spec, printData: true) {
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
