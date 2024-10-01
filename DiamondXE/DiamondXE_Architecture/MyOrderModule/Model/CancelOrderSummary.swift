//
//  CancelOrderSummary.swift
//  DiamondXE
//
//  Created by iOS Developer on 19/09/24.
//

import Foundation
import UIKit


struct CancelOrderSummaryStruct: Codable {
    var status: Int?
    var msg: String?
    var details: CancelOrderDetails?
}

// MARK: - Details
struct CancelOrderDetails: Codable {
    var orderID, cancelReturnOrderID: Int?
    var cancelReturnDate, cancelReturnType, currencyCode, currencySymbol: String?
    var orderStatus, paymentStatus, orderCreatedAt, cancelledAt: String?
    var totalAmount, walletPoints, sourceAmount, bankCharge: String?
    var reason, comment, refundPaymentMode, subTotal: String?
    var totalTax, shippingCharge, platformFee, couponDiscount: String?
    var totalCharge, refundStatus, cancelBy: String?
    var userDetails: CancelOrderUserDetails?
    var diamonds: [CancelOrderDiamond]?
    var parentOrderSummery: CancelOrderParentOrderSummery?
    var cancelOrderSummery: [String: Int]?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case cancelReturnOrderID = "cancel_return_order_id"
        case cancelReturnDate = "cancel_return_date"
        case cancelReturnType = "cancel_return_type"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case orderStatus = "order_status"
        case paymentStatus = "payment_status"
        case orderCreatedAt = "order_created_at"
        case cancelledAt = "cancelled_at"
        case totalAmount = "total_amount"
        case walletPoints = "wallet_points"
        case sourceAmount = "source_amount"
        case bankCharge = "bank_charge"
        case reason, comment
        case refundPaymentMode = "refund_payment_mode"
        case subTotal = "sub_total"
        case totalTax = "total_tax"
        case shippingCharge = "shipping_charge"
        case platformFee = "platform_fee"
        case couponDiscount = "coupon_discount"
        case totalCharge = "total_charge"
        case refundStatus = "refund_status"
        case cancelBy = "cancel_by"
        case userDetails = "user_details"
        case diamonds
        case parentOrderSummery = "parent_order_summery"
        case cancelOrderSummery = "cancel_order_summery"
    }
}

// MARK: - Diamond
struct CancelOrderDiamond: Codable {
    var stockID, certificateNo, stockNo, itemName: String?
    var subTotal, tax, shippingCharge, category: String?
    var shippingChargeTax, platformFeeAmt, platformFeeTax, discount: String?
    var totalAmount, totalPrice, totalCharges, totalTax: String?
    var diamondImage: String?
    var status, cancelBy, carat, color: String?
    var culet, shade, shape, polish: String?
    var clarity, diaAmt, location, symmetry: String?
    var cutGrade, eyeClean, depthPerc, stockCode: String?
    var tablePerc, crownAngle, fancyColor, growthType: String?
    var measurement, crownHeight: String?
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
        case itemName = "item_name"
        case subTotal = "sub_total"
        case tax
        case shippingCharge = "shipping_charge"
        case category
        case shippingChargeTax = "shipping_charge_tax"
        case platformFeeAmt = "platform_fee_amt"
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

// MARK: - ParentOrderSummery
struct CancelOrderParentOrderSummery: Codable {
    var subTotal, tax, subTotalWithTax, shippingCharge,transaction_id : String?
    var platformFee, bankCharge, bankChargePerc, taxPerOnCharges: String?
    var totalCharge, totalChargeTax, totalTaxes, totalChargeWithTax: String?
    var totalAmount, couponDiscount, walletPoints, giftcardDiscount: String?
    var loyaltyPoint, finalAmount, paymentMode: String?

    enum CodingKeys: String, CodingKey {
        case subTotal = "sub_total"
        case tax, transaction_id
        case subTotalWithTax = "sub_total_with_tax"
        case shippingCharge = "shipping_charge"
        case platformFee = "platform_fee"
        case bankCharge = "bank_charge"
        case bankChargePerc = "bank_charge_perc"
        case taxPerOnCharges = "tax_per_on_charges"
        case totalCharge = "total_charge"
        case totalChargeTax = "total_charge_tax"
        case totalTaxes = "total_taxes"
        case totalChargeWithTax = "total_charge_with_tax"
        case totalAmount = "total_amount"
        case couponDiscount = "coupon_discount"
        case walletPoints = "wallet_points"
        case giftcardDiscount = "giftcard_discount"
        case loyaltyPoint = "loyalty_point"
        case finalAmount = "final_amount"
        case paymentMode = "payment_mode"
    }
}

// MARK: - UserDetails
struct CancelOrderUserDetails: Codable {
    var userRole, userName, userEmail, userMobile: String?
    var billingAddress, shippingAddress: String?
    var collectFromHub: String?
    var billingAddressGstNo, billingAddressBusinessName, shippingAddressGstNo, shippingAddressBusinessName: String?

    enum CodingKeys: String, CodingKey {
        case userRole = "user_role"
        case userName = "user_name"
        case userEmail = "user_email"
        case userMobile = "user_mobile"
        case billingAddress = "billing_address"
        case shippingAddress = "shipping_address"
        case collectFromHub = "collect_from_hub"
        case billingAddressGstNo = "billing_address_gst_no"
        case billingAddressBusinessName = "billing_address_business_name"
        case shippingAddressGstNo = "shipping_address_gst_no"
        case shippingAddressBusinessName = "shipping_address_business_name"
    }
}



