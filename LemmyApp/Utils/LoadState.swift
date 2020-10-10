//
//  LoadState.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/10/20.
//

import Foundation

enum LoadState<T, E: Error> {
    case idle
    case loading(_ percentage: Double? = nil)
    case complete(Result<T, E>)
}
