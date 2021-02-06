//
//  CavyCommunity.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/30/21.
//

import Foundation

struct CavyCommunity {
    var id: Int
    var name: String
    var title: String?
}

protocol CavyCommunityConvertable {
    var cavyCommunity: CavyCommunity { get }
}

extension LemmyCommunity: CavyCommunityConvertable {
    var cavyCommunity: CavyCommunity {
        CavyCommunity(id: id, name: name ?? "", title: title)
    }
}

extension LemmyCommunitySummary: CavyCommunityConvertable {
    var cavyCommunity: CavyCommunity {
        CavyCommunity(id: counts.communityID, name: community?.name ?? "", title: community?.title)
    }
}

protocol CavyCommunityListing {
    var cavyCommunities: [CavyCommunity] { get }
}

extension LemmyCommunitiesResponse: CavyCommunityListing {
    var cavyCommunities: [CavyCommunity] {
        return communities.map(\.cavyCommunity)
    }
}

extension LemmyCommunitiesResponseV2: CavyCommunityListing {
    var cavyCommunities: [CavyCommunity] {
        return communities.map(\.cavyCommunity)
    }
}
