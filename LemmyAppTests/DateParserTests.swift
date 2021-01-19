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
        XCTAssertEqual(date!.timeIntervalSince1970, 1611013346.673)
    }
    
    func testAbbreviatedForm() throws {
        XCTAssertEqual(abbreviatedForm(of: seconds(0)), "now")
        
        XCTAssertEqual(abbreviatedForm(of: seconds(35)), "35s")
        XCTAssertEqual(abbreviatedForm(of: seconds(44.2)), "44s")
        XCTAssertEqual(abbreviatedForm(of: seconds(44.5)), "45s")
        
        XCTAssertEqual(abbreviatedForm(of: minutes(22.0)), "22m")
        XCTAssertEqual(abbreviatedForm(of: minutes(38.4)), "38m")
        XCTAssertEqual(abbreviatedForm(of: minutes(38.8)), "39m")
        
        XCTAssertEqual(abbreviatedForm(of: hours(10)), "10h")
        XCTAssertEqual(abbreviatedForm(of: hours(4.3)), "4h")
        XCTAssertEqual(abbreviatedForm(of: hours(4.6)), "5h")
        
        XCTAssertEqual(abbreviatedForm(of: days(13)), "13d")
        XCTAssertEqual(abbreviatedForm(of: days(21.1)), "21d")
        XCTAssertEqual(abbreviatedForm(of: days(21.9)), "22d")
        
    }
    
    func seconds(_ seconds: Double) -> TimeInterval {
        return TimeInterval(seconds)
    }
    
    func minutes(_ minutes: Double) -> TimeInterval {
        return seconds(60.0 * minutes)
    }
    
    func hours(_ hours: Double) -> TimeInterval {
        return minutes(60.0 * hours)
    }
    
    func days(_ days: Double) -> TimeInterval {
        return hours(24.0 * days)
    }

}
