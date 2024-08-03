//
//  RecommendentDiamondStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 01/07/24.
//

import Foundation

struct RecommendentDiamondStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [RecommendedDiamdDetail]?
}

// MARK: - Detail
struct RecommendedDiamdDetail: Codable {
    var stockID, itemName, category: String?
    var subtotal: Int?
    var supplierID : String?
    var cutGrade, certificateName, certificateNo, polish: String?
    var symmetry, measurement, fluorescenceIntensity, carat: String?
    var color, clarity, shape, shade: String?
    var tablePerc, depthPerc, luster, eyeClean: String?
    var diamondImage: String?
    var diamondVideo: String?
    var discount: Int?
    var totalGstPerc : String?
    var totalPrice, isReturnable, dxePrefered: Int?
    var status: String?
    var isCart, isWishlist, onHold: Int?
    var rDiscount, rDiscountType: String?

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
        case eyeClean = "eye_clean"
        case diamondImage = "diamond_image"
        case diamondVideo = "diamond_video"
        case discount
        case totalGstPerc = "total_gst_perc"
        case subtotal
        case totalPrice = "total_price"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case status
        case isCart = "is_cart"
        case isWishlist = "is_wishlist"
        case onHold = "on_hold"
        case rDiscount = "r_discount"
        case rDiscountType = "r_discount_type"
    }
}
