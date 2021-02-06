//
//  CommentTree.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/18/21.
//

import XCTest
@testable import Cavy

class CommentTreeTests: XCTestCase {
    
    var mockComments: [LemmyComment] = []
    var mockPost: LemmyPostResponse!
    
    override func setUpWithError() throws {
        mockPost = try! LemmyPostResponse.fromJSON(fileNamed: "20210118_lemmy_post_41391", withExtension: "json", in: testBundle)
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
    
    func testCommentTreeHiddenComments() throws {
        let useCase = CommentTreeUseCase(mockPost!.comments)
        let tree = useCase.buildTree()
        let commentTree = CommentTree(tree)
        commentTree.hide(18934)
        
        let result1 = render(flattenedTree: commentTree.comments)
        XCTAssertEqual(result1, "18934(X), 18930(0), 18932(1)")
        
        commentTree.show(18934)
        commentTree.hide(18930)
        let result2 = render(flattenedTree: commentTree.comments)
        XCTAssertEqual(result2, "18934(0), 18943(1), 18945(2), 18948(3), 18956(4), 18930(X)")
        
        commentTree.show(18930)
        commentTree.hide(18948)
        let result3 = render(flattenedTree: commentTree.comments)
        XCTAssertEqual(result3, "18934(0), 18943(1), 18945(2), 18948(X), 18930(0), 18932(1)")
    }
    
    func testCommentToggleHidden() throws {
        let useCase = CommentTreeUseCase(mockPost!.comments)
        let tree = useCase.buildTree()
        let commentTree = CommentTree(tree)
        commentTree.toggleHidden(18934)
        
        let result1 = render(flattenedTree: commentTree.comments)
        XCTAssertEqual(result1, "18934(X), 18930(0), 18932(1)")
        
        commentTree.toggleHidden(18934)
        commentTree.toggleHidden(18930)
        let result2 = render(flattenedTree: commentTree.comments)
        XCTAssertEqual(result2, "18934(0), 18943(1), 18945(2), 18948(3), 18956(4), 18930(X)")
    }
    
    private func render(tree: [Node<CavyComment>]) -> String {
        tree.map { (node) -> String in
            if node.children.isEmpty {
                return "\(node.value.id)"
            } else {
                return "\(node.value.id)>(\(render(tree: node.children)))"
            }
        }.joined(separator: ", ")
    }
    
    private func render(flattenedTree: [ThreadedComment]) -> String {
        flattenedTree.map { (comment) -> String in
            if comment.isHidden {
                return "\(comment.comment.id)(X)"
            } else {
                return "\(comment.comment.id)(\(comment.indentationLevel))"
            }
        }.joined(separator: ", ")
    }
}
