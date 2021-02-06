//
//  SelectLemmyAPIVersionUseCase.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

class SelectLemmyAPIVersionUseCase {
    let host: String
    init(_ host: String) {
        self.host = host
    }
    
    func determineAPI(completion: @escaping (Result<LemmyAPIClient, Error>) -> Void) {
        attemptV2 { (successV2) in
            if successV2 {
                return completion(.success(.init(LemmyV2Spec(self.host))))
            }
            
            self.attemptV1 { (successV1) in
                if successV1 {
                    return completion(.success(.init(LemmyV1Spec(self.host))))
                }
                
                return completion(.failure(PlainError("Not a lemmy instance")))
            }
        }
    }
    
    private func attemptV2(completion: @escaping (Bool) -> Void) {
        let spec = LemmyV2Spec(host)
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
        let spec = LemmyV1Spec(host)
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
