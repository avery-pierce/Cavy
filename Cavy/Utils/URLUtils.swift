//
//  URLUtils.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import Foundation

func isImageURL(_ url: URL) -> Bool {
    let knownImageExtensions = Set([
        "jpg",
        "jpeg",
        "png",
        "webp",
    ])
    
    return knownImageExtensions.contains(url.pathExtension)
}
