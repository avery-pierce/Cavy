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
    
    static func success(_ value: T) -> LoadState<T, E> {
        return .complete(.success(value))
    }
    
    static func failure(_ error: E) -> LoadState<T, E> {
        return .complete(.failure(error))
    }
    
    var isIdle: Bool {
        switch self {
        case .idle: return true
        default: return false
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
    
    var isComplete: Bool {
        switch self {
        case .complete: return true
        default: return false
        }
    }
    
    var result: Result<T, E>? {
        switch self {
        case .complete(let result): return result
        default: return nil
        }
    }
    
    var value: T? {
        return try? result?.get()
    }
    
    func map<NewSuccess>(_ closure: (T) -> NewSuccess) -> LoadState<NewSuccess, E> {
        switch self {
        case .idle:
            return .idle
            
        case .loading(let pct):
            return .loading(pct)
            
        case .complete(let result):
            return .complete(result.map(closure))
        }
    }
}

extension LoadState: Equatable where E: Equatable, T: Equatable {}
