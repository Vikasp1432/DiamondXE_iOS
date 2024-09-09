//
//  PaymentStatusStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 30/08/24.
//

import Foundation

// MARK: - Welcome
struct PaymentStatusStruct: Codable {
    var status: Int?
    var msg: String?
    var details: PaymentStatusDetails?
}

// MARK: - Details
struct PaymentStatusDetails: Codable {
    var referenceNo, transactionID, currencyCode, currencySymbol: String?
    var amount, bankCharge, finalAmount, paymentMode: String?
    var paymentStatus: String?
    var isPaymentStatusUpdated: Int?

    enum CodingKeys: String, CodingKey {
        case referenceNo = "reference_no"
        case transactionID = "transaction_id"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case amount
        case bankCharge = "bank_charge"
        case finalAmount = "final_amount"
        case paymentMode = "payment_mode"
        case paymentStatus = "payment_status"
        case isPaymentStatusUpdated = "is_payment_status_updated"
    }
}
