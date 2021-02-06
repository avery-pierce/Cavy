//
//  Resource.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import Foundation

protocol Resource {
    associatedtype T
    associatedtype E: Error
    
    var state: LoadState<T, E> { get }
    func load()
}
