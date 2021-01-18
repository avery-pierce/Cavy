//
//  CommentTreeUseCase.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

class CommentTreeUseCase {
    let input: [LemmyComment]
    
    private var tree: [Node<LemmyComment>] = []
    private var cache: [Int: Node<LemmyComment>] = [:]
    
    init(_ input: [LemmyComment]) {
        self.input = input
    }
    
    func buildTree() -> [Node<LemmyComment>] {
        let unsortedNodes = input.map({ Node($0) })
        unsortedNodes.forEach { node in
            guard let id = node.value.id else { return }
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
    
    private func findNode(withCommentID commentID: Int) -> Node<LemmyComment>? {
        return cache[commentID]
    }
}
