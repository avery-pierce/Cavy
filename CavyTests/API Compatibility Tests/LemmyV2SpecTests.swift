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
        expectWithAnonV2Client("Login") { client, onComplete in
            let spec = client.login(usernameOrEmail: username, password: password)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testListCommunities() throws {
        expectWithAnonV2Client("List Communities") { client, onComplete in
            let spec = client.listCommunities(sort: .hot)
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
    
    func testListPosts() throws {
        expectWithAnonV2Client("List Posts") { client, onComplete in
            let spec = client.listPosts(type: .all, sort: .hot)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testListPostsAuthed() throws {
        expectWithAuthedV2Client("List Authed Posts") { client, onComplete in
            let spec = client.listPosts(type: .subscribed, sort: .hot)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testListPostsByCommunity() throws {
        expectWithAnonV2Client("List Posts") { client, onComplete in
            let spec = client.listPosts(type: .all, sort: .hot, communityID: 1)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }

    func testListComments() throws {
        /*
         Some good examples:
         Post ID: 41391
         post ID: 41326
         */
        expectWithAnonV2Client("Get Post") { client, onComplete in
            let spec = client.fetchPost(id: 1)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }

    func testGetSiteData() throws {
        expectWithAnonV2Client("Fetch Site") { client, onComplete in
            let spec = client.fetchSite()
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testVote() throws {
        expectWithAuthedV2Client("Vote") { client, onComplete in
            let spec = client.vote(1, onPostID: 1)
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
    
    func testSubmitPost() throws {
        expectWithAuthedV2Client("Create Post") { client, onComplete in
            let spec = client.submitPost(name: "Automated test post \(Date().description)", url: "https://example.com", body: "This is a test post", nsfw: false, communityID: 2)
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
    
    func testSubmitComment() throws {
        expectWithAuthedV2Client("Submit Comment") { (client, onComplete) in
            let spec = client.submitComment(content: "Hello world! This is an automated comment \(Date().description)", postID: 1, parentID: nil)
            
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
    
    func testVoteComment() throws {
        expectWithAuthedV2Client("Vote Comment") { (client, onComplete) in
            let spec = client.vote(1, onCommentID: 1)
            
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
    
    func withAuthedV2Client(_ block: @escaping (LemmyV2Spec) -> Void) {
        activeSession.vend { (authClient) in
            guard let authClient = authClient, case .v2(let client) = authClient else { return XCTFail() }
            block(client)
        }
    }
    
    func expect(_ name: String, timeout: TimeInterval = 10, _ block: @escaping (_ completion: @escaping (Error?) -> Void) -> Void) {
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
    
    func expectWithAuthedV2Client(_ name: String, timeout: TimeInterval = 10, _ block: @escaping (LemmyV2Spec, @escaping (Error?) -> Void) -> Void) {
        expect(name, timeout: timeout) { onComplete in
            self.withAuthedV2Client { client in
                block(client, onComplete)
            }
        }
    }
    
    func expectWithAnonV2Client(_ name: String, timeout: TimeInterval = 10, _ block: @escaping (LemmyV2Spec, @escaping (Error?) -> Void) -> Void) {
        expect(name, timeout: timeout) { onComplete in
            block(self.client, onComplete)
        }
    }
}
