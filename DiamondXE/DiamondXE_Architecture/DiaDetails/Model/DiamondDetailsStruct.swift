//
//  DiamondDetailsStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/06/24.
//

import Foundation

struct DiamondDetailsStruct: Codable {
    var status: Int?
    var msg: String?
    var details: DiamondDetails?
}

// MARK: - Details
struct DiamondDetails: Codable {
    var stockID, itemName, status, stockNO : String?
    var supplierID: String?
    var certificateNo, category, certificateName, cutGrade: String?
    var shape, clarity, carat, color: String?
    var growthType, fancyColor, fancyColorIntencity, fancyColorOvertone: String?
    var fluorescenceColor, fluorescenceIntensity, polish, symmetry: String?
    var depthPerc, tablePerc, discountAmout: String?
    var rapaportPricePerCT: Int?
    var usdDiaAmt, totalGstPerc, length, width: String?
    var depth, measurement, shade, luster: String?
    var milky, eyeClean, crownAngle, pavillionAngle: String?
    var diamondImage, diamondVideo: String?
    var isReturnable, dxePrefered: Int?
    var certificateFile, girdleCondition, culet, city: String?
    var country, location: String?
    var labGrownDiaPrice, naturalDiaPrice: Int?
    var supplierComment, stockCode, currencyMarkup, stoneRange: String?
    var girdle, girdlePercent, culetCondition, crownHeight: String?
    var pavillionDepth, inscription, heartImageURL, arrowImageURL: String?
    var keyToSymbols, reportComments, treatment: String?
    var pricePerCT: Int?
    var subtotal: Int?
    var tax, totalPrice, isCart, isWishlist: Int?
    var onHold: Int?
    var diamondImages: [DiamondImage]?
    var isDxeLUXE: Int?
    var rDescount,rDescountType: String?

    enum CodingKeys: String, CodingKey {
        case stockID = "stock_id"
        case itemName = "item_name"
        case stockNO = "stock_no"
        case supplierID = "supplier_id"
        case certificateNo = "certificate_no"
        case category
        case certificateName = "certificate_name"
        case cutGrade = "cut_grade"
        case shape, clarity, carat, color
        case growthType = "growth_type"
        case fancyColor = "fancy_color"
        case fancyColorIntencity = "fancy_color_intencity"
        case fancyColorOvertone = "fancy_color_overtone"
        case fluorescenceColor = "fluorescence_color"
        case fluorescenceIntensity = "fluorescence_intensity"
        case polish, symmetry
        case depthPerc = "depth_perc"
        case tablePerc = "table_perc"
        case discountAmout = "discount_amout"
        case rapaportPricePerCT = "rapaport_price_per_ct"
        case usdDiaAmt = "usd_dia_amt"
        case totalGstPerc = "total_gst_perc"
        case length, width, depth, measurement, shade, luster, milky
        case eyeClean = "eye_clean"
        case crownAngle = "crown_angle"
        case pavillionAngle = "pavillion_angle"
        case diamondImage = "diamond_image"
        case diamondVideo = "diamond_video"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case certificateFile = "certificate_file"
        case girdleCondition = "girdle_condition"
        case culet, city, country, location
        case labGrownDiaPrice = "lab_grown_dia_price"
        case naturalDiaPrice = "natural_dia_price"
        case supplierComment = "supplier_comment"
        case stockCode = "stock_code"
        case currencyMarkup = "currency_markup"
        case stoneRange = "stone_range"
        case girdle
        case girdlePercent = "girdle_percent"
        case culetCondition = "culet_condition"
        case crownHeight = "crown_height"
        case pavillionDepth = "pavillion_depth"
        case inscription
        case heartImageURL = "heart_image_url"
        case arrowImageURL = "arrow_image_url"
        case keyToSymbols = "key_to_symbols"
        case reportComments = "report_comments"
        case treatment
        case pricePerCT = "price_per_ct"
        case subtotal, tax
        case totalPrice = "total_price"
        case isCart = "is_cart"
        case isWishlist = "is_wishlist"
        case onHold = "on_hold"
        case diamondImages = "diamond_images"
        case rDescount = "r_discount"
        case rDescountType = "r_discount_type"
        case isDxeLUXE
    }
}

// MARK: - DiamondImage
struct DiamondImage: Codable {
    var type: String?
    var url: String?
}
