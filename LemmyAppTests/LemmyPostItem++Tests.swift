//
//  LemmyPostItem++Tests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/21/21.
//

import XCTest
@testable import LemmyApp

class LemmyPostItem__Tests: XCTestCase {
    
    let allPosts = LemmyPostItemResponse.fromJSON(fileNamed: "20210118_post_list_all_hot", withExtension: "json", in: testBundle)
    var webArticlePost: LemmyPostItem {
        allPosts.posts[0]
    }
    var imagePost: LemmyPostItem {
        allPosts.posts[1]
    }
    var selfPost: LemmyPostItem {
        allPosts.posts[3]
    }

    func testWebArticle() throws {
        XCTAssertEqual(webArticlePost.kind, .web)
    }
    
    func testImagePost() throws {
        XCTAssertEqual(imagePost.kind, .image)
    }
    
    func testSelfPost() throws {
        XCTAssertEqual(selfPost.kind, nil)
    }
}
