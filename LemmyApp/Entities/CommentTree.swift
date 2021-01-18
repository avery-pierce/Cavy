//
//  CommentTree.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

class CommentTree: ObservableObject {
    let nodes: [Node<LemmyComment>]
    var hiddenCommentIDs = Set<Int>() {
        didSet { sync() }
    }
    
    @Published var comments: [ThreadedComment] = []
    
    init(_ nodes: [Node<LemmyComment>]) {
        self.nodes = nodes
        self.comments = flattenTree(nodes)
    }
    
    func hide(_ commentID: Int) {
        hiddenCommentIDs.insert(commentID)
        self.comments = flattenTree(nodes)
    }
    
    func show(_ commentID: Int) {
        hiddenCommentIDs.remove(commentID)
        self.comments = flattenTree(nodes)
    }
    
    func toggleHidden(_ commentID: Int) {
        if hiddenCommentIDs.contains(commentID) {
            show(commentID)
        } else {
            hide(commentID)
        }
    }
    
    private func sync() {
        comments = flattenTree(nodes)
    }
    
    private func flattenTree(_ childNodes: [Node<LemmyComment>]) -> [ThreadedComment] {
        var flattened = [ThreadedComment]()
        
        for node in childNodes {
            let threadedComment = createThreadedComment(from: node)
            flattened.append(threadedComment)
            
            // If the comment is not hidden, render its children
            guard !threadedComment.isHidden else { continue }
            
            // Render the children indented one level deeper
            let children = flattenTree(node.children).map({ child -> ThreadedComment in
                var indentedChild = child
                indentedChild.indentationLevel += 1
                return indentedChild
            })
            flattened.append(contentsOf: children)
        }
        
        return flattened
    }
    
    private func createThreadedComment(from node: Node<LemmyComment>) -> ThreadedComment {
        return ThreadedComment(node.value, isHidden: isCommentHidden(node))
    }
    
    private func isCommentHidden(_ node: Node<LemmyComment>) -> Bool {
        guard let id = node.value.id else { return false }
        return hiddenCommentIDs.contains(id)
    }
}
