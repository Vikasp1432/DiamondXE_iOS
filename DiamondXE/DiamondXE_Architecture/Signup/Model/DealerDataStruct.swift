//
//  DealerDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 06/05/24.
//

import Foundation

// get otherDoc list
struct OtherDocListStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [String]?
}

struct BasicCellParamDataStruct: Codable {
    var firstName, lastName, mobileNo, email: String?
    var password, confirmPassword: String?
    
}


struct CompanyDetailsDataStruct: Codable {
    var gstNumber, panNumber, mobileNo, email: String?
    var companyType,companyName, businessNature, country, state: String?
    var city, pinCode, address,address2, iecNumber, trademembership: String?
    
}


//  dealer final data struct
struct DealerSignupDataStruct: Codable {
    var passportNo : String?
    var passportFrontDoc : String?
    var passportBackDoc : String?
    var drivingLicenseNo : String?
    var drivingLicenseDoc : String?
    var firstName, lastName, email, mobileNo: String?
    var country, state, city,referralCode, password: String?
    var confirmPassword, pinCode, address, address2: String?
    var companyName, companyEmail, companyContact, typeOfCompany: String?
    var natureOfBusiness, aadhaarNo, panNo, companyPANNo: String?
    var companyGSTNo, tradeMembershipNo, iecNo, dob: String?
    var inventoryType, emiratesID, requestOtp, emailOtp: String?
    var aadhaarNoDocFront, aadhaarNoDocBack, panNoDoc, companyPANNoDoc: String?
    var companyGSTNoDoc, tradeMembershipNoDoc, iecDoc, emiratesIDDoc: String?
    var otherDocs: [OtherDocInfo]?

    enum CodingKeys: String, CodingKey {
        case firstName, lastName, email, mobileNo, country, state, city, password, confirmPassword, pinCode, address, address2, companyName, companyEmail, companyContact, typeOfCompany, natureOfBusiness, aadhaarNo
        case panNo = "PANNo"
        case companyPANNo, companyGSTNo, tradeMembershipNo
        case iecNo = "IECNo"
        case dob, inventoryType, passportNo,passportFrontDoc, passportBackDoc
        case emiratesID = "emiratesId"
        case requestOtp, emailOtp, aadhaarNoDocFront, aadhaarNoDocBack
        case panNoDoc = "PANNoDoc"
        case companyPANNoDoc, companyGSTNoDoc, tradeMembershipNoDoc
        case iecDoc = "IECDoc"
        case emiratesIDDoc = "emiratesIdDoc"
        case otherDocs, drivingLicenseNo,drivingLicenseDoc
    }
}

// MARK: - OtherDoc
struct OtherDocInfo: Codable {
    var otherDocumentType, otherDocument: String?
    var otherDocumentBack: String?
    var otherDocumentNumber: String?
}


// Supplier data struct
struct SupplierSignupDataStruct: Codable {
    var firstName, lastName, email,referralCode, businessLicenceNumber, mobileNo: String?
    var country, state, city, password: String?
    var confirmPassword, pinCode, address, address2: String?
    var companyName, companyEmail, companyContact, typeOfCompany: String?
    var natureOfBusiness, aadhaarNo, panNo, gstNo: String?
    var companyPANNo, companyGSTNo, tradeMembershipNo, iecNo: String?
    var authPersonName, authPersonContact, authPersonEmail, bankName: String?
    var branchName, accountNo, accountType, ifscCode: String?
    var swiftCode, dob, inventoryType, emiratesID: String?
    var requestOtp, emailOtp, aadhaarNoDocFront, aadhaarNoDocBack: String?
    var panNoDoc, companyPANNoDoc, gstNoDoc, companyGSTNoDoc: String?
    var tradeMembershipNoDoc, iecDoc, emiratesIDDoc: String?
    var otherDocs: [OtherDocInfo]?

    enum CodingKeys: String, CodingKey {
        case firstName, lastName, email, mobileNo, country, state, city, password, confirmPassword, pinCode, address, address2, companyName, companyEmail, companyContact, typeOfCompany, natureOfBusiness, aadhaarNo
        case panNo = "PANNo"
        case gstNo = "GSTNo"
        case companyPANNo, companyGSTNo, tradeMembershipNo
        case iecNo = "IECNo"
        case authPersonName, authPersonContact, authPersonEmail, bankName, branchName, accountNo, accountType
        case ifscCode = "IFSCCode"
        case swiftCode, dob, inventoryType
        case emiratesID = "emiratesId"
        case requestOtp, emailOtp, aadhaarNoDocFront, aadhaarNoDocBack
        case panNoDoc = "PANNoDoc"
        case companyPANNoDoc
        case gstNoDoc = "GSTNoDoc"
        case companyGSTNoDoc, tradeMembershipNoDoc
        case iecDoc = "IECDoc"
        case emiratesIDDoc = "emiratesIdDoc"
        case otherDocs
    }
}

struct SupplierParamDataStruct: Codable {
    var mobileNo : String?
    var email : String?
    var password : String?
    var pinCode : String?
    var address : String?
    var address2 : String?
    var referralCode : String?
    var companyName : String?
    var companyEmail : String?
    var companyContact : String?
    var typeOfCompany : String?
    var natureOfBusiness : String?
    var GSTNo : String?
    var companyPANNo : String?
    var IECNo : String?
    var tradeMembershipNo : String?
    var authPersonName : String?
    var authPersonContact : String?
    var authPersonEmail : String?
    var bankName : String?
    var branchName : String?
    var accountNo : String?
    var accountType : String?
    var IFSCCode : String?
    var swiftCode : String?
    var country : String?
    var state : String?
    var city : String?
    var dob : String?
    var inventoryType : String?
    var emiratesId : String?
   
   
    var aadhaarNoDocFront : String?
    var aadhaarNoDocBack : String?
    var PANNoDoc : String?
    var GSTNoDoc : String?
    var tradeMembershipNoDoc : String?
    var companyPANNoDoc : String?
    var IECDoc : String?
    var emiratesIdDoc : String?
    var passportNo : String?
    var passportFrontDoc : String?
    var passportBackDoc : String?
    var drivingLicenseNo : String?
    var drivingLicenseDoc : String?
}
