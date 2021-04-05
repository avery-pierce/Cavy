//
//  LemmyV1SpecTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/29/21.
//

import XCTest
@testable import Cavy

class LemmyV1SpecTests: LemmySpecTestCase {
    
    let client: LemmyV1Spec = LemmyV1Spec("www.chapo.chat")
    let activeSession = ActiveSessionClient(LemmyAPIClient(LemmyV1Spec("www.chapo.chat")))
    
    func testLogin() throws {
        let credentials = v1ActiveSession.getCredentials()
        try XCTSkipUnless(credentials != nil, "username and password not found in secrets.json")
        
        let (username, password) = credentials!
        expectWithAnonV1Client("Login") { client, onComplete in
            let spec = client.login(usernameOrEmail: username, password: password)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testListCommunities() throws {
        expectWithAnonV1Client("List Communities") { client, onComplete in
            let spec = client.listCommunities(sort: .hot)
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
    
    func testListPosts() throws {
        expectWithAnonV1Client("List Posts") { client, onComplete in
            let spec = client.listPosts(type: .all, sort: .hot)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testListPostsAuthed() throws {
        expectWithAuthedV1Client("List Authed Posts") { client, onComplete in
            let spec = client.listPosts(type: .subscribed, sort: .hot)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testListPostsByCommunity() throws {
        expectWithAnonV1Client("List Posts") { client, onComplete in
            let spec = client.listPosts(type: .all, sort: .hot, communityID: 1)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testListComments() throws {
        expectWithAnonV1Client("Get Post") { client, onComplete in
            let spec = client.fetchPost(id: 1)
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testGetSiteData() throws {
        expectWithAnonV1Client("Fetch Site") { client, onComplete in
            let spec = client.fetchSite()
            assertDecodes(spec) {
                onComplete(nil)
            }
        }
    }
    
    func testVote() throws {
        expectWithAuthedV1Client("Vote") { client, onComplete in
            let spec = client.vote(1, onPostID: 1)
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
}
