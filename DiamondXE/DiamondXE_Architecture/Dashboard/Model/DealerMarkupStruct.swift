//
//  DealerMarkupStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 01/10/24.
//

import Foundation

struct DealerMarkupStruct: Codable {
    var status: Int?
    var msg: String?
    var details: DealerMarkupDetails?
}

// MARK: - Details
struct DealerMarkupDetails: Codable {
    var commissionRange: [CommissionRange]?

    enum CodingKeys: String, CodingKey {
        case commissionRange = "commission_range"
    }
}

// MARK: - CommissionRange
struct CommissionRange: Codable {
    var from, to, natural, labGrown: String?

    enum CodingKeys: String, CodingKey {
        case from, to, natural
        case labGrown = "lab_grown"
    }
}

