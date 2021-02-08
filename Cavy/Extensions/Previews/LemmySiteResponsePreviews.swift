//
//  LemmySiteResponsePreviews.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/23/21.
//

import Foundation

extension LemmySiteResponse {
    static let sampleData: LemmySiteResponse = try! LemmySiteResponse.fromJSON(fileNamed: "20210122_lemmy_ml_site", withExtension: "json")
}
