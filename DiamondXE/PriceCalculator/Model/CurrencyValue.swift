//
//  CurrencyValue.swift
//  DXE Calc
//
//  Created by Genie Talk on 02/03/23.
//

import Foundation

// MARK: - Welcome6
struct CurrencyValue: Codable {
    var motd: MOTD?
    var success: Bool?
    var base, date: String?
    var quotes: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case motd
        case success = "country_code"
        case base, date
        case quotes
    }
}

// MARK: - MOTD
struct MOTD: Codable {
    var msg: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case msg, url
    }
}


// MARK: - Welcome8
struct INRCurrency : Codable {
    var motd: MOTD?
    var success: Bool?
    var query: Query?
    var info: Info?
    var historical: Bool?
    var date: String?
    var result: Double?
    
    enum CodingKeys: String, CodingKey {
        case success, historical,date, result
    }
}

// MARK: - Info
struct Info : Codable {
    var rate: Double?
    enum CodingKeys: String, CodingKey {
        case rate
    }
}


// MARK: - Query
struct Query : Codable {
    let from, to: String
    let amount: Int
    
    enum CodingKeys: String, CodingKey {
        case from, to, amount
    }
}
