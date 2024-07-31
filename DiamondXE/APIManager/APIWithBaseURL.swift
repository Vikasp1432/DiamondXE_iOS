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
    let devBaseURL = "https://app-uat.diamondxe.com/"
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
    
    let get_SearchAttribute_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-attributes"
    
    let get_Diamond_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-diamonds"
    
    let get_DiamondDetails_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-diamond-details"
    let get_CurrencyRates_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-currency-rates"
    
    let get_DiamodPreview_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/diamond-size-preview"
    
    let addtoCart_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/add-to-cart"
    
    let removetoCart_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/remove-from-cart"
    
    let addtoWishlist_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/add-to-wishlist"
    
    let removetoWishlist_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/remove-from-wishlist"
    
    let recommendent_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-recommended-diamonds"
    
    let get_CartData_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-cart-details"
    
    let get_Wishlist_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-wishlist-details"
//
    let get_Logout_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/logout"
    
    let get_RefreshToken_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/refresh-token"
    
    let get_AddAddress_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/add-address"
    
    let get_RemoveAddress_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/remove-address"
    
    let get_UpdateAddress_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/update-address"
    
    let get_GetAddressBilling_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-address/billing"
    
    let get_GetAddressShipping_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-address/shipping"
    
    let updatePassword_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/change-password"
    
    let get_KYCDoc_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-kyc-details"
    
    let upload_KYCDoc_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/update-kyc-details"
    
    let get_ProfileInfo_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-profile"
    
    let update_ProfileInfo_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/update-profile"
    
}

struct HeaderInfo {
    
    static let loginData = UserDefaultManager().retrieveLoginData()
    static var brrTokn = loginData?.details?.authToken ?? ""
    
    let headers : HTTPHeaders =  ["Content-Type":"application/json",
                                  "Authorization" : "Bearer \(brrTokn)",//
                                  "Apikey" : APIs().api_Key]
}

struct HeaderInfoLocation {
//    let timeZoneMatcher = TimeZoneMatcher()
//    var timeZone = timeZoneMatcher.findAndPrintMatchingTimeZone()
//    let headers : HTTPHeaders =  ["Content-Type":"application/json",
//                                  "location" : "IN",
//                                  "Apikey" : APIs().api_Key]
    
    let timeZoneMatcher = TimeZoneMatcher()
      var timeZoneInfo: (identifier: String, countryCode: String?) {
          return timeZoneMatcher.findAndPrintMatchingTimeZone()
      }
      
      var headers: HTTPHeaders {
          
          
          if let loginData = UserDefaultManager().retrieveLoginData(){
              let brrTokn = loginData.details?.authToken ?? ""
              let locationCode = timeZoneInfo.countryCode ?? "US"
              return [
                  "Content-Type": "application/json",
                  "location": locationCode,
                  "Apikey": APIs().api_Key,
                  "Authorization" : "Bearer \(brrTokn)"//
              ]
          }
          else{
              let locationCode = timeZoneInfo.countryCode ?? "US"
              return [
                  "Content-Type": "application/json",
                  "location": locationCode,
                  "Apikey": APIs().api_Key
              ]
          }
          
         
      }
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
    
    let economicTimes = "https://economictimes.indiatimes.com/small-biz/sme-sector/online-diamond-trading-platform-d[…]sparent-pricing-for-industry/articleshow/102904102.cms"
    let retailJeweller = "https://retailjewellerindia.com/online-diamond-trading-platform-diamondxe-seeks-to-change-the-way-diamonds-are-bought-and-sold/"
    let midday = "https://www.mid-day.com/brand-media/article/diamondxe-set-to-revolutionise-the-industry-with-innovative-solutions-23306755"
    
    let viewALL = "https://diamondxe.com/media-gallery"
    
}
