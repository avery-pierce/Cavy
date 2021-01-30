//
//  ListingDescriptor.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

struct ListingDescriptor: Codable, Equatable, Hashable {
    var client: String
    var communityID: Int?
    var favorite: Bool
    
    init(clientDescriptor: String, communityID: Int?, favorite: Bool = false) {
        self.client = clientDescriptor
        self.communityID = communityID
        self.favorite = favorite
    }
    
    init(_ client: LemmyAPIClient, communityID: Int?, favorite: Bool = false) {
        self.init(clientDescriptor: client.descriptor, communityID: communityID, favorite: favorite)
    }
    
    static let lemmyMain = ListingDescriptor(LemmyAPIClient.lemmyML, communityID: nil)
    
    var name: String {
        let host = LemmyAPIClient(descriptor: client).host
        if let communityID = communityID {
            return "\(host)/\(communityID)"
        } else {
            return "\(host)"
        }
    }
}
