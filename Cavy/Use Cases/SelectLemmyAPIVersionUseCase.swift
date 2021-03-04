//
//  SelectLemmyAPIVersionUseCase.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

class SelectLemmyAPIVersionUseCase {
    let host: String
    let https: Bool
    
    init(_ input: String) {
        (host, https) = SelectLemmyAPIVersionUseCase.parseInput(input)
    }
    
    private static func parseInput(_ input: String) -> (host: String, https: Bool) {
        guard let components = URLComponents(string: input), let host = components.host else {
            return (host: input, https: true)
        }
        
        let https = components.scheme != "http"
        
        if let port = components.port {
            return (host: "\(host):\(port)", https: https)
        } else {
            return (host: host, https: https)
        }
    }
    
    func determineAPI(completion: @escaping (Result<LemmyAPIClient, Error>) -> Void) {
        attemptV2 { (successV2) in
            if successV2 {
                return completion(.success(.init(LemmyV2Spec(self.host, https: self.https))))
            }
            
            self.attemptV1 { (successV1) in
                if successV1 {
                    return completion(.success(.init(LemmyV1Spec(self.host, https: self.https))))
                }
                
                return completion(.failure(PlainError("Not a lemmy instance")))
            }
        }
    }
    
    private func attemptV2(completion: @escaping (Bool) -> Void) {
        let spec = LemmyV2Spec(host, https: https)
        let site = spec.fetchSite()
        site.dataProvider.getData { result in
            do {
                let data = try result.get()
                let _ = try JSONDecoder().decode(site.type, from: data)
                
                // The server returned data in the expected format!
                return completion(true)
                
            } catch {
                return completion(false)
            }
        }
    }
    
    private func attemptV1(completion: @escaping (Bool) -> Void) {
        let spec = LemmyV1Spec(host, https: https)
        let site = spec.fetchSite()
        site.dataProvider.getData { result in
            do {
                let data = try result.get()
                let _ = try JSONDecoder().decode(site.type, from: data)
                
                // The server returned data in the expected format!
                return completion(true)
                
            } catch {
                return completion(false)
            }
        }
    }
}
