//
//  PostItem.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/8/20.
//

import Foundation

protocol PostItem {
    var id: String { get }
    var title: String { get }
    var imageURL: URL? { get }
    var score: Int { get }
    var authorName: String { get }
    var domain: String { get }
    var destination: PostDestination? { get }
}

struct ConcretePostItem: PostItem {
    var id: String
    var title: String
    var imageURL: URL?
    var score: Int
    var authorName: String
    var domain: String
    var destination: PostDestination?
}

let sampleDataList = [
    ConcretePostItem(id: "1", title: "Simulating Machines in Clojure", imageURL: URL(string: "https://dev.lemmy.ml/pictrs/image/thumbnail256/ZmPVJQGWHQ.png")!, score: 2, authorName: "@yogthos", domain: "stopa.io"),
    ConcretePostItem(id: "2", title: "Top 4 Coding Languages To Learn For Beginners (2020) - Qvault", imageURL: URL(string: "https://dev.lemmy.ml/pictrs/image/thumbnail256/imxHpk3Q7C.png"), score: 2, authorName: "@wagslane", domain: "qvault.io"),
    ConcretePostItem(id: "3", title: "The Open University Project", imageURL: URL(string: "https://dev.lemmy.ml/pictrs/image/thumbnail256/23vlPmgocf.png"), score: 1, authorName: "@avalos", domain: "monora.org"),
    ConcretePostItem(id: "4", title: "I made a playlist of 6h56min of chill synth music to lift you up and motivate you while coding/working. Enjoy!", imageURL: URL(string: "https://dev.lemmy.ml/pictrs/image/thumbnail256/wAqJ6oqwiz.jpg")!, score: 1, authorName: "@unknownguyfromnowher", domain: "open.spotify.com"),
    ConcretePostItem(id: "5", title: "Why Life Can’t Be Simpler", imageURL: URL(string: "https://dev.lemmy.ml/pictrs/image/thumbnail256/LVnmAliBZg.png"), score: 2, authorName: "@yogthos", domain: "fs.blog"),
]

let sampleData = sampleDataList[3]
