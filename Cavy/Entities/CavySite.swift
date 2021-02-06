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
    var admins: [CavyUser]?
    var banned: [CavyUser]?
    var federatedInstances: [String]?
}

protocol CavySiteConvertable {
    var cavySite: CavySite { get }
}

extension LemmySiteResponse: CavySiteConvertable {
    var cavySite: CavySite {
        CavySite(name: site?.name ?? "", iconURL: site?.icon.flatMap(URL.init(string:)), descriptionMarkdown: site?.description, numberOfUsers: site?.numberOfUsers, numberOfCommunities: site?.numberOfComments, admins: admins.map(\.cavyUser), banned: banned.map(\.cavyUser), federatedInstances: federatedInstances)
    }
}

extension LemmySiteResponseV2: CavySiteConvertable {
    var cavySite: CavySite {
        CavySite(name: siteView?.site?.name ?? "",
                 iconURL: siteView?.site?.icon.flatMap(URL.init(string:)),
                 descriptionMarkdown: siteView?.site?.description,
                 numberOfUsers: siteView?.counts.users,
                 numberOfCommunities: siteView?.counts.communities,
                 admins: admins?.compactMap(\.user).map(\.cavyUser),
                 banned: banned?.compactMap(\.user).map(\.cavyUser),
                 federatedInstances: federatedInstances?.linked)
    }
}
