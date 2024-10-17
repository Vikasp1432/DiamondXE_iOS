//
//  DiamondSearchDataStructB2B.swift
//  DiamondXE
//
//  Created by iOS Developer on 14/06/24.
//

import Foundation

// MARK: - Welcome
struct DiamondSearchDataStructB2B: Codable {
    var status: Int?
    var msg: String?
    var totalRecords, avgDiamondPrice: Int?
    var details: [DiamondListingDetail]?
    
    var cart_count : Int?
    var wishlist_count : Int?
    
    enum CodingKeys: String, CodingKey {
        case status, msg
        case totalRecords = "total_records"
        case avgDiamondPrice = "avg_diamond_price"
        case details
    }
}

   // MARK: - Detail
   struct DiamondListingDetail: Codable {
       var stockID, itemName, category, stockNO: String?
       var subtotal: Int?
       var supplierID : String?
       var cutGrade, certificateName, certificateNo, polish: String?
       var symmetry, measurement, fluorescenceIntensity, carat: String?
       var color, clarity, shape, shade: String?
       var tablePerc, depthPerc, luster, eyeClean: String?
       var diamondImage: String?
       var diamondVideo: String?
       var totalGstPerc: String?
       var totalPrice, isReturnable, dxePrefered, isCart: Int?
       var isWishlist, onHold: Int?
       var rDiscount, rDiscountType, status: String?
       var couponDesPer : Double?
       var subtotalAfterCouponDiscount : Double?

       enum CodingKeys: String, CodingKey {
           case couponDesPer = "coupon_discount_perc"
           case subtotalAfterCouponDiscount = "subtotal_after_coupon_discount"
           case stockID = "stock_id"
           case itemName = "item_name"
           case stockNO = "stock_no"
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
           case totalGstPerc = "total_gst_perc"
           case subtotal
           case totalPrice = "total_price"
           case isReturnable = "is_returnable"
           case dxePrefered = "dxe_prefered"
           case isCart = "is_cart"
           case isWishlist = "is_wishlist"
           case onHold = "on_hold"
           case rDiscount = "r_discount"
           case rDiscountType = "r_discount_type"
           case status
       }
   }
