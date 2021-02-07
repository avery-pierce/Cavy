//
//  CachingDataProviderTests.swift
//  CavyTests
//
//  Created by Avery Pierce on 2/7/21.
//

import XCTest
@testable import Cavy

class CachingDataProviderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try? deleteCacheDirectory()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try? deleteCacheDirectory()
    }

    func testDataIsWrittenToCache() throws {
        let filename = "testDataIsWrittenToCache.data"
        let contents = "Hello World!".data(using: .utf8)!
        
        let e = expectation(description: "Cachable")
        
        let testDataProvider = TestCachableDataProvider(contents, filename: filename)
        let cachingDataProvider = CachingDataProvider(testDataProvider)
        cachingDataProvider.getData { (result) in
            
            // Writing to the cache is done asynchronously.
            // Let's wait for 1 second to give it a chance.
            sleep(1)
            
            do {
                let paths = try self.filesInCacheDirectory()
                XCTAssertEqual(paths, [filename])
            } catch let error {
                XCTFail(error.localizedDescription)
            }
            
            let cachedData = FileManager.default.contents(atPath: self.cacheFolderURL.appendingPathComponent(filename).path)
            XCTAssertEqual(cachedData, contents)
            
            e.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testDataIsReadFromCache() throws {
        let filename = "testDataIsReadFromCache.data"
        let contentsCached = "This data was cached".data(using: .utf8)!
        let contentsLoaded = "This data was loaded".data(using: .utf8)!
        
        let e = expectation(description: "Cachable")
        
        // Call this first to make sure the data is cached
        CachingDataProvider(TestCachableDataProvider(contentsCached, filename: filename)).getData { _ in
            CachingDataProvider(TestCachableDataProvider(contentsLoaded, filename: filename)).getData { result in
                let resultData = try? result.get()
                XCTAssertEqual(resultData, contentsCached)
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    var cacheFolderURL: URL {
        CachingDataProvider<TestCachableDataProvider>.cachingDataProviderFolderURL
    }
    
    func filesInCacheDirectory() throws -> [String] {
        try FileManager.default.contentsOfDirectory(atPath: cacheFolderURL.path)
    }
    
    func deleteCacheDirectory() throws {
        let allFiles = try filesInCacheDirectory()
        for file in allFiles {
            try FileManager.default.removeItem(at: cacheFolderURL.appendingPathComponent(file))
        }
        
        try FileManager.default.removeItem(at: cacheFolderURL)
    }
    
    struct TestCachableDataProvider: Cachable, Cavy.DataProvider {
        let result: Result<Data, Error>
        let filename: String
        
        init(_ result: Result<Data, Error>, filename: String) {
            self.result = result
            self.filename = filename
        }
        
        init(_ data: Data, filename: String) {
            self.init(.success(data), filename: filename)
        }
        
        init(_ string: String, filename: String) {
            self.init(string.data(using: .utf8)!, filename: filename)
        }
        
        func getData(_ completion: @escaping (Result<Data, Error>) -> Void) {
            completion(result)
        }
    }
}
