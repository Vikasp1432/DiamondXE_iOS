//
//  HomeDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 27/05/24.
//

import Foundation

// MARK: - Welcome
struct HomeDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: HomeDataDetails?
}

// MARK: - Details
struct HomeDataDetails: Codable {
    var banners, middleBanners, features: Banners?
    var registerNow: RegisterNow?
    var dxeLuxe: DxeLuxe?
    var media: Media?
    var customerStories: CustomerStories?

    enum CodingKeys: String, CodingKey {
        case banners
        case middleBanners = "middle-banners"
        case features
        case registerNow = "register-now"
        case dxeLuxe = "dxe-luxe"
        case media
        case customerStories = "customer_stories"
    }
}

// MARK: - Banners
struct Banners: Codable {
    var title: String?
    var content: [BannersContent]?
}

// MARK: - BannersContent
struct BannersContent: Codable {
    var image: String?
    var link: String?
}

// MARK: - CustomerStories
struct CustomerStories: Codable {
    var title: String?
    var content: [CustomerStoriesContent]?
}

// MARK: - CustomerStoriesContent
struct CustomerStoriesContent: Codable {
    var image: String?
}

// MARK: - DxeLuxe
struct DxeLuxe: Codable {
    var title: String?
    var content: BannersContent?
}

// MARK: - Media
struct Media: Codable {
    var title: String?
    var content: [MediaContent]?
}

// MARK: - MediaContent
struct MediaContent: Codable {
    var image: String?
    var description: String?
    var link: String?
}

// MARK: - RegisterNow
struct RegisterNow: Codable {
    var title: String?
    var content: RegisterNowContent?
}

// MARK: - RegisterNowContent
struct RegisterNowContent: Codable {
    var  image: String?
    var  link, buttonText: String?

    enum CodingKeys: String, CodingKey {
        case image, link
        case buttonText = "button_text"
    }
}

struct LogoutDataStruct: Codable {
    var status : Int?
    var msg : String?
}


struct RefreshBearerToken: Codable {
    var status: Int?
    var msg: String?
    var details: TokenDetails?
}

// MARK: - Details
struct TokenDetails: Codable {
    var accessToken, tokenType: String?
    var expiresIn: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}


struct GetAddressStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [AddressDetail]?
    var pincode: String?
}

// MARK: - Detail
struct AddressDetail: Codable {
    var addressID, addressTypeID: Int?
    var addressType, address1: String?
    var address2: String?
    var cityNameS: String?
    var cityName: Int?
    var stateNameS: String?
    var stateName: Int?
    var countryNameS: String?
    var countryName: Int?
    var pinCode: String?
    var isDefault: Int?
    var emailID, mobileNo: String?
    var gstNo, businessName: String?
    var mobileDialCode, mobileNumber: String?

    enum CodingKeys: String, CodingKey {
        case addressID = "AddressId"
        case addressTypeID = "AddressTypeId"
        case addressType = "AddressType"
        case address1 = "Address1"
        case address2 = "Address2"
        case cityNameS = "CityNameS"
        case cityName = "CityName"
        case stateNameS = "StateNameS"
        case stateName = "StateName"
        case countryNameS = "CountryNameS"
        case countryName = "CountryName"
        case pinCode = "PinCode"
        case isDefault = "IsDefault"
        case emailID = "EmailId"
        case mobileNo = "MobileNo"
        case gstNo = "GSTNo"
        case businessName = "BusinessName"
        case mobileDialCode = "MobileDialCode"
        case mobileNumber = "MobileNumber"
    }
}
