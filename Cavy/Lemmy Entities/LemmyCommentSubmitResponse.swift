//
//  LemmyCommentSubmitResponse.swift
//  Cavy
//
//  Created by Avery Pierce on 4/5/21.
//

import Foundation

struct LemmyCommentSubmitResponse: Codable, Equatable {
    let comment: LemmyComment
    let recipientIDs: [Int]?
    let formID: Int?
    
    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case recipientIDs = "recipient_ids"
        case formID = "form_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comment = try values.decode(LemmyComment.self, forKey: .comment)
        recipientIDs = try? values.decodeIfPresent([Int].self, forKey: .recipientIDs)
        formID = try? values.decodeIfPresent(Int.self, forKey: .formID)
    }
}
