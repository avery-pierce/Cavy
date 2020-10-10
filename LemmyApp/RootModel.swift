//
//  RootModel.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation

class RootModel: ObservableObject {
    @Published var clients = [
        LemmyAPIClient.devLemmyMl,
        LemmyAPIClient.lemmygradML
    ]
}
