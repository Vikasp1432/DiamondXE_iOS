//
//  LoginDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 19/04/24.
//

import Foundation
// MARK: - LoginDataStruct
struct LoginDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: UserDetails?
}

// MARK: - Details
struct UserDetails: Codable {
    var userRole, email, mobileNo, firstName: String?
    var lastName, companyName, status, kycStatus: String?
    var authToken: String?
}


// MARK: - LoginParamStruct
struct LoginParamStruct: Codable {
    var deviceType, deviceID, sessionID, userType: String?
    var loginType, email, mobileNo, password: String?
    
    var requestOtp, otp: Int?

     enum CodingKeys: String, CodingKey {
         case deviceType
         case deviceID = "deviceId"
         case sessionID = "sessionId"
         case userType, loginType, email, password
     }
 }
