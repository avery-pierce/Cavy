//
//  LemmyV2APIConsumerTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/29/21.
//

import XCTest
@testable import Cavy

class LemmyV2SpecTests: LemmySpecTestCase {

    func testLogin() throws {
        let credentials = v2ActiveSession.getCredentials()
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
        expectWithAuthedV2Client("Submit Comment") { (client, onComplete) in
            let spec = client.submitComment(content: "Hello world! This is an automated comment \(Date().description)",
                                            postID: 1,
                                            parentID: nil)
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
}
