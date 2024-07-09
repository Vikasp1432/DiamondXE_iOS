//
//  DataManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 18/06/24.
//

import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    var cartDataHolder : CartDataStruct?
    var WishlistDataHolder : WishlistDataStruct?
    
    
    var searchTitle: String? = ""
    var searchInfoDetails: [SearchAttribDetail] = []
    var shapeArr: [String] = []
    var diaType : String?
    var color : String?
    var isReturnabl : Int?
    
    var sortingBy : String?
    var curreny : String?
    
    var keyWordSearch : String?
    
    var dictionaryOfSets: [String: Set<[FilterAttribDetail]>] = [:]
    
    var advanceFilterDictionaryOfSets: [String: Set<[FilterAttribDetail]>] = [:]
    
    var manualFilterDictionaryOfSets: [String: Set<[FilterAttribDetail]>] = [:]

    
    var isrefundable: Bool? = false
    

    func addAttribute(toKey key: String, element: [FilterAttribDetail]) {
        if var existingSet = dictionaryOfSets[key] {
            if !existingSet.contains(element) {
                existingSet.insert(element)
                dictionaryOfSets[key] = existingSet
            }
        } else {
            dictionaryOfSets[key] = [element]
        }
    }
    
    func addAdvanceFIlterAttribute(toKey key: String, element: [FilterAttribDetail]) {
        if var existingSet = advanceFilterDictionaryOfSets[key] {
            if !existingSet.contains(element) {
                existingSet.insert(element)
                advanceFilterDictionaryOfSets[key] = existingSet
            }
        } else {
            advanceFilterDictionaryOfSets[key] = [element]
        }
    }
    
    func addManualFIlterAttribute(toKey key: String, element: [FilterAttribDetail]) {
        if var existingSet = manualFilterDictionaryOfSets[key] {
            if !existingSet.contains(element) {
                existingSet.insert(element)
                manualFilterDictionaryOfSets[key] = existingSet
            }
        } else {
            manualFilterDictionaryOfSets[key] = [element]
        }
    }


    
}
