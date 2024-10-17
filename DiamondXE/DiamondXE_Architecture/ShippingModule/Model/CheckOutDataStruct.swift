//
//  CheckOutDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 06/09/24.
//

import Foundation


struct CheckOutDataStruct: Codable {
    var isCoupanApplied: Int?
    var couponCode: String?
    var couponValue: Double?
    var couponDiscount, status, coupenStatus, walletPoint: Int?
    var msg, couperMSG: String?
    var subTotal: Int?
   // var cgstPerc: Double?
    //var sgst: Int?
    var  discountPerc: Double?
    var  tax: Int?
    var subTotalWithTax: Double?
    var shippingCharge, platformFee, totalCharge, totalChargeTax: Int?
    var totalChargeWithTax, totalTaxes, totalAmount, taxPerOnCharges: Int?
    var finalAmount, bankCharge: Int?//bankChargePerc
    var availableWalletPoints: String?
    var details: [CheckOutDetail]?

    enum CodingKeys: String, CodingKey {
        case isCoupanApplied = "is_coupan_applied"
        case couponCode = "coupon_code"
       // case couponValue = "coupon_value"
        case couponDiscount = "coupon_discount"
        case status, msg
        case subTotal = "sub_total"
        case couperMSG = "coupon_msg"
//        case cgstPerc = "cgst_perc"
//        case sgst
//        case sgstPerc = "sgst_perc"
//        case igst
//        case igstPerc = "igst_perc"
        case discountPerc = "discount_perc"
        case tax
        case subTotalWithTax = "sub_total_with_tax"
        case shippingCharge = "shipping_charge"
        case platformFee = "platform_fee"
        case totalCharge = "total_charge"
        case totalChargeTax = "total_charge_tax"
        case totalChargeWithTax = "total_charge_with_tax"
        case totalTaxes = "total_taxes"
        case totalAmount = "total_amount"
        case taxPerOnCharges = "tax_per_on_charges"
        case finalAmount = "final_amount"
        case bankCharge = "bank_charge"
        //case bankChargePerc = "bank_charge_perc"
        case availableWalletPoints = "available_wallet_points"
        case details
        case walletPoint = "wallet_points"
        case coupenStatus = "coupon_status"
    }
}

// MARK: - Detail
struct CheckOutDetail: Codable {
    var itemName, stockID, certificateNo, stockNo: String?
    var supplierID, category: String?
    var diamondImage: String?
    var shape, measurement, carat, clarity: String?
    var color, fancyColor, fancyColorIntencity, fancyColorOvertone: String?
    var certificateName, stockCode: String?
    var rapaportPricePerCT, discount: Int?
    var totalGstPerc: String?
    var pricePerCT, subtotal: Int?
//    var cgstPer: String?
//    var cgstAmt: Int?
//    var sgstPer: String?
//    var sgstAmt: Int?igstAmt
//    var igstPer: String?
    var  tax, totalPrice, isReturnable: Int?
    var dxePrefered: Int?
    var status: String?
    var labGrownDiaPrice, naturalDiaPrice: Int?
    var diaAmt: String?
    var shippingCharge, platformFeeAmt, isAvailableForSale: Int?
    var fluorescenceIntensity, tablePerc, depthPerc, cutGrade: String?
    var polish, symmetry, growthType, crownAngle: String?
    var eyeClean: String?
    var diamondVideo: String?
    var crownHeight, pavillionAngle, pavillionDepth, girdleCondition:  String?
    var culet, shade, luster, location: String?
    var certificateFile, keyToSymbols, reportComments, supplierComment: String?
    var buyerMarkupPerc, dealerMarkupPerc: String?
    var onHold: Int?
    var dxeMarkup: String?
   // var dealerMarkupCommission: String?
    var rDiscount, rDiscountType: String?
    var platformFeeTax, shippingChargeTax, totalAmount, totalTax: Int?
    var totalCharges: Int?

    enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case stockID = "stock_id"
        case certificateNo = "certificate_no"
        case stockNo = "stock_no"
        case supplierID = "supplier_id"
        case category
        case diamondImage = "diamond_image"
        case shape, measurement, carat, clarity, color
        case fancyColor = "fancy_color"
        case fancyColorIntencity = "fancy_color_intencity"
        case fancyColorOvertone = "fancy_color_overtone"
        case certificateName = "certificate_name"
        case stockCode = "stock_code"
        case rapaportPricePerCT = "rapaport_price_per_ct"
        case discount
        case totalGstPerc = "total_gst_perc"
        case pricePerCT = "price_per_ct"
        case subtotal
//        case cgstPer = "cgst_per"
//        case cgstAmt = "cgst_amt"
//        case sgstPer = "sgst_per"
//        case sgstAmt = "sgst_amt"
//        case igstPer = "igst_per"
//        case igstAmt = "igst_amt"
        case tax
        case totalPrice = "total_price"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case status
        case labGrownDiaPrice = "lab_grown_dia_price"
        case naturalDiaPrice = "natural_dia_price"
        case diaAmt = "dia_amt"
        case shippingCharge = "shipping_charge"
        case platformFeeAmt = "platform_fee_amt"
        case isAvailableForSale = "is_available_for_sale"
        case fluorescenceIntensity = "fluorescence_intensity"
        case tablePerc = "table_perc"
        case depthPerc = "depth_perc"
        case cutGrade = "cut_grade"
        case polish, symmetry
        case growthType = "growth_type"
        case crownAngle = "crown_angle"
        case eyeClean = "eye_clean"
        case diamondVideo = "diamond_video"
        case crownHeight = "crown_height"
        case pavillionAngle = "pavillion_angle"
        case pavillionDepth = "pavillion_depth"
        case girdleCondition = "girdle_condition"
        case culet, shade, luster, location
        case certificateFile = "certificate_file"
        case keyToSymbols = "key_to_symbols"
        case reportComments = "report_comments"
        case supplierComment = "supplier_comment"
        case buyerMarkupPerc = "buyer_markup_perc"
        case dealerMarkupPerc = "dealer_markup_perc"
        case onHold = "on_hold"
        case dxeMarkup = "dxe_markup"
       // case dealerMarkupCommission = "dealer_markup_commission"
        case rDiscount = "r_discount"
        case rDiscountType = "r_discount_type"
        case platformFeeTax = "platform_fee_tax"
        case shippingChargeTax = "shipping_charge_tax"
        case totalAmount = "total_amount"
        case totalTax = "total_tax"
        case totalCharges = "total_charges"
    }
}



