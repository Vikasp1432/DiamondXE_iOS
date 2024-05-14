//
//  DocVerifyStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 08/05/24.
//

import Foundation

// MARK: - Welcome
struct DocVerifyStruct: Codable {
    var status: Int?
    var msg: String?
    var details: DocDetails?
}

// MARK: - Details
struct DocDetails: Codable {
    var firstName, lastName, email, companyName: String?
    var companyType, address, city, state: String?
    var country, pincode, natureOfBusiness, bankBeneficiaryName: String?
    var panCompanyName: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case companyName = "company_name"
        case companyType = "company_type"
        case address, city, state, country, pincode
        case natureOfBusiness = "nature_of_business"
        case bankBeneficiaryName = "bank_beneficiary_name"
        case panCompanyName = "pan_company_name"
    }
}
