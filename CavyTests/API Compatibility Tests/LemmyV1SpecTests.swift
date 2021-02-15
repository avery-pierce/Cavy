//
//  LemmyV1SpecTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/29/21.
//

import XCTest
@testable import Cavy

class LemmyV1SpecTests: XCTestCase {
    
    let client: LemmyV1Spec = LemmyV1Spec("www.chapo.chat")
    
    func testLogin() throws {
        // Don't commit usernames and passwords to source control.
        // Instead, load them from (gitignore'd) secrets file.
        let secrets = Secrets.load()?["loginV1"] as? [String: String]
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
        let spec = client.fetchPost(id: 79027)
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
