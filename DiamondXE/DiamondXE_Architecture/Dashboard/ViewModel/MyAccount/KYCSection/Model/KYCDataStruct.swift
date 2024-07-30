//
//  KYCDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/07/24.
//

import Foundation

struct KYCDataStruct: Codable {
    var status, documentStatus: Int?
    var msg, kycStatus: String?
    var details: KYCDetails?

    enum CodingKeys: String, CodingKey {
        case status, msg
        case kycStatus = "kyc_status"
        case details
        case documentStatus = "document_status"
    }
}

// MARK: - Details
struct KYCDetails: Codable {
    var allDocument: [AadharCardBack]?
    var iecCard, panCard, aadharCardBack, aadharCardFront: AadharCardBack?
    var passportFront, drivingLicense, gstCertificate: AadharCardBack?

    enum CodingKeys: String, CodingKey {
        case allDocument = "all_document"
        case iecCard = "iec_card"
        case panCard = "pan_card"
        case aadharCardBack = "aadhar_card_back"
        case aadharCardFront = "aadhar_card_front"
        case passportFront = "passport_front"
        case drivingLicense = "driving_license"
        case gstCertificate = "gst_certificate"
    }
}

// MARK: - AadharCardBack
struct AadharCardBack: Codable {
    var attachmentID: Int?
    var attachmentType, fileName: String?
    var fileURL: String?
    var attachmentDate, attachmentDesc: String?
    var verifiedInd: Int?
    var aadhaarNo, drivingLicenseNo, gstNo, iec: String??
    var panNo, passportNo: String??

    enum CodingKeys: String, CodingKey {
        case attachmentID = "AttachmentId"
        case attachmentType = "AttachmentType"
        case fileName = "FileName"
        case fileURL = "FileUrl"
        case attachmentDate = "AttachmentDate"
        case attachmentDesc = "AttachmentDesc"
        case verifiedInd = "VerifiedInd"
        case aadhaarNo = "AadhaarNo"
        case drivingLicenseNo = "DrivingLicenseNo"
        case gstNo = "GSTNo"
        case iec = "IEC"
        case panNo = "PANNo"
        case passportNo = "PassportNo"
    }
}
