//
//  WishlistDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 03/07/24.
//

import Foundation

struct WishlistDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [WishlistData]?
}

// MARK: - Detail
struct WishlistData: Codable {
    var certificateNo, createdAt, stockID, itemName: String?
    var supplierID, stockNo: String?
    var category, cutGrade, certificateName, polish: String?
    var symmetry, measurement, fluorescenceIntensity, carat: String?
    var color, clarity, shape, shade: String?
    var tablePerc, depthPerc, luster, eyeClean: String?
    var diamondImage: String?
    var diamondVideo: String?
    var discount, rapaportPricePerCT, labGrownDiaPrice, naturalDiaPrice: Int?
    var isAvailableForSale, isReturnable, dxePrefered: Int?
    var status, totalGstPerc: String?
    var pricePerCT, subtotal, tax, totalPrice: Int?
    var isCart, onHold, shippingCharge, platformFeeAmt: Int?
   // var dxeMarkup: String?
    var couponDesPer : Double?
    var subtotalAfterCouponDiscount : Double?

    enum CodingKeys: String, CodingKey {
        case couponDesPer = "coupon_discount_perc"
        case subtotalAfterCouponDiscount = "subtotal_after_coupon_discount"
        case certificateNo = "certificate_no"
        case createdAt = "created_at"
        case stockNo = "stock_no"
        case stockID = "stock_id"
        case itemName = "item_name"
        case supplierID = "supplier_id"
        case category
        case cutGrade = "cut_grade"
        case certificateName = "certificate_name"
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
        case rapaportPricePerCT = "rapaport_price_per_ct"
        case labGrownDiaPrice = "lab_grown_dia_price"
        case naturalDiaPrice = "natural_dia_price"
        case isAvailableForSale = "is_available_for_sale"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case status
        case totalGstPerc = "total_gst_perc"
        case pricePerCT = "price_per_ct"
        case subtotal, tax
        case totalPrice = "total_price"
        case isCart = "is_cart"
        case onHold = "on_hold"
        case shippingCharge = "shipping_charge"
        case platformFeeAmt = "platform_fee_amt"
      //  case dxeMarkup = "dxe_markup"
    }
}
