//
//  AllCouponObjStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/10/24.
//

import Foundation
struct AllCouponObjStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [CouponListDetail]?
}

// MARK: - Detail
struct CouponListDetail: Codable {
    var usertype, itemType, category, code: String?
    var description, type, currencyCode, value: String?
    var termsAndConditions, startDate, endDate: String?

    enum CodingKeys: String, CodingKey {
        case usertype
        case itemType = "item_type"
        case category, code, description, type
        case currencyCode = "currency_code"
        case value
        case termsAndConditions = "terms_and_conditions"
        case startDate = "start_date"
        case endDate = "end_date"
    }
}
