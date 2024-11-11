//
//  WalletHistoryStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 08/11/24.
//

import Foundation

struct WalletHistoryStruct: Codable {
    var status: Int?
    var msg: String?
    var details: WalletHistoryDetails?
}

// MARK: - Details
struct WalletHistoryDetails: Codable {
    var walletPoints, totalRecords: Int?
    var history: [WalletHistory]?

    enum CodingKeys: String, CodingKey {
        case walletPoints = "wallet_points"
        case totalRecords = "total_records"
        case history
    }
}

// MARK: - History
struct WalletHistory: Codable {
    var orderID: String?
    var userID: Int?
    var status, type, rewardType: String?
    var walletPoints: Int?
    var remark, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case userID = "user_id"
        case status, type
        case rewardType = "reward_type"
        case walletPoints = "wallet_points"
        case remark
        case createdAt = "created_at"
    }
}
