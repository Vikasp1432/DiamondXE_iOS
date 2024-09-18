//
//  CreateOrderStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 10/09/24.
//

import Foundation

struct CreateOrderStruct: Codable {
    var status: Int?
    var msg: String?
    var details: OrederDetails?
}

// MARK: - Details
struct OrederDetails: Codable {
    var orderID, referenceNo, currency: String?
    var amount: Double?
    var userDetails: OrderedUserDetails?
    var paymentStatus: String?
    var callbackURL: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case referenceNo = "reference_no"
        case currency, amount
        case userDetails = "user_details"
        case paymentStatus = "payment_status"
        case callbackURL = "callback_url"
    }
}

// MARK: - UserDetails
struct OrderedUserDetails: Codable {
    var userID: Int?
    var userRole, firstName, lastName, email: String?
    var mobile: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userRole = "user_role"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, mobile
    }
}
