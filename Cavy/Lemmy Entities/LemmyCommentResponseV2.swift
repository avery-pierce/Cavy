//
//  LemmyCommentResponseV2.swift
//  Cavy
//
//  Created by Avery Pierce on 3/25/21.
//

import Foundation

struct LemmyCommentResponseV2: Codable {
    var commentView: LemmyCommentSummary
    var recipientIDs: [Int]?
    var formID: Int?
    
    enum CodingKeys: String, CodingKey {
        case commentView = "comment_view"
        case recipientIDs = "recipient_ids"
        case formID = "form_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        commentView = try values.decode(LemmyCommentSummary.self, forKey: .commentView)
        recipientIDs = try? values.decodeIfPresent([Int].self, forKey: .recipientIDs)
        formID = try? values.decodeIfPresent(Int.self, forKey: .formID)
    }
}
