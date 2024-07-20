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
