//
//  PlainError.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/14/20.
//

import Foundation

struct PlainError: Error, LocalizedError {
    let message: String
    init(_ message: String) {
        self.message = message
    }
    
    var errorDescription: String? {
        return message
    }
}
