//
//  AdvanceFilterVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/06/24.
//

import UIKit

class AdvanceFilterVC: BaseViewController , DataReceiver2{
  
    
    var searchAttriStruct =  SearchOptionDataStruct()
    var selectedMakeData =  [SearchAttribDetail]()
    
    @IBOutlet var tableViewAdvanceFilter:UITableView!
    
    
    func receiveData(_ data: SearchOptionDataStruct) {
        // Use the received data here
        searchAttriStruct = data
    }
    
    func receiveData2(_ data: [SearchAttribDetail]) {
        selectedMakeData = data
    }
    
    
    @IBOutlet var headerView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewAdvanceFilter.register(UINib(nibName: AdvanceFilterTVC.cellIdentifierAdvanceFilTVC, bundle: nil), forCellReuseIdentifier: AdvanceFilterTVC.cellIdentifierAdvanceFilTVC)
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        switch sender.tag {
        case 1:
            print("clear")
        case 2:
            self.navigationController?.popViewController(animated: true)
        default:
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    

    
   


}

extension AdvanceFilterVC : SearchOptionSelecteDelegate {
    func didselectOption(searchTitle: String, details: [SearchAttribDetail], shapeArr: [String]) {
       
        var filterAtribut = [FilterAttribDetail]()
        details.enumerated().forEach { inxe , item in
            var filterArr = FilterAttribDetail()
            filterArr.attribCode = item.attribCode
            filterArr.attribType = item.attribType
            filterArr.attribID = item.attribID
            filterArr.attribTypeID = item.attribTypeID
            filterArr.displayAttr = item.displayAttr
            filterArr.sortOrder = item.sortOrder
            filterAtribut.append(filterArr)
        }
        
        switch searchTitle {
        case "Cut":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Cut")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "Polish":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Polish")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "Symmetry":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Symmetry")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "Technology":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Technology")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "FCIntencity":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "FCIntencity")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "FCOvertone":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "FCOvertone")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "TabplePerFrom":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "TabplePerFrom")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "TablePerTo":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "TablePerTo")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "DepthPerFrom":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "DepthPerFrom")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "DepthPerTo":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "DepthPerTo")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "CrownFrom":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "CrownFrom")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "CrownTo":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "CrownTo")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "PavllionFrom":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "PavllionFrom")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "PavllionTo":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "PavllionTo")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "EyeClean":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "EyeClean")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "Shade":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Shade")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "Luster":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Luster")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "LengthFrom":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "LengthFrom")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "LengthTo":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "LengthTo")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "WidthFrom":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "WidthFrom")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "WidthTo":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "WidthTo")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "DepthFrom":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "DepthFrom")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "DepthTo":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "DepthTo")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "LotID":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "LotID")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "Location":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "Location")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
            
        default:
           print(shapeArr)
        }
        
        //"Location "LotID "DepthTo "DepthFrom "WidthTo WidthFromLengthFrom"
    }
    
    
}

extension AdvanceFilterVC :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdvanceFilterTVC.cellIdentifierAdvanceFilTVC, for: indexPath) as! AdvanceFilterTVC
        cell.delegate = self
        cell.filterDataStruct(searchAttributeStruct: self.searchAttriStruct)
        cell.setupBtnLogicForDia(attributID: self.selectedMakeData.first?.attribID ?? 0)
//        cell.btnActionAdvanceFilter = { tag in
//            self.navigationManager(AdvanceFilterVC.self, storyboardName: "SearchDiamond", storyboardID: "AdvanceFilterVC", data: self.searchAttributeStruct)
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1360
    }
    
}
