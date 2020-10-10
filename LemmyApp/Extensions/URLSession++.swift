//
//  URLSession++.swift
//  LemmyApp
//
//  Created by Avery Pierce on 10/9/20.
//

import Foundation

extension URLSession {
    func decodedDataTask<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, Error>, URLResponse?) -> Void) -> URLSessionDataTask {
        return dataTask(with: request) { (data, response, error) in
            func failure(_ error: Error) {
                completion(.failure(error), response)
            }
            
            func success(_ value: T) {
                completion(.success(value), response)
            }
            
            if let error = error {
                return failure(error)
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data!)
                return success(decoded)
            } catch let error {
                return failure(error)
            }
        }
    }
}
