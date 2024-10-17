//
//  CalcUserDefault.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/08/24.
//

import Foundation

class CalcUserDefaultManager{
    let userDefaults = UserDefaults.standard
    
    func setPriceListRoundData(priceList:Data){
        userDefaults.set(priceList, forKey: "priceListDataRound")
    }
    
    func getPriceListRoundData() -> PriceListStruct{
        var priceList = PriceListStruct()
        let roundData = userDefaults.object(forKey: "priceListDataRound") as? Data
        if roundData != nil{
            let decoder = JSONDecoder()
            priceList = try! decoder.decode(PriceListStruct.self, from: roundData!)
        }
        return priceList
    }
    
    func setPriceListPearData(priceList:Data){
        userDefaults.set(priceList, forKey: "priceListDataPear")
    }
    
    func getPriceListPearData() -> PriceListStruct{
        var priceList = PriceListStruct()
        let roundData = userDefaults.object(forKey: "priceListDataPear") as? Data
        if roundData != nil{
            let decoder = JSONDecoder()
            priceList = try! decoder.decode(PriceListStruct.self, from: roundData!)
        }
        return priceList
    }
    
    
    func setDatePriceSheet(){
        var roundData = CalcUserDefaultManager().getPriceListRoundData()
        if let priceData = roundData.response?.body?.price{
            let updateDate = priceData.first?.date
            userDefaults.set(updateDate, forKey: "priceSheetDate")
        }
        
       
    }
    
    func getDatePriceSheet() -> String{
        return userDefaults.object(forKey: "priceSheetDate") as? String ?? ""
    }
    
    
    func setCurrencyValue(currencyValue:Double){
        userDefaults.set(currencyValue, forKey: "currencyValue")
    }
    
    func getCurrencyValue() -> Double{
        return userDefaults.double(forKey: "currencyValue") as? Double ?? 0.0
    }
    
    
    func setCurrencyType(currencyValue:String){
        userDefaults.set(currencyValue, forKey: "currencyType")
    }
    
    func getCurrencyType() -> String{
        return userDefaults.string(forKey: "currencyType") as? String ?? ""
    }
    
    
    
    func setMetalRateValue(metalRateValue:Double){
        userDefaults.set(metalRateValue, forKey: "metalRateValue")
    }
    
    func getMetalRateValue() -> Double{
        return userDefaults.double(forKey: "metalRateValue") as? Double ?? 0.0
    }
    
    func setLabourChargesValue(labourChargesValue:Double){
        userDefaults.set(labourChargesValue, forKey: "labourChargesValue")
    }
    
    func getLabourChargesValueValue() -> Double{
        return userDefaults.double(forKey: "labourChargesValue") as? Double ?? 0.0
    }
    
    func setExtChargesValue(extCharges:Double){
        userDefaults.set(extCharges, forKey: "extCharges")
    }
    
    func getExtChargesValue() -> Double{
        return userDefaults.double(forKey: "extCharges") as? Double ?? 0.0
    }
    
    func setTaxValue(taxValue:Double){
        userDefaults.set(taxValue, forKey: "taxValue")
    }
    
    func getTaxValue() -> Double{
        return userDefaults.double(forKey: "taxValue") as? Double ?? 0.0
    }
    
    
    func set22KValue(ct24Value:Double){
        userDefaults.set(ct24Value, forKey: "ct22Value")
    }
    
    func get22KValue() -> Double?{
        return userDefaults.double(forKey: "ct22Value") as? Double ?? 0.0
    }
    
    func set18KValue(ct18Value:Double){
        userDefaults.set(ct18Value, forKey: "ct18Value")
    }
    
    func get18KValue() -> Double?{
        return userDefaults.double(forKey: "ct18Value") as? Double ?? 0.0
    }
    
    func set9KValue(ct9Value:Double){
        userDefaults.set(ct9Value, forKey: "ct9Value")
    }
    
    func get9KValue() -> Double?{
        return userDefaults.double(forKey: "ct9Value") as? Double ?? 0.0
    }
    
    func set14KValue(ct14Value:Double){
        userDefaults.set(ct14Value, forKey: "ct14Value")
    }
    
    func get14KValue() -> Double?{
        return userDefaults.double(forKey: "ct14Value") as? Double ?? 0.0
    }
    
    
    
    
    // Save quotation data to UserDefaults
    func saveQuotationData(_ newQuotation: Quotationstruct) {
        var savedQuotations = getSavedQuotations()
        
        if let index = savedQuotations.firstIndex(where: { $0.productName == newQuotation.productName }) {
            savedQuotations[index] = newQuotation
        } else {
            savedQuotations.append(newQuotation)
            
            if savedQuotations.count > 10 {
                savedQuotations.removeFirst()
            }
        }
        
        if let encodedData = try? JSONEncoder().encode(savedQuotations) {
            UserDefaults.standard.set(encodedData, forKey: "savedQuotations")
        }
    }
    
    func getSavedQuotations() -> [Quotationstruct] {
        if let data = UserDefaults.standard.data(forKey: "savedQuotations"),
           let quotations = try? JSONDecoder().decode([Quotationstruct].self, from: data) {
            return quotations
        }
        return []
    }
    
}
