//
//  LemmyV2APIConsumerTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/29/21.
//

import XCTest
@testable import Cavy

class LemmyV2SpecTests: XCTestCase {

    static let localhostSpec = LemmyV2Spec("localhost:8536", https: false)
    
    let client: LemmyV2Spec = LemmyV2SpecTests.localhostSpec
    let activeSession = ActiveSessionClient(LemmyAPIClient(LemmyV2SpecTests.localhostSpec))
    
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
        assertDecodes(spec, printData: true) {
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
        let spec = client.fetchPost(id: 1)
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
            let spec = client.vote(1, onPostID: 1)
            assertDecodes(spec, printData: true) {
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSubmitPost() throws {
        let e = expectation(description: "Create Post")
        activeSession.vend { (authClient) in
            guard let authClient = authClient, case .v2(let client) = authClient else { return XCTFail() }
            let spec = client.submitPost(name: "Automated test post \(Date().description)", url: "https://example.com", body: "This is a test post", nsfw: false, communityID: 2)
            assertDecodes(spec, printData: true) {
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSubmitComment() throws {
        let e = expectation(description: "Submit Comment")
        activeSession.vend { (authClient) in
            guard let authClient = authClient, case .v2(let client) = authClient else { return XCTFail() }
            let spec = client.submitComment(content: "Hello world! This is an automated comment \(Date().description)", postID: 1, parentID: nil)
            
            assertDecodes(spec, printData: true) {
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testVoteComment() throws {
        let e = expectation(description: "Vote Comment")
        activeSession.vend { (authClient) in
            guard let authClient = authClient, case .v2(let client) = authClient else { return XCTFail() }
            let spec = client.vote(1, onCommentID: 1)
            
            assertDecodes(spec, printData: true) {
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
