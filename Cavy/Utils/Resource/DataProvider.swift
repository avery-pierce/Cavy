//
//  DataProvider.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/14/20.
//

import Foundation

/// Describes a type that can asynchronously provide data, either via the network, or some other means.
protocol DataProvider {
    /// Fetches the data associated with this provider. The callback handler
    /// is not guaranteed to be called on the main thread.
    func getData(_ completion: @escaping (Result<Data, Error>) -> Void)
}

extension Data: DataProvider {
    func getData(_ completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(self))
    }
}

struct BundleResource: DataProvider {
    let bundle: Bundle
    let name: String
    let `extension`: String
    
    init(_ bundle: Bundle = .main, name: String, extension: String) {
        self.bundle = bundle
        self.name = name
        self.extension = `extension`
    }
    
    func getData(_ completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            guard let url = bundle.url(forResource: name, withExtension: self.extension) else {
                throw PlainError("No such file in bundle: \(name).\(self.extension)")
            }
            let data = try Data(contentsOf: url)
            completion(.success(data))
            
        } catch let error {
            completion(.failure(error))
        }
    }
}

extension Bundle {
    func json(named name: String) -> BundleResource {
        return BundleResource(self, name: name, extension: "json")
    }
    
    func resource(_ name: String, withExtension extension: String) -> BundleResource {
        return BundleResource(self, name: name, extension: `extension`)
    }
}

struct URLRequestResource: DataProvider {
    let session: URLSession
    let request: URLRequest
    init(session: URLSession = .shared, _ request: URLRequest) {
        self.session = session
        self.request = request
    }
    
    func getData(_ completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                return completion(.success(data))
            }
            
            if let error = error {
                return completion(.failure(error))
            }
            
            return completion(.failure(PlainError("Request returned empty data: \(request)")))
        }.resume()
    }
}

extension URLRequest: DataProvider {
    func getData(_ completion: @escaping (Result<Data, Error>) -> Void) {
        URLRequestResource(self).getData(completion)
    }
}

extension URL: DataProvider {
    func getData(_ completion: @escaping (Result<Data, Error>) -> Void) {
        let urlRequest = URLRequest(url: self)
        URLRequestResource(urlRequest).getData(completion)
    }
}
