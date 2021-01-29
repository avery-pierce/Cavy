//
//  Assert.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 10/14/20.
//

import XCTest

func assertDecodes<T: Decodable>(to Type: T.Type, fromDataProvidedBy dataProvider: DataProvider, file: StaticString = #filePath, line: UInt = #line, completion: @escaping () -> Void) {
    dataProvider.getData { (result) in
        let data = assertSuccess(result, file: file, line: line)
        assertDecodes(to: Type, from: data, file: file, line: line)
        completion()
    }
}

func assertDecodes<T: Decodable>(to Type: T.Type, from data: Data?, file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertNotNil(data, "data was nil", file: file, line: line)
    
    do {
        let _ = try JSONDecoder().decode(Type.self, from: data!)
    } catch let error {
        print(error)
        XCTFail(error.localizedDescription, file: file, line: line)
    }
}


@discardableResult func assertSuccess<T, E: Error>(_ result: Result<T, E>, file: StaticString = #filePath, line: UInt = #line) -> T! {
    switch result {
    case .success(let value): return value
    case .failure(let error):
        XCTFail(error.localizedDescription, file: file, line: line)
        return nil
    }
}
