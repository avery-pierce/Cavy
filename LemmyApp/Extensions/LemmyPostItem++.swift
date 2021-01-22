//
//  LemmyPostItem++.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/21/21.
//

import Foundation

extension LemmyPostItem {
    var kind: LinkKind? {
        url?.kind
    }
}
