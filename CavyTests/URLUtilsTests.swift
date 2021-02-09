//
//  URLUtilsTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/21/21.
//

import XCTest
@testable import Cavy

class URLUtilsTests: XCTestCase {

    let jpgURL = URL(string: "https://www.example.com/pictrs/image/C7GKSrWhFM.jpg")!
    let jpegURL = URL(string: "https://www.example.com/pictrs/image/C7GKSrWhFM.jpeg")!
    let pngURL = URL(string: "https://www.example.com/pictrs/image/C7GKSrWhFM.png")!
    let webpURL = URL(string: "https://www.example.com/pictrs/image/C7GKSrWhFM.webp")!
    
    let htmlURL = URL(string: "https://www.example.com/test.html")!
    let nilURL = URL(string: "https://www.example.com/about")!
    
    func testValidImages() throws {
        XCTAssertTrue(isImageURL(jpgURL))
        XCTAssertTrue(isImageURL(jpegURL))
        XCTAssertTrue(isImageURL(pngURL))
        XCTAssertTrue(isImageURL(webpURL))
    }
    
    func testNonImages() throws {
        XCTAssertFalse(isImageURL(htmlURL))
        XCTAssertFalse(isImageURL(nilURL))
    }
}
