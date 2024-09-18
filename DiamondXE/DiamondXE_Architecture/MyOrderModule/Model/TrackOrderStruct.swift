//
//  TrackOrderStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/09/24.
//

import Foundation


struct TrackOrderStruct: Codable {
    var status: Int?
    var msg: String?
    var details: TrackOrderDetails?
}

// MARK: - Details
struct TrackOrderDetails: Codable {
    var orderID: Int?
    var orderStatus: String?
    var trackingDetails: TrackingDetails?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderStatus = "order_status"
        case trackingDetails = "tracking_details"
    }
}

// MARK: - TrackingDetails
struct TrackingDetails: Codable {
    var tarckingNo: String?
    var currentStatusCode: Int?
    var latestStatus, remark, date: String?
    var history: [History]?

    enum CodingKeys: String, CodingKey {
        case tarckingNo = "tarcking_no"
        case currentStatusCode = "current_status_code"
        case latestStatus = "latest_status"
        case remark, date, history
    }
}

// MARK: - History
struct History: Codable {
    var statusCode: Int?
    var status, note, datetime, image: String?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, note, datetime, image
    }
}
