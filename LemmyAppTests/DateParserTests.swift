//
//  DateParserTests.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 1/18/21.
//

import XCTest
@testable import LemmyApp

class DateParserTests: XCTestCase {

    func testParseDate() throws {
        let date = parseLemmyDate("2021-01-18T23:42:26.673844")
        XCTAssertEqual(date!.timeIntervalSince1970, 1611034946.673)
    }

}
