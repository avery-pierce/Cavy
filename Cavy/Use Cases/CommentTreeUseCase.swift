//
//  CommentTreeUseCase.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

class CommentTreeUseCase {
    let input: [CavyComment]
    
    private var tree: [Node<CavyComment>] = []
    private var cache: [Int: Node<CavyComment>] = [:]
    
    convenience init(_ input: [LemmyComment]) {
        let cavyComments = input.map(\.cavyComment)
        self.init(cavyComments)
    }
    
    init(_ input: [CavyComment]) {
        self.input = input
    }
    
    func buildTree() -> [Node<CavyComment>] {
        tree = []
        let unsortedNodes = input.map({ Node($0) })
        unsortedNodes.forEach { node in
            let id = node.value.id
            cache[id] = node
        }
        
        unsortedNodes.forEach { node in
            if let parentID = node.value.parentID, let parentNode = findNode(withCommentID: parentID) {
                parentNode.children.append(node)
            } else {
                tree.append(node)
            }
        }
        
        return tree
    }
    
    private func findNode(withCommentID commentID: Int) -> Node<CavyComment>? {
        return cache[commentID]
    }
}
