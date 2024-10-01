//
//  CancelOrderPriceManageStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/09/24.
//

import Foundation
struct CancelOrderPriceManageStruct: Codable {
    var status: Int?
    var msg: String?
    var details: CancelManageDetails?
}

// MARK: - Details
struct CancelManageDetails: Codable {
    var orderID: Int?
    var orderDate, currencyCode, currencySymbol, exchangeRate: String?
    var totalAmount, orderStatus, paymentStatus, deliveryDate: String?
    var isReserveOrder: Int?
    var createdAt: String?
    //let courierID, waybill: JSONNull?
    var subTotal, tax, subTotalWithTax, shippingCharge: String?
    var platformFee, bankCharge, totalCharge, totalChargeTax: String?
    var totalChargeWithTax, totalTaxes: String?
    var isCouponApplied: Int?
    var couponCode, couponValue, couponDiscount, walletPoints: String?
    var giftcardDiscount, loyaltyPoint, finalAmount, bankChargePerc: String?
    var specialInstruction, paymentMode, transactionID, taxPerOnCharges: String?
   // var paymentReceivedDate: String?
    var isCancelable, shippingChargeTax: Int?
    var userDetails: CancelManageUserDetails?
    var diamonds: [CancelManageDiamond]?
    var cancelOrderSummery: [String: Int]?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderDate = "order_date"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case exchangeRate = "exchange_rate"
        case totalAmount = "total_amount"
        case orderStatus = "order_status"
        case paymentStatus = "payment_status"
        case deliveryDate = "delivery_date"
        case isReserveOrder = "is_reserve_order"
        case createdAt = "created_at"
        //case courierID = "courier_id"
       // case waybill
        case subTotal = "sub_total"
        case tax
        case subTotalWithTax = "sub_total_with_tax"
        case shippingCharge = "shipping_charge"
        case platformFee = "platform_fee"
        case bankCharge = "bank_charge"
        case totalCharge = "total_charge"
        case totalChargeTax = "total_charge_tax"
        case totalChargeWithTax = "total_charge_with_tax"
        case totalTaxes = "total_taxes"
        case isCouponApplied = "is_coupon_applied"
        case couponCode = "coupon_code"
        case couponValue = "coupon_value"
        case couponDiscount = "coupon_discount"
        case walletPoints = "wallet_points"
        case giftcardDiscount = "giftcard_discount"
        case loyaltyPoint = "loyalty_point"
        case finalAmount = "final_amount"
        case bankChargePerc = "bank_charge_perc"
        case specialInstruction = "special_instruction"
        case paymentMode = "payment_mode"
        case transactionID = "transaction_id"
        case taxPerOnCharges = "tax_per_on_charges"
      //  case paymentReceivedDate = "payment_received_date"
        case isCancelable = "is_cancelable"
        case shippingChargeTax = "shipping_charge_tax"
        case userDetails = "user_details"
        case diamonds
        case cancelOrderSummery = "cancel_order_summery"
    }
}

// MARK: - Diamond
struct CancelManageDiamond: Codable {
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

// MARK: - UserDetails
struct CancelManageUserDetails: Codable {
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
