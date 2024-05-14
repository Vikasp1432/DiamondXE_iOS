//
//  BuyerDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 01/05/24.
//

import Foundation

struct SignupReponceDataStruct: Codable {
      var status: Int?
      var msg: String?
      var details: SingUpDetails?
  }

  // MARK: - Details
  struct SingUpDetails: Codable {
      var userID: Int?
      var userRole: String?

      enum CodingKeys: String, CodingKey {
          case userID = "userId"
          case userRole
      }
  }




// MARK: - buyer data struct
struct BuyerParamDataStruct: Codable {
    var firstName, lastName, mobileNo, email: String?
    var password, confirmPassword, country, state: String?
    var city, pinCode, address,address2,referralCode, requestOtp: String?
    var emailOtp: String?
}





// email
struct EmialVerify: Codable {
      var status: Int?
      var msg: String?
  }



