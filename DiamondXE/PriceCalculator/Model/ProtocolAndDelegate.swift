//
//  ProtocolAndDelegate.swift
//  DXE Calc
//
//  Created by Genie Talk on 02/03/23.
//

import Foundation

protocol CurrencyResponceProtocol {
    func success(curencyData:CurrencyValue, success: Bool)
    func failed(failed: Bool)
}

protocol BottomSheetActionDelegate {
    func bottomSheetDelegate(userID: String,userIDPass: String, actionTag : Int)
}


protocol CurrencyVCDelegate {
    func getCurrency(currencyType: String,currencyVal: Double)
}

protocol MenuVCSwitchCaseDelegate {
    func isSwitch(isPriceWith10Ct: Bool)
}

protocol NotesAddDelegate {
    func notesAdd(notes: String, noteTag:Int)
}
