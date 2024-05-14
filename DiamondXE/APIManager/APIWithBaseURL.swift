//
//  APIWithBaseURL.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/04/24.
//

import Foundation
import Alamofire

struct APIs {
    let liveBaseURL = "https://admin.diamondxe.com/app/v1/validate-document"
    let api_Key = "b8795c60-1400-4d70-b254-837a2a1da9e7"
    let supplierWebLogin = "https://supplier-uat.diamondxe.com/sign-in"
    
    // login apis
    let email_phone_loginAPI = "https://\(DiamondXEEnvironment.rootURL)app/v1/login"
    let forgot_passwordAPI = "https://\(DiamondXEEnvironment.rootURL)app/v1/forgot-password"
    let reset_passwordAPI = "https://\(DiamondXEEnvironment.rootURL)app/v1/reset-password"
    let country_list_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/country-list"
    let indianFlag = "https://\(DiamondXEEnvironment.rootURL)img/country-flags/32x32/in.png"
    
    // singup apis
    let signup_Buyer_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/register-buyer"
    let signup_Dealer_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/register-dealer"
    let signup_Supplier_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/register-supplier"
    let city_list_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/city-list"
    let state_list_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/state-list"
    let otherDoc_list_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-other-document-types"
    let document_verification_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/validate-document"
    
    let email_verification_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/verify-email"
}

struct HeaderInfo {
    let headers : HTTPHeaders =  ["Content-Type":"application/json",
                                  "Apikey" : APIs().api_Key]
}

