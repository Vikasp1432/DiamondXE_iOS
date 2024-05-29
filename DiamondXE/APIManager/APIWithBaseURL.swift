//
//  APIWithBaseURL.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/04/24.
//

import Foundation
import Alamofire

struct APIs {
    //staging = app-uat.diamondxe.com/
    //live = admin.diamondxe.com/
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
    
    let get_HomeContent_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-home-page-details"
    let get_topDeals_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/top-deals"
}

struct HeaderInfo {
    let headers : HTTPHeaders =  ["Content-Type":"application/json",
                                  "Apikey" : APIs().api_Key]
}

struct SideBarURLs {
    let diamondEducation = "https://diamondxe.com/diamond-education/5C-explained"
    let ForJeweller =  "https://diamondxe.com/for-dealer"
    let forSupplier = "https://diamondxe.com/for-supplier"
    let aboutUs = "https://diamondxe.com/about"
    let whyUs = "https://diamondxe.com/why-us"
    let blogs = "https://diamondxe.com/blogs"
    let mediaGallery = "https://diamondxe.com/media-gallery"
    let support =  "https://diamondxe.com/contact"
    let termsConditions = "https://diamondxe.com/policy/terms-conditions"
    let privacyPolicy = "https://diamondxe.com/policy/privacy-policy"
    let rateUs = "https://maps.app.goo.gl/TSUh7AtAfrJSLV8u5"
    let LinkedIn =  "https://www.linkedin.com/company/86411293/admin/feed/posts/"
    let Instagram = "https://www.instagram.com/diamond_xe/"
    let Facebook = "https://www.facebook.com/DiamondXE"
    let YouTube = "https://youtube.com/@d-xe?si=VuTSaNDDvStzT1In"
    
}
