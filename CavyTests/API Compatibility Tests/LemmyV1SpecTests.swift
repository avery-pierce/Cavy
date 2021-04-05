//
//  LemmyV1SpecTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/29/21.
//

import XCTest
@testable import Cavy

class LemmyV1SpecTests: LemmySpecTestCase {
    
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
    
    func testSubmitPost() throws {
        expectWithAuthedV1Client("Create Post") { client, onComplete in
            let spec = client.submitPost(name: "Automated test post \(Date().description)",
                                         url: "https://example.com",
                                         body: "This is a test post",
                                         nsfw: false,
                                         communityID: 2)
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
    
    func testSubmitComment() throws {
        expectWithAuthedV1Client("Submit Comment") { (client, onComplete) in
            let spec = client.submitComment(content: "Hello world! This is an automated comment \(Date().description)",
                                            postID: 1,
                                            parentID: nil)
            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }

    func testVoteComment() throws {
        expectWithAuthedV1Client("Vote Comment") { (client, onComplete) in
            let spec = client.vote(1, onCommentID: 1)

            assertDecodes(spec, printData: true) {
                onComplete(nil)
            }
        }
    }
}
