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
        let parts = descriptor.split(separator: "/")
        if parts.count > 1 {
            let base = parts[0..<(parts.count - 1)].joined(separator: "/")
            let versionString = parts.last!.lowercased()
            
            switch versionString {
            case "v1": self = .v1(LemmyV1Spec(base))
            case "v2": self = .v2(LemmyV2Spec(base))
            default: self = .v2(LemmyV2Spec(descriptor))
            }
        } else {
            let version = LemmyAPIClient.knownAPIVersions[descriptor] ?? .v2
            switch version {
            case .v1: self = .v1(LemmyV1Spec(descriptor))
            case .v2: self = .v2(LemmyV2Spec(descriptor))
            }
        }
    }
    
    var descriptor: String {
        switch self {
        case .v1(let spec): return "\(spec.factory.host)/v1"
        case .v2(let spec): return "\(spec.factory.host)/v2"
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
