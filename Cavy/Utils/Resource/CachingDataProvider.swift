//
//  CachingDataProvider.swift
//  Cavy
//
//  Created by Avery Pierce on 2/7/21.
//

import Foundation

protocol Cachable {
    var filename: String { get }
}

struct CachingDataProvider<CachableDataProvider: DataProvider & Cachable>: DataProvider {
    let dataProvider: CachableDataProvider
    init(_ dataProvider: CachableDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func getData(_ completion: @escaping (Result<Data, Error>) -> Void) {
        if isCached {
            getDataFromCache(completion)
        } else {
            dataProvider.getData { (result) in
                if let downloadedData = try? result.get() {
                    writeToCache(data: downloadedData)
                }
                
                completion(result)
            }
        }
    }
    
    func getDataFromCache(_ completion: @escaping (Result<Data, Error>) -> Void) {
        guard let data = FileManager.default.contents(atPath: cachePath) else {
            completion(.failure(PlainError("File didn't exist at \(cachePath)")))
            return
        }
        
        completion(.success(data))
    }
    
    func writeToCache(data: Data) {
        createFolderIfNeeded()
        FileManager.default.createFile(atPath: cachePath, contents: data, attributes: nil)
    }
    
    var isCached: Bool {
        return FileManager.default.fileExists(atPath: cachePath)
    }
    
    var cachePath: String {
        cachingDataProviderFolderURL.appendingPathComponent(dataProvider.filename).path
    }
    
    var cachingDataProviderFolderURL: URL { Self.cachingDataProviderFolderURL }
    
    static var cachingDataProviderFolderURL: URL {
        let cachePaths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        guard cachePaths.count > 0 else { fatalError("Could not find the cache path!") }
        return cachePaths[0].appendingPathComponent("CachingDataProvider")
    }
    
    func createFolderIfNeeded() { Self.createFolderIfNeeded() }
    
    static func createFolderIfNeeded() {
        try? FileManager.default.createDirectory(at: cachingDataProviderFolderURL, withIntermediateDirectories: true, attributes: nil)
    }
}

extension URL: Cachable {
    var filename: String {
        return "\(hashValue).data"
    }
}
