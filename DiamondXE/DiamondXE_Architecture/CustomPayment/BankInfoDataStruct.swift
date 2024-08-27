//
//  BankInfoDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/08/24.
//

import Foundation

struct BankInfoDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [BankInfoDetail]?
}

// MARK: - Detail
struct BankInfoDetail: Codable {
    var bankID: Int?
    var bank, accountName, branchName, ifsc: String?
    var bankName, swift, accountNumber: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case bankID = "bank_id"
        case bank
        case accountName = "account_name"
        case branchName = "branch_name"
        case ifsc
        case bankName = "bank_name"
        case swift
        case accountNumber = "account_number"
        case image
    }
}


struct PaymentModeDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: PaymentModeDetails?
}

// MARK: - Details
struct PaymentModeDetails: Codable {
    var upiCollect, intent, cards: Cards?
    var netBanking: NetBanking?
}

// MARK: - Cards
struct Cards: Codable {
    var enabled: Bool?
}

// MARK: - NetBanking
struct NetBanking: Codable {
    var enabled: Bool?
    var popularBanks, allBanks: [Bank]?
}

// MARK: - Bank
struct Bank: Codable {
    var bankID, bankName, available: String?
    var accountConstraintSupported: Bool?
    var priority: Int?
    var bankShortName: String??
    var img: String??

    enum CodingKeys: String, CodingKey {
        case bankID = "bankId"
        case bankName, available, accountConstraintSupported, priority, bankShortName, img
    }
}


struct BankChargesStruct: Codable {
    var status: Int?
    var msg: String?
    var details: BankChargesDetails?
}

// MARK: - Details
struct BankChargesDetails: Codable {
//    var creditCard: Double?
//    var debitCard, netBanking, neft, upi: Double?
//    var wallets, emi: Int?
    
    var creditCard, debitCard, netBanking: Double?
    var neft, upi: Int?
    var wallets, emi: Double?

    enum CodingKeys: String, CodingKey {
        case creditCard = "CreditCard"
        case debitCard = "DebitCard"
        case netBanking = "NetBanking"
        case neft = "NEFT"
        case upi = "UPI"
        case wallets = "Wallets"
        case emi = "EMI"
    }
}


