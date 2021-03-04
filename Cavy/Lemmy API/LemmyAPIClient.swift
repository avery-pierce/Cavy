//
//  LemmyAPIClient.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/29/21.
//

import Foundation

enum LemmyAPIClient {
    case v1(LemmyV1Spec)
    case v2(LemmyV2Spec)
    
    init(_ spec: LemmyV1Spec) {
        self = .v1(spec)
    }
    
    init(_ spec: LemmyV2Spec) {
        self = .v2(spec)
    }
    
    static let knownAPIVersions: [String: LemmyAPIFactory.APIVersion] = [
        "chapo.chat": .v1,
        "www.chapo.chat": .v1,
        "lemmy.ml": .v2,
        "lemmygrad.ml": .v2,
    ]
}

extension LemmyAPIClient {
    static let lemmyML = LemmyAPIClient.v2(.lemmyML)
    static let lemmygradML = LemmyAPIClient.v2(LemmyV2Spec("lemmygrad.ml"))
    static let chapoChat = LemmyAPIClient.v1(LemmyV1Spec("chapo.chat"))
}

extension LemmyAPIClient {
    init(descriptor: String) {
        let parts = descriptor.split(separator: "@")
        if parts.count > 1 {
            let username = String(parts[0])
            let domainAndAPILevel = String(parts[1])
            let client = LemmyAPIClient.parseDomainAndAPILevel(domainAndAPILevel)
            guard let jwt = KeychainUseCase().findJWT(forUser: username, onServer: client.host) else {
                self = client
                return
            }
            
            client.apiFactory.username = username
            client.apiFactory.token = jwt
            self = client
        } else {
            self = LemmyAPIClient.parseDomainAndAPILevel(descriptor)
        }
    }
    
    private static func parseDomainAndAPILevel(_ descriptor: String) -> LemmyAPIClient {
        let parts = descriptor.split(separator: "/")
        if parts.count > 2 {
            let base = parts[0..<(parts.count - 2)].joined(separator: "/")
            let scheme = parts[parts.count - 2].lowercased()
            let https = scheme != "http"
            let versionString = parts.last!.lowercased()
            
            switch versionString {
            case "v1": return .v1(LemmyV1Spec(base, https: https))
            case "v2": return .v2(LemmyV2Spec(base, https: https))
            default: return .v2(LemmyV2Spec(descriptor, https: https))
            }
        } else if parts.count > 1 {
            let base = parts[0..<(parts.count - 1)].joined(separator: "/")
            let versionString = parts.last!.lowercased()
            
            switch versionString {
            case "v1": return .v1(LemmyV1Spec(base))
            case "v2": return .v2(LemmyV2Spec(base))
            default: return .v2(LemmyV2Spec(descriptor))
            }
        } else {
            let version = LemmyAPIClient.knownAPIVersions[descriptor] ?? .v2
            switch version {
            case .v1: return .v1(LemmyV1Spec(descriptor))
            case .v2: return .v2(LemmyV2Spec(descriptor))
            }
        }
    }
    
    var descriptor: String {
        let host = apiFactory.host
        let scheme = apiFactory.https ? "https" : "http"
        let version = apiFactory.version.rawValue
        
        if let user = authenticatedUser {
            return "\(user)@\(host)/\(scheme)/\(version)"
        } else {
            return "\(host)/\(scheme)/\(version)"
        }
    }
}

extension LemmyAPIClient {
    var apiFactory: LemmyAPIFactory {
        switch self {
        case .v1(let spec): return spec.factory
        case .v2(let spec): return spec.factory
        }
    }
    
    var host: String { apiFactory.host }
    var versionLevel: LemmyAPIFactory.APIVersion { apiFactory.version }
}

extension LemmyAPIClient {
    func authenticated(as username: String, jwt: String) -> LemmyAPIClient {
        let newClient = LemmyAPIClient(descriptor: self.descriptor)
        newClient.apiFactory.username = username
        newClient.apiFactory.token = jwt
        return newClient
    }
    
    var isAuthenticated: Bool {
        return apiFactory.token != nil
    }
    
    var authenticatedUser: String? {
        guard isAuthenticated else { return nil }
        return apiFactory.username
    }
}
