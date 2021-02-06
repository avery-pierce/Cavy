//
//  ThreadedComment.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/17/21.
//

import Foundation

class Node<T> {
    var value: T
    var children: [Node<T>]
    
    init(_ value: T, children: [Node<T>] = []) {
        self.value = value
        self.children = children
    }
}
