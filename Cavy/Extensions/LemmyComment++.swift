//
//  LemmyComment++.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/18/21.
//

import Foundation

extension LemmyComment {
    var publishedDate: Date? {
        published.flatMap(parseLemmyDate(_:))
    }
    
    var creatorPublishedDate: Date? {
        creatorPublished.flatMap(parseLemmyDate(_:))
    }
}
