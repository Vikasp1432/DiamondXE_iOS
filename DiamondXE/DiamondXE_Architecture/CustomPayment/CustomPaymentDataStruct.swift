//
//  CustomPaymentDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/08/24.
//

import Foundation

struct CustomPaymentDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: CustomPaymentDetails?
}

// MARK: - Details
struct CustomPaymentDetails: Codable {
    var totalRecords: Int?
    var history: [PaymentHistory]?

    enum CodingKeys: String, CodingKey {
        case totalRecords = "total_records"
        case history
    }
}

// MARK: - History
struct PaymentHistory: Codable {
    var referenceNo, currencyCode, currencySymbol, exchangeRate: String?
    var amount, bankChargePerc, bankCharge, finalAmount: String?
    var paymentMode, bankUtrNo, bankPaymentMethod, bankTransactionDate: String?
    var paymentStatus, description, createdAt, transactionID: String?

    enum CodingKeys: String, CodingKey {
        case referenceNo = "reference_no"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case exchangeRate = "exchange_rate"
        case amount
        case bankChargePerc = "bank_charge_perc"
        case bankCharge = "bank_charge"
        case finalAmount = "final_amount"
        case paymentMode = "payment_mode"
        case bankUtrNo = "bank_utr_no"
        case bankPaymentMethod = "bank_payment_method"
        case bankTransactionDate = "bank_transaction_date"
        case paymentStatus = "payment_status"
        case description
        case createdAt = "created_at"
        case transactionID = "transaction_id"
    }
}


struct PaymentINProcessStruct: Codable {
    var status: Int?
    var msg: String?
    var details: PymtInProcessDetails?
}

// MARK: - Details
struct PymtInProcessDetails: Codable {
    var orderID: String?
    var userID: Int?
    var currencyCode, currencySymbol: String?
    var exchangeRate: Double?
    var paymentMode: String?
    var amount, bankCharge, bankChargePerc, totalAmount: Double?
    var description, paymentStatus: String?
    var userData: UserData?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case userID = "user_id"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case exchangeRate = "exchange_rate"
        case paymentMode = "payment_mode"
        case amount
        case bankCharge = "bank_charge"
        case bankChargePerc = "bank_charge_perc"
        case totalAmount = "total_amount"
        case description
        case paymentStatus = "payment_status"
        case userData = "user_data"
        case createdAt = "created_at"
    }
}

// MARK: - UserData
struct UserData: Codable {
    var firstname, lastname, email, mobile: String?
}
