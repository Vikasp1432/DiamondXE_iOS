//
//  APIWithBaseURL.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/04/24.
//

import Foundation
import Alamofire


// calc api
let privateKey = "k5tmjiqqhjkcoe85zq7lccdybg0mwz"
let privateKeyPass = "DR4v4E60"

let apiLogin = URL(string: "https://technet.rapaport.com/HTTP/Authenticate.aspx")
let apiGetPrice = "https://technet.rapaport.com/HTTP/JSON/Prices/GetPriceSheet.aspx"
let apiCurrencyValue = "https://api.exchangerate.host/live?access_key=b0c77183d8b05bf58c91106f2f39a3a1&latest?base=usd"
let giaURL = "https://www.gia.edu/report-check-landing"
let igiURL = "https://www.igi.org/verify-your-report/en"
let inrInfoURL = "https://api.exchangerate.host/convert?access_key=b0c77183d8b05bf58c91106f2f39a3a1&from=USD&to=INR&amount=1" //"https://api.exchangerate.host/convert?from=USD&to=INR"


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
    
    let buyProductUpdate_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/place-order"
    
    let deleteAccount_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/delete-user-account"
    
    let getBankInfo_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-dxe-bank-details"
    
    let getPaymentMode_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/phonepe-payment-options"
    
    let proceedPayment_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/custom-payment/init"
    
    let historyPayment_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/custom-payment/history"
    
    let getBankCharges_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-bank-charges"
    //
    var callBackURL = "https://\(DiamondXEEnvironment.rootURL)payments/phonepe-custom-payment-callback"
    
    var customPayment_Status_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/custom-payment/status"
    
    var checkOutDetails_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/get-checkout-details"
    
    var createOrder_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/create-order"
    
    var proceedPayment_Status_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/order-payment-status"
    
    var getOrderList_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/orders-list"
    
    var getOrderDetails_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/order-details"
    
    var getOrderSummery_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/order-summary"
    
    var getORderTracking_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/order-tracking-details"
    
    var getCancelResion_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/order-cancel-reasons"
    
    var getReturnResion_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/order-return-reasons"
    
    var cancelledOrdrDetails_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/cancel-order-details"
    
    var canceleOrdrSubmit_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/cancel-order-checkout"
    
    var canceleOrdr_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/cancel-order"
    
    
    var getDealerMrkupInfo_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/dealer/settings"
    
    var updateDealerMrkupInfo_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/dealer/update-settings"
    
    var returnChekout_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/return-order-checkout"
    
    var returnOrderRequest_API = "https://\(DiamondXEEnvironment.rootURL)app/v1/return-order"
    
}

//struct HeaderInfo {
//    
//    let loginData = UserDefaultManager().retrieveLoginData()
//    var brrTokn = loginData?.details?.authToken ?? ""
//    
//    let headers : HTTPHeaders =  ["Content-Type":"application/json",
//                                  "Authorization" : "Bearer \(brrTokn)",//
//                                  "Apikey" : APIs().api_Key]
//}


struct HeaderInfo {
  static var headers: HTTPHeaders {
        // Retrieve login data
        let loginData = UserDefaultManager().retrieveLoginData()
        
        let authToken = loginData?.details?.authToken ?? ""
        
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken)",
            "Apikey": APIs().api_Key
        ]
    }
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
    
    let termandCondition = "https://diamondxe.com/policy/terms-conditions"
    
    
    let returnPolicy = "https://diamondxe.com/return-policy"
   
    
}
