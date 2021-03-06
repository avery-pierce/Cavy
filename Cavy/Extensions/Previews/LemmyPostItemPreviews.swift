//
//  LemmyPostItemPreviews.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation
extension LemmyPostItem {
    
    static let sampleDataList = [
        try! LemmyPostItem.fromJSON("""
        {
            "id": 1,
            "name": "Simulating Machines in Clojure",
            "thumbnail_url": "https://dev.lemmy.ml/pictrs/image/thumbnail256/ZmPVJQGWHQ.png",
            "score": 2,
            "creatorName": "yogthos",
            "url": "https://www.example.com"
        }
        """),
        try! LemmyPostItem.fromJSON("""
        {
            "id": 2,
            "name": "Top 4 Coding Languages To Learn For Beginners (2020) - Qvault",
            "thumbnail_url": "https://dev.lemmy.ml/pictrs/image/thumbnail256/imxHpk3Q7C.png",
            "score": 2,
            "creatorName": "wagslane",
            "url": "https://www.example.com"
        }
        """),
        try! LemmyPostItem.fromJSON("""
        {
            "id": 3,
            "name": "The Open University Project",
            "thumbnail_url": "https://dev.lemmy.ml/pictrs/image/thumbnail256/23vlPmgocf.png",
            "score": 1,
            "creatorName": "avalos",
            "url": "https://www.example.com"
        }
        """),
        try! LemmyPostItem.fromJSON("""
        {
            "id": 4,
            "name": "I made a playlist of 6h56min of chill synth music to lift you up and motivate you while coding/working. Enjoy!",
            "thumbnail_url": "https://dev.lemmy.ml/pictrs/image/thumbnail256/wAqJ6oqwiz.jpg",
            "score": 1,
            "creatorName": "unknownguyfromnowher",
            "url": "https://www.example.com"
        }
        """),
        try! LemmyPostItem.fromJSON("""
        {
            "id": 4,
            "name": "Why Life Can’t Be Simpler",
            "thumbnail_url": "https://dev.lemmy.ml/pictrs/image/thumbnail256/LVnmAliBZg.png",
            "score": 2,
            "creatorName": "yogthos",
            "url": "https://www.example.com"
        }
        """),
    ]
    
    static let sampleData = sampleDataList[3]
}
