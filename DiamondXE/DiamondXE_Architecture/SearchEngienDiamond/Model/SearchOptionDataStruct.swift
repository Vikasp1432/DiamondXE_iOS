//
//  SearchOptionDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/06/24.
//

import Foundation


// MARK: - \\
struct SearchOptionDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [SearchOptionDetails]?
}

// MARK: - Detail
struct SearchOptionDetails: Codable {
    var attribTypeID: Int?
    var attribType: String?
    var attribDetails: [SearchAttribDetail]?

    enum CodingKeys: String, CodingKey {
        case attribTypeID = "AttribTypeId"
        case attribType = "AttribType"
        case attribDetails = "AttribDetails"
    }
}

// MARK: - AttribDetail
struct SearchAttribDetail: Codable {
    var attribID, attribTypeID: Int?
    var attribType, attribCode: String?
    var sortOrder: Int??
    var displayAttr: String?

    enum CodingKeys: String, CodingKey {
        case attribID = "AttribId"
        case attribTypeID = "AttribTypeId"
        case attribType = "AttribType"
        case attribCode = "AttribCode"
        case sortOrder = "SortOrder"
        case displayAttr = "DisplayAttr"
    }
}
