//
//  LemmyPostItem++.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import Foundation

extension LemmyPostItem {
    var kind: PostKind {
        guard let url = url else { return .text }
        if isImageURL(url) {
            return .image
        } else {
            return .web
        }
    }
}
