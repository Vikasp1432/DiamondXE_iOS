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
    
    var defaultSelectedIndicesShaps: Set<IndexPath> = []
    var defaultSelectedIndicesColor: Set<IndexPath> = []
    var defaultSelectedIndicesClarity: Set<IndexPath> = []
    var defaultSelectedIndicesCertificate: Set<IndexPath> = []
    var defaultSelectedIndicesFluorescence: Set<IndexPath> = []
    var defaultSelectedIndicesMake: IndexPath?
    
    
    var defaultSelectedIndicesCut: Set<IndexPath> = []
    var defaultSelectedIndicesPolish: Set<IndexPath> = []
    var defaultSelectedIndicesSymmetry: Set<IndexPath> = []
    var defaultSelectedIndicesEyeClean: Set<IndexPath> = []
    var defaultSelectedIndicesShade: Set<IndexPath> = []
    var defaultSelectedIndicesLuster: Set<IndexPath> = []
    var defaultSelectedIndicesTech: Set<IndexPath> = []
    
    
    
    
    var defaultSelectedDataArrColorWhite = [SearchAttribDetail]()
    var defaultSelectedDataArrColorFancy = [SearchAttribDetail]()
    var defaultSelectedDataArrClarity = [SearchAttribDetail]()
    var defaultSelectedDataArrCertificate = [SearchAttribDetail]()
    var defaultSelectedDataArrFluorescence = [SearchAttribDetail]()
    var defaultSelectedDataArrMake = [SearchAttribDetail]()
    var defaultShapeArr = [String]()
    
    var txttPriceTo = String()
    var txtPriceFrom = String()
    var cartTo = String()
    var cartFrom = String()
    var btnTagSelect : Int? = -1
    //var isReturnable = Int()
    
    var textData = [SearchAttribDetail]()
    var diaQualityTap: [String]?
    
    
    var defaultSelectedShowColor : Bool?
    
    
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
