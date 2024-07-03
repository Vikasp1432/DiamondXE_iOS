//
//  CartDataStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/07/24.
//

import Foundation

struct CartDataStruct: Codable {
    var isCoupanApplied: Int?
    var couponCode: String?
    var couponValue, couponDiscount, status: Int?
    var msg: String?
    var subTotal, cgst: Int?
    var cgstPerc: Double?
    var sgst: Int?
    var sgstPerc: Double?
    var igst, igstPerc, discountPerc, tax: Int?
    var subTotalWithTax: Double?
    var shippingCharge, platformFee, totalCharge, totalChargeTax: Int?
    var totalChargeWithTax, totalTaxes, totalAmount, taxPerOnCharges: Int?
    var finalAmount, bankCharge, bankChargePerc: Int?
    var details: [CardDataDetail]?

    enum CodingKeys: String, CodingKey {
        case isCoupanApplied = "is_coupan_applied"
        case couponCode = "coupon_code"
        case couponValue = "coupon_value"
        case couponDiscount = "coupon_discount"
        case status, msg
        case subTotal = "sub_total"
        case cgst
        case cgstPerc = "cgst_perc"
        case sgst
        case sgstPerc = "sgst_perc"
        case igst
        case igstPerc = "igst_perc"
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
        case bankChargePerc = "bank_charge_perc"
        case details
    }
}

// MARK: - Detail
struct CardDataDetail: Codable {
    var itemName, stockID, certificateNo, stockNo: String?
    var supplierID: Int?
    var category: String?
    var diamondImage: String?
    var shape, color, clarity: String?
    var rapaportPricePerCT: Int?
    var carat: String?
    var discount: Int?
    var totalGstPerc: String?
    var pricePerCT, subtotal: Int?
    var cgstPer: String?
    var cgstAmt: Int?
    var sgstPer: String?
    var sgstAmt: Int?
    var igstPer: String?
    var igstAmt, tax, totalPrice, labGrownDiaPrice: Int?
    var naturalDiaPrice, shippingCharge, platformFeeAmt, isAvailableForSale: Int?
    var isReturnable, dxePrefered: Int?
    var status: String?
    var onHold: Int?
    var dxeMarkup: String?
    var dealerMarkupCommission, platformFeeTax, shippingChargeTax, totalAmount: Int?
    var totalTax, totalCharges: Int?

    enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case stockID = "stock_id"
        case certificateNo = "certificate_no"
        case stockNo = "stock_no"
        case supplierID = "supplier_id"
        case category
        case diamondImage = "diamond_image"
        case shape, color, clarity
        case rapaportPricePerCT = "rapaport_price_per_ct"
        case carat, discount
        case totalGstPerc = "total_gst_perc"
        case pricePerCT = "price_per_ct"
        case subtotal
        case cgstPer = "cgst_per"
        case cgstAmt = "cgst_amt"
        case sgstPer = "sgst_per"
        case sgstAmt = "sgst_amt"
        case igstPer = "igst_per"
        case igstAmt = "igst_amt"
        case tax
        case totalPrice = "total_price"
        case labGrownDiaPrice = "lab_grown_dia_price"
        case naturalDiaPrice = "natural_dia_price"
        case shippingCharge = "shipping_charge"
        case platformFeeAmt = "platform_fee_amt"
        case isAvailableForSale = "is_available_for_sale"
        case isReturnable = "is_returnable"
        case dxePrefered = "dxe_prefered"
        case status
        case onHold = "on_hold"
        case dxeMarkup = "dxe_markup"
        case dealerMarkupCommission = "dealer_markup_commission"
        case platformFeeTax = "platform_fee_tax"
        case shippingChargeTax = "shipping_charge_tax"
        case totalAmount = "total_amount"
        case totalTax = "total_tax"
        case totalCharges = "total_charges"
    }
}
