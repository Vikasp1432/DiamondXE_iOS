//
//  ProfileInfoStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/07/24.
//

import Foundation
// MARK: - Welcome
struct ProfileInfoStruct: Codable {
    var status: Int?
    var msg: String?
    var details: ProfileDetails?
}

// MARK: - Details
struct ProfileDetails: Codable {
    var userID: Int?
    var role, profileNo, firstName, lastName: String?
    var gstNo, aadhaarNo, panNo, companyName: String?
    var companyContact, companyEmailID, typeOfCompany, companyPANNo: String?
    var companyGSTNo, tradeMembershipNo, natureOfBusiness, iec: String?
    var authPersonName, authPersonContact, authPersonEmailID: String?
    var loginEmailID, loginMobileNo, status: String?
    var returnable, dxePreferred: Int?
    var kycStatus: String?
    var bankInfo: String?
    var companyDialCode, companyNumber, mobileDialCode, mobileNumber: String?
    var authPersonDialCode, authPersonNumber, dob, inventoryType: String?
    var drivingLicenseNo, passportNo, emiratesID: String?
    var address: [UserAddress]?

    enum CodingKeys: String, CodingKey {
        case userID = "UserId"
        case role = "Role"
        case profileNo = "ProfileNo"
        case firstName = "FirstName"
        case lastName = "LastName"
        case gstNo = "GSTNo"
        case aadhaarNo = "AadhaarNo"
        case panNo = "PANNo"
        case companyName = "CompanyName"
        case companyContact = "CompanyContact"
        case companyEmailID = "CompanyEmailId"
        case typeOfCompany = "TypeOfCompany"
        case companyPANNo = "CompanyPANNo"
        case companyGSTNo = "CompanyGSTNo"
        case tradeMembershipNo = "TradeMembershipNo"
        case natureOfBusiness = "NatureOfBusiness"
        case iec = "IEC"
        case authPersonName = "AuthPersonName"
        case authPersonContact = "AuthPersonContact"
        case authPersonEmailID = "AuthPersonEmailId"
        case loginEmailID = "LoginEmailId"
        case loginMobileNo = "LoginMobileNo"
        case status = "Status"
        case returnable = "Returnable"
        case dxePreferred = "DXEPreferred"
        case kycStatus = "KYCStatus"
        case bankInfo = "BankInfo"
        case companyDialCode = "CompanyDialCode"
        case companyNumber = "CompanyNumber"
        case mobileDialCode = "MobileDialCode"
        case mobileNumber = "MobileNumber"
        case authPersonDialCode = "AuthPersonDialCode"
        case authPersonNumber = "AuthPersonNumber"
        case dob = "DOB"
        case inventoryType = "InventoryType"
        case drivingLicenseNo = "DrivingLicenseNo"
        case passportNo = "PassportNo"
        case emiratesID = "EmiratesId"
        case address = "Address"
    }
}

// MARK: - Address
struct UserAddress: Codable {
    var addressID, addressTypeID: Int?
    var addressType, address1: String?
    var address2: String??
    var cityName, stateName, countryName, pinCode: String?
    var isDefault: Int?
    var emailID, mobileNo: String?
    var gstNo, businessName: String??
    var countryID, stateID, cityID: Int?

    enum CodingKeys: String, CodingKey {
        case addressID = "AddressId"
        case addressTypeID = "AddressTypeId"
        case addressType = "AddressType"
        case address1 = "Address1"
        case address2 = "Address2"
        case cityName = "CityName"
        case stateName = "StateName"
        case countryName = "CountryName"
        case pinCode = "PinCode"
        case isDefault = "IsDefault"
        case emailID = "EmailId"
        case mobileNo = "MobileNo"
        case gstNo = "GSTNo"
        case businessName = "BusinessName"
        case countryID = "CountryID"
        case stateID = "StateID"
        case cityID = "CityID"
    }
}
