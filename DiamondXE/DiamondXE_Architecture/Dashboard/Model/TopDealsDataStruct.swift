//
//  TopDealsDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 27/05/24.
//

import Foundation

// MARK: - Welcome
struct TopDealsDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: TopDealsDataDetails?
}

// MARK: - Details
struct TopDealsDataDetails: Codable {
    var natural: [NaturalDiamond]?
    var labGrown: [LabGDiamond]?

    enum CodingKeys: String, CodingKey {
        case natural
        case labGrown = "lab_grown"
    }
}

// MARK: - Natural
struct NaturalDiamond: Codable {
    var stockID, itemName, category: String?
    var supplierID: Int?
    var cutGrade, certificateName, certificateNo, polish: String?
    var symmetry, measurement, fluorescenceIntensity, carat: String?
    var color, clarity, shape, shade: String?
    var tablePerc, depthPerc, luster: String?
    var diamondImage, diamondVideo: String?
    var subtotal: String?
    var totalPrice, isReturnable, dxePrefered, isAvailableForSale: Int?
    var isCart, isWishlist, onHold: Int?

    enum CodingKeys: String, CodingKey {
        case stockID = "stock_id"
        case itemName = "item_name"
        case category
        case supplierID = "supplier_id"
        case cutGrade = "cut_grade"
        case certificateName = "certificate_name"
        case certificateNo = "certificate_no"
        case polish, symmetry, measurement
        case fluorescenceIntensity = "fluorescence_intensity"
        case carat, color, clarity, shape, shade
        case tablePerc = "table_perc"
        case depthPerc = "depth_perc"
        case luster
        case diamondImage = "diamond_image"
        case diamondVideo = "diamond_video"
        case subtotal
        case totalPrice = "total_price"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case isAvailableForSale = "is_available_for_sale"
        case isCart = "is_cart"
        case isWishlist = "is_wishlist"
        case onHold = "on_hold"
    }
}

// MARK: - Lab G
struct LabGDiamond: Codable {
    var stockID, itemName, category: String?
    var supplierID: Int?
    var cutGrade, certificateName, certificateNo, polish: String?
    var symmetry, measurement, fluorescenceIntensity, carat: String?
    var color, clarity, shape, shade: String?
    var tablePerc, depthPerc, luster: String?
    var diamondImage, diamondVideo: String?
    var subtotal: String?
    var totalPrice, isReturnable, dxePrefered, isAvailableForSale: Int?
    var isCart, isWishlist, onHold: Int?

    enum CodingKeys: String, CodingKey {
        case stockID = "stock_id"
        case itemName = "item_name"
        case category
        case supplierID = "supplier_id"
        case cutGrade = "cut_grade"
        case certificateName = "certificate_name"
        case certificateNo = "certificate_no"
        case polish, symmetry, measurement
        case fluorescenceIntensity = "fluorescence_intensity"
        case carat, color, clarity, shape, shade
        case tablePerc = "table_perc"
        case depthPerc = "depth_perc"
        case luster
        case diamondImage = "diamond_image"
        case diamondVideo = "diamond_video"
        case subtotal
        case totalPrice = "total_price"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case isAvailableForSale = "is_available_for_sale"
        case isCart = "is_cart"
        case isWishlist = "is_wishlist"
        case onHold = "on_hold"
    }
}
