//
//  CavySite.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

struct CavySite {
    var name: String
    var iconURL: URL?
    var descriptionMarkdown: String?
    var numberOfUsers: Int?
    var numberOfCommunities: Int?
    var admins: [LemmyUser]?
    var banned: [LemmyUser]?
    var federatedInstances: [String]?
}

extension LemmySiteResponse {
    var cavySite: CavySite {
        CavySite(name: site?.name ?? "", iconURL: site?.icon.flatMap(URL.init(string:)), descriptionMarkdown: site?.description, numberOfUsers: site?.numberOfUsers, numberOfCommunities: site?.numberOfComments, admins: admins, banned: banned, federatedInstances: federatedInstances)
    }
}

extension LemmySiteResponseV2 {
    var cavySite: CavySite {
        CavySite(name: siteView?.site?.name ?? "", iconURL: siteView?.site?.icon.flatMap(URL.init(string:)), descriptionMarkdown: siteView?.site?.description, numberOfUsers: siteView?.counts.users, numberOfCommunities: siteView?.counts.communities, admins: admins?.compactMap(\.user), banned: banned?.compactMap(\.user), federatedInstances: federatedInstances)
    }
}
