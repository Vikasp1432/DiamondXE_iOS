//
//  CalculationClass.swift
//  DXE Calc
//
//  Created by Genie Talk on 06/03/23.
//

import Foundation

class Calculation {
    
    func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value * percentageVal
        return val / 100.0
    }
    
    
    
    func calculateAmountToPer(orignalAmt:Double,newAmnt:Double)->Double{
        let val = orignalAmt - newAmnt
        
        let updatedVal = val / orignalAmt
        
        return updatedVal * 100.0
    }
    
    func calculateByMultiplyLogic(paramA:Double,paramB:Double)->Double{
        return paramA * paramB
    }
    
    func calculateByDevideLogic(devidedBy:Double,totalAmnt:Double)->Double{
        return totalAmnt / devidedBy
    }
    
    
    
    
    func decimalManage(value : Double) -> String{
        return String(format: "%.2f", value)
    }
    
    
    func decimalRoundOf(value : Double) -> String{
        return String(format: "%.0f", value)
    }
    
    
    func decimalAmtWith4Digit(value : Double) -> String{
        return String(format: "%.4f", value)
    }
    
    func totalPriceFormatter(value : Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en_IN")
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:value))
        
        return formattedNumber ?? ""
    }
    
    
    
    func decimalManageCurrency(value : Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        let formattedNumber = numberFormatter.string(from: NSNumber(value:value ))
        return formattedNumber ?? ""
    }
    
    
    
    
}


extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()

    var delimiter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
