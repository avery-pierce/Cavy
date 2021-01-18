//
//  CommentTree.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

class CommentTree: ObservableObject {
    let nodes: [Node<LemmyComment>]
    
    @Published var comments: [ThreadedComment] = []
    
    init(_ nodes: [Node<LemmyComment>]) {
        self.nodes = nodes
        self.comments = flattenTree(nodes)
    }
    
    private func flattenTree(_ childNodes: [Node<LemmyComment>]) -> [ThreadedComment] {
        var flattened = [ThreadedComment]()
        
        for node in childNodes {
            let threadedComment = ThreadedComment(node.value)
            flattened.append(threadedComment)
            
            let children = flattenTree(node.children).map({ child -> ThreadedComment in
                var indentedChild = child
                indentedChild.indentationLevel += 1
                return indentedChild
            })
            flattened.append(contentsOf: children)
        }
        
        return flattened
    }
}
