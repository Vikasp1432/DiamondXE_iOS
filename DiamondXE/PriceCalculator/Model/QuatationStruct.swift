//
//  QuatationStruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 10/10/24.
//

import Foundation

struct Quotationstruct: Codable {
    var metalwt: Double?
    var metalRatePGm: Double?
    var metalwtTotal: Double?
    var labourChar: Double?
    var labourCharRatePGm: Double?
    var labourCharTotal: Double?
    var solitairwt: Double?
    var solitairRatePCt: Double?
    var solitairTotal: Double?
    var sideDIA: Double?
    var sideDIARatePCt: Double?
    var sideDIATotal: Double?
    var colStoneWt: Double?
    var colStonePCt: Double?
    var colStoneTotal: Double?
    var extraCharges: Double?
    var taxCharges: Double?
    var taxCalculation: Double?
    var currncyVal: Double?
    var currencyType: String?
    var natualOrLabGrown: String?
    var solitaierNotes: String?
    var sideDiaNotes: String?
    var otherCharges: String?
    var productName: String?
    var purityType: String?
    var grandTotal: String?
    var priceWitCurr: String?
    var dateStr: String?
}
