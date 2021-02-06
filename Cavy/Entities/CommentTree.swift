//
//  CommentTree.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

class CommentTree: ObservableObject {
    let nodes: [Node<CavyComment>]
    var hiddenCommentIDs = Set<Int>() {
        didSet { sync() }
    }
    
    @Published var comments: [ThreadedComment] = []
    
    init(_ nodes: [Node<CavyComment>]) {
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
    
    func toggleHidden(_ commentID: Int?) {
        guard let commentID = commentID else { return }
        if hiddenCommentIDs.contains(commentID) {
            show(commentID)
        } else {
            hide(commentID)
        }
    }
    
    private func sync() {
        comments = flattenTree(nodes)
    }
    
    private func flattenTree(_ childNodes: [Node<CavyComment>]) -> [ThreadedComment] {
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
    
    private func createThreadedComment(from node: Node<CavyComment>) -> ThreadedComment {
        return ThreadedComment(node.value, isHidden: isCommentHidden(node))
    }
    
    private func isCommentHidden(_ node: Node<CavyComment>) -> Bool {
        return hiddenCommentIDs.contains(node.value.id)
    }
}
