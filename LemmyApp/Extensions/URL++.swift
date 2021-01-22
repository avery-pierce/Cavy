//
//  URL++.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import Foundation

extension URL {
    var kind: LinkKind {
        if isImageURL(self) {
            return .image
        } else {
            return .web
        }
    }
}
