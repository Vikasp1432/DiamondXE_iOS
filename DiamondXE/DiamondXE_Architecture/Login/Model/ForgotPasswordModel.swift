//
//  ForgotPasswordModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/04/24.
//

import Foundation

// parse Data
struct ForgotPassStruct: Codable {
    var status: Int?
    var msg: String?
}

//Param Data
struct ForgotPassParamStruct: Codable {
    var userType: String?
    var email: String?
}

// param data
struct ResetPasswordStruct: Codable {
    var email: String?
    var otp, resetPassword: Int?
    var password, confirmPassword: String?
}

// param data
struct VCTags: Codable {
    var tagVC: Int?
}
