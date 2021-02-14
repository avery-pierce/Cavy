//
//  Classy.swift
//  Cavy
//
//  Created by Avery Pierce on 2/14/21.
//

import Foundation

class Classy<T>: Identifiable {
    var value: T
    init(_ value: T) {
        self.value = value
    }
}
