//
//  MyOrderDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 16/09/24.
//

import Foundation


struct MyOrderDataStruct: Codable {
    var status: Int?
    var msg: String?
    var details: [MyOrderDetail]?
    var totalRecords: Int?

    enum CodingKeys: String, CodingKey {
        case status, msg, details
        case totalRecords = "total_records"
    }
}

// MARK: - Detail
struct MyOrderDetail: Codable {
    var orderID, cancleOrderID: Int?
    var orderDate, currencyCode, totalAmount, orderStatus: String?
    var paymentStatus, createdAt: String?
    var deliveryDate, reason, comment, cancel_by: String?
    var isCancelable, isReturnable, isReserveOrder: Int?
    var  timeLeftForCancel: String?//paymentReceivedDate,
    var diamonds: [MyOrderDiamond]?
    var returnEligbleDate, return_date, cancelled_at : String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case cancleOrderID = "cancel_return_order_id"
        case orderDate = "order_date"
        case currencyCode = "currency_code"
        case totalAmount = "total_amount"
        case orderStatus = "order_status"
        case paymentStatus = "payment_status"
        case createdAt = "created_at"
        case deliveryDate = "delivery_date"
        case isCancelable = "is_cancelable"
        case isReturnable = "is_returnable"
        case isReserveOrder = "is_reserve_order"
        case returnEligbleDate = "return_eligible_date"
        case timeLeftForCancel = "time_left_for_cancel"
        case diamonds, reason, comment, cancel_by, return_date, cancelled_at
    }
}

// MARK: - Diamond
struct MyOrderDiamond: Codable {
    var stockID, certificateNo, carat, color: String?
    var clarity, shape, stockNo: String?
    var isReturnable, dxePrefered: Int?
    var category, itemName, discount, totalAmount: String?
    var totalPrice, subTotal: String?
    var diamondImage: String?
    var otherDetails: MyOrderOtherDetails?
    var status, cancelBy: String?

    enum CodingKeys: String, CodingKey {
        case stockID = "stock_id"
        case certificateNo = "certificate_no"
        case carat, color, clarity, shape
        case stockNo = "stock_no"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case category
        case itemName = "item_name"
        case discount
        case totalAmount = "total_amount"
        case totalPrice = "total_price"
        case subTotal = "sub_total"
        case diamondImage = "diamond_image"
        case otherDetails = "other_details"
        case status
        case cancelBy = "cancel_by"
    }
}

// MARK: - OtherDetails
struct MyOrderOtherDetails: Codable {
    var carat, color, culet, shade: String?
    var shape, polish, clarity, diaAmt: String?
    var location, symmetry, cutGrade, eyeClean: String?
    var itemName, depthPerc, stockCode, tablePerc: String?
    var crownAngle, fancyColor, growthType, measurement: String?
    var crownHeight: String?
    var diamondVideo: String?
    var keyToSymbols, pavillionAngle, pavillionDepth, reportComments: String?
    var certificateFile, certificateName, girdleCondition, supplierComment: String?
    var fancyColorOvertone, fancyColorIntencity: String?
    var rapaportPricePerCT: Int?
    var fluorescenceIntensity: String?
    var availabilityStatus: String?

    enum CodingKeys: String, CodingKey {
        case carat, color, culet, shade, shape, polish, clarity
        case diaAmt = "dia_amt"
        case location, symmetry
        case cutGrade = "cut_grade"
        case eyeClean = "eye_clean"
        case itemName = "item_name"
        case depthPerc = "depth_perc"
        case stockCode = "stock_code"
        case tablePerc = "table_perc"
        case crownAngle = "crown_angle"
        case fancyColor = "fancy_color"
        case growthType = "growth_type"
        case measurement
        case crownHeight = "crown_height"
        case diamondVideo = "diamond_video"
        case keyToSymbols = "key_to_symbols"
        case pavillionAngle = "pavillion_angle"
        case pavillionDepth = "pavillion_depth"
        case reportComments = "report_comments"
        case certificateFile = "certificate_file"
        case certificateName = "certificate_name"
        case girdleCondition = "girdle_condition"
        case supplierComment = "supplier_comment"
        case fancyColorOvertone = "fancy_color_overtone"
        case fancyColorIntencity = "fancy_color_intencity"
        case rapaportPricePerCT = "rapaport_price_per_ct"
        case fluorescenceIntensity = "fluorescence_intensity"
        case availabilityStatus = "availability_status"
    }
}


// order details

struct OrderDetailsStruct: Codable {
    var status: Int?
    var msg: String?
    var details: OrderDetailsDetails?
}

// MARK: - Details
struct OrderDetailsDetails: Codable {
    var orderID: Int?
    var currencyCode, currencySymbol, subTotal, orderStatus: String?
    var paymentStatus, createdAt: String?
    var diamonds: [OrderDetailsDiamond]?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case subTotal = "sub_total"
        case orderStatus = "order_status"
        case paymentStatus = "payment_status"
        case createdAt = "created_at"
        case diamonds
    }
}

// MARK: - Diamond
struct OrderDetailsDiamond: Codable {
    var stockID, certificateNo, stockNo: String?
    var isReturnable, dxePrefered: Int?
    var category, itemName, subTotal, tax: String?
    var shippingCharge, shippingChargeTax, platformFeeAmt, totalChargeTax: String?
    var platformFeeTax, discount, totalAmount, totalPrice: String?
    var totalCharges, totalTax: String?
    var diamondImage: String?
    var status: String?
    var cancelBy: String??
    var carat, color, culet, shade: String?
    var shape, polish, clarity, diaAmt: String?
    var location, symmetry, cutGrade, eyeClean: String?
    var depthPerc, stockCode, tablePerc, crownAngle: String?
    var fancyColor, growthType, measurement, crownHeight: String?
    var diamondVideo: String?
    var keyToSymbols, pavillionAngle, pavillionDepth, reportComments: String?
    var certificateFile, certificateName, girdleCondition, supplierComment: String?
    var availabilityStatus, fancyColorOvertone, fancyColorIntencity: String?
    var rapaportPricePerCT: Int?
    var fluorescenceIntensity: String?

    enum CodingKeys: String, CodingKey {
        case stockID = "stock_id"
        case certificateNo = "certificate_no"
        case stockNo = "stock_no"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case category
        case itemName = "item_name"
        case subTotal = "sub_total"
        case tax
        case shippingCharge = "shipping_charge"
        case shippingChargeTax = "shipping_charge_tax"
        case platformFeeAmt = "platform_fee_amt"
        case totalChargeTax = "total_charge_tax"
        case platformFeeTax = "platform_fee_tax"
        case discount
        case totalAmount = "total_amount"
        case totalPrice = "total_price"
        case totalCharges = "total_charges"
        case totalTax = "total_tax"
        case diamondImage = "diamond_image"
        case status
        case cancelBy = "cancel_by"
        case carat, color, culet, shade, shape, polish, clarity
        case diaAmt = "dia_amt"
        case location, symmetry
        case cutGrade = "cut_grade"
        case eyeClean = "eye_clean"
        case depthPerc = "depth_perc"
        case stockCode = "stock_code"
        case tablePerc = "table_perc"
        case crownAngle = "crown_angle"
        case fancyColor = "fancy_color"
        case growthType = "growth_type"
        case measurement
        case crownHeight = "crown_height"
        case diamondVideo = "diamond_video"
        case keyToSymbols = "key_to_symbols"
        case pavillionAngle = "pavillion_angle"
        case pavillionDepth = "pavillion_depth"
        case reportComments = "report_comments"
        case certificateFile = "certificate_file"
        case certificateName = "certificate_name"
        case girdleCondition = "girdle_condition"
        case supplierComment = "supplier_comment"
        case availabilityStatus = "availability_status"
        case fancyColorOvertone = "fancy_color_overtone"
        case fancyColorIntencity = "fancy_color_intencity"
        case rapaportPricePerCT = "rapaport_price_per_ct"
        case fluorescenceIntensity = "fluorescence_intensity"
    }
}
