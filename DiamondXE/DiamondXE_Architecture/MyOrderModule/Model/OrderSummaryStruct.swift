//
//  OrderSummaryStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/09/24.
//

import Foundation

struct OrderSummaryStruct: Codable {
    var status: Int?
    var msg: String?
    var details: OrderSummaryDetails?
}

// MARK: - Details
struct OrderSummaryDetails: Codable {
    var orderID: Int?
    var orderDate, currencyCode, currencySymbol, exchangeRate: String?
    var subTotal, totalAmount, orderStatus, paymentStatus: String?
    var deliveryDate: String?
    var isReserveOrder: Int?
    var createdAt: String?
   
    var tax, subTotalWithTax, shippingCharge, platformFee: String?
    var bankCharge, totalCharge, totalChargeTax, totalChargeWithTax: String?
    let totalTaxes: String
    let isCouponApplied: Int
    let couponCode, couponDiscount, walletPoints: String
    let giftcardDiscount, loyaltyPoint, finalAmount, bankChargePerc: String
    let specialInstruction, paymentMode, transactionID, taxPerOnCharges: String
  //  let paymentReceivedDate: String
    let isCROrder: Int
    ////
    var courierID, waybill: String?
    var crSubTotal, crCouponDiscount, crTotalTax, crShippingCharge: String?
    var crPlatformFee, crTotalAmount, crBankCharges, crWalletPoints: String?
    var crFinalAmount, crTotalCharges, reserveID, reserveAmount: String?
    var  completeBankCharge, completeTotalAmount, completeFinalAmount, amountDue: String?
    var reserveBankCharge, reserveTotalAmount, reservePaymentMode, reserveTransactionID: String?
    var shippingChargeTax: Int?
    var userDetails: OrderSummaryUserDetails?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderDate = "order_date"
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case exchangeRate = "exchange_rate"
        case subTotal = "sub_total"
        case totalAmount = "total_amount"
        case orderStatus = "order_status"
        case paymentStatus = "payment_status"
        case deliveryDate = "delivery_date"
        case isReserveOrder = "is_reserve_order"
        case createdAt = "created_at"
        case courierID = "courier_id"
        case waybill, tax
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
       // case couponValue = "coupon_value"
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
        case isCROrder = "is_cr_order"
        case crSubTotal = "cr_sub_total"
        case crCouponDiscount = "cr_coupon_discount"
        case crTotalTax = "cr_total_tax"
        case crShippingCharge = "cr_shipping_charge"
        case crPlatformFee = "cr_platform_fee"
        case crTotalAmount = "cr_total_amount"
        case crBankCharges = "cr_bank_charges"
        case crWalletPoints = "cr_wallet_points"
        case crFinalAmount = "cr_final_amount"
        case crTotalCharges = "cr_total_charges"
        case reserveID = "reserve_id"
        case reserveAmount = "reserve_amount"
        case completeBankCharge = "complete_bank_charge"
        case completeTotalAmount = "complete_total_amount"
        case completeFinalAmount = "complete_final_amount"
        case amountDue = "amount_due"
        case reserveBankCharge = "reserve_bank_charge"
        case reserveTotalAmount = "reserve_total_amount"
        case reservePaymentMode = "reserve_payment_mode"
        case reserveTransactionID = "reserve_transaction_id"
        case shippingChargeTax = "shipping_charge_tax"
        case userDetails = "user_details"
    }
}

// MARK: - UserDetails
struct OrderSummaryUserDetails: Codable {
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
