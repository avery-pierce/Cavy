//
//  CommentTree.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/18/21.
//

import XCTest
@testable import LemmyApp

class CommentTreeTests: XCTestCase {
    
    var mockComments: [LemmyComment] = []
    var mockPost: LemmyPostResponse!
    let testBundle = Bundle(for: CommentTreeTests.self)
    
    override func setUpWithError() throws {
        mockPost = LemmyPostResponse.fromJSON(fileNamed: "20210118_lemmy_post_41391", withExtension: "json", in: testBundle)
    }

    func testCommentTreeUseCase() throws {
        let useCase = CommentTreeUseCase(mockPost!.comments)
        let tree = useCase.buildTree()
        let result = render(tree: tree)
        XCTAssertEqual(result, "18934>(18943>(18945>(18948>(18956)))), 18930>(18932)")
    }

    func testCommentTreeFlattener() throws {
        let useCase = CommentTreeUseCase(mockPost!.comments)
        let tree = useCase.buildTree()
        let commentTree = CommentTree(tree)
        let result = render(flattenedTree: commentTree.comments)
        XCTAssertEqual(result, "18934(0), 18943(1), 18945(2), 18948(3), 18956(4), 18930(0), 18932(1)")
    }
    
    private func render(tree: [Node<LemmyComment>]) -> String {
        tree.map { (node) -> String in
            if node.children.isEmpty {
                return "\(node.value.id!)"
            } else {
                return "\(node.value.id!)>(\(render(tree: node.children)))"
            }
        }.joined(separator: ", ")
    }
    
    private func render(flattenedTree: [ThreadedComment]) -> String {
        flattenedTree.map { (comment) -> String in
            return "\(comment.comment.id!)(\(comment.indentationLevel))"
        }.joined(separator: ", ")
    }
}
