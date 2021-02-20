//
//  CombineUtils.swift
//  Cavy
//
//  Created by Avery Pierce on 2/20/21.
//

import Foundation
import Combine


/// Combines the latest value from each of the publishers in an array of publishers of the same time.
/// - Parameter publishers: Array of publishers whose output will be returned in a single array
/// - Returns: a publisher with an array of outputs
func combineLatestAll<P: Publisher>(_ publishers: [P]) -> AnyPublisher<[P.Output], P.Failure> {
    let initialResult = Just([] as [P.Output])
        .setFailureType(to: P.Failure.self)
        .eraseToAnyPublisher()
    
    let merged = publishers.reduce(initialResult) { (prevResult, nextPublisher) in
        Publishers.CombineLatest(prevResult, nextPublisher).map { (array, single) -> [P.Output] in
            return array + [single]
        }.eraseToAnyPublisher()
    }
    
    return merged.eraseToAnyPublisher()
}
