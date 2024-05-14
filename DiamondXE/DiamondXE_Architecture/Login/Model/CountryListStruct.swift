//
//  CountryListStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/04/24.
//

import Foundation

// MARK: - Get country list
struct CountryListStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [CountryList]?
}

// MARK: - Detail
struct CountryList: Codable {
    var id: Int?
    var name, countryCode: String?
    var flag: String?
    var phonecode: String?
    

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryCode = "country_code"
        case flag, phonecode
    }
}


struct StateListStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [StateList]?
}

// MARK: - Detail
struct StateList: Codable {
    var id: Int?
    var name: String?
  
    enum CodingKeys: String, CodingKey {
        case id, name
      
    }
}

struct CityListStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [CityList]?
}

// MARK: - Detail
struct CityList: Codable {
    var id: Int?
    var name: String?
    enum CodingKeys: String, CodingKey {
        case id, name
      
    }
}
