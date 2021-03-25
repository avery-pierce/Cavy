//
//  Assert.swift
//  LemmyAppTests
//
//  Created by Avery Pierce on 10/14/20.
//

import XCTest
@testable import Cavy

func assertDecodes<D: DataProvider, T: Codable>(_ dataPackage: Spec<D, T>, printData: Bool = false, file: StaticString = #filePath, line: UInt = #line, completion: @escaping () -> Void) {
    assertDecodes(to: dataPackage.type, fromDataProvidedBy: dataPackage.dataProvider, printData: printData, completion: completion)
}

func assertDecodes<T: Decodable>(to Type: T.Type, fromDataProvidedBy dataProvider: DataProvider, printData: Bool = false, file: StaticString = #filePath, line: UInt = #line, completion: @escaping () -> Void) {
    dataProvider.getData { (result) in
        let data = assertSuccess(result, file: file, line: line)
        if let data = data, !data.isEmpty, printData {
            print(try! prettyJSON(data))
        }
        assertDecodes(to: Type, from: data, file: file, line: line)
        completion()
    }
}

func assertDecodes<T: Decodable>(to Type: T.Type, from data: Data?, file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertNotNil(data, "data was nil", file: file, line: line)
    XCTAssertFalse(data!.isEmpty, "data was empty", file: file, line: line)
    
    do {
        let _ = try JSONDecoder().decode(Type.self, from: data!)
    } catch let error {
        print(error)
        print(try! prettyJSON(data!))
        XCTFail(error.localizedDescription, file: file, line: line)
    }
}

func prettyJSON(_ data: Data) throws -> String {
    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
    let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
    return String(data: prettyData, encoding: .utf8)!
}

@discardableResult func assertSuccess<T, E: Error>(_ result: Result<T, E>, file: StaticString = #filePath, line: UInt = #line) -> T! {
    switch result {
    case .success(let value): return value
    case .failure(let error):
        XCTFail(error.localizedDescription, file: file, line: line)
        return nil
    }
}
