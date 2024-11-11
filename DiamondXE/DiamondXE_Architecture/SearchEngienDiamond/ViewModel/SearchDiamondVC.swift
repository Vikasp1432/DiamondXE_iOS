//
//  SearchDiamondVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/05/24.
//

import UIKit

class SearchDiamondVC: BaseViewController , ChildViewControllerProtocol {
    func didSendString(str: String) {
        strTitle = str
    }
    
    var delegate : BaseViewControllerDelegate?
    var strTitle : String?
    var dashboardVC = DashboardVC()

    
    @IBOutlet var shadowedView:InnerDropShadowView!
    @IBOutlet var shadowedBGView:UIView!
    
    @IBOutlet var tbleViewSearchDim:UITableView!
    @IBOutlet var txtSearchKeyword:UITextField!

    var searchAttributeStruct = SearchOptionDataStruct()
    var currencyRateDetailObj = CurrencyRateDetail()
    
    
    var isLux = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtSearchKeyword.delegate = self
//        
//        if let keyWord = DataManager.shared.keyWordSearch{
//            txtSearchKeyword.text = keyWord
//        }
        
        
        tbleViewSearchDim.register(UINib(nibName: SearchDiamondTVC.cellIdentifierSearchDiamondTVC, bundle: nil), forCellReuseIdentifier: SearchDiamondTVC.cellIdentifierSearchDiamondTVC)

//        shadowedBGView.addInnerOuterShadow()
        
        if let searchOptionData = UserDefaultManager().retrieveSearchFieldsData(){
            self.searchAttributeStruct = searchOptionData
        }
        else{
            self.getSearchAttriDataAPICalling()
        }
        
       // DataManager.shared.dictionaryOfSets.removeAll()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
  
    }
  
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Text field did end editing")
        
        DataManager.shared.keyWordSearch = textField.text ?? "".uppercased()
        
    }

       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           print("Text field text changed to: \(string)")
           return true
       }

    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Hide keyboard when 'return' key is pressed
           textField.resignFirstResponder()
        
        DataManager.shared.keyWordSearch = textField.text ?? "".uppercased()
        dashboardVC.searcItemhWithKeyWord()
        
        
           return true
       }
    
    // API Calling()
    func getSearchAttriDataAPICalling(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)

        let url = APIs().get_SearchAttribute_API
        SearchOptionModel().getSeachAttributes(url: url, completion: { searchAttri , message in
           // print(homeData)
            if searchAttri.status == 1{
                self.searchAttributeStruct = searchAttri
                
                UserDefaultManager().saveSearchFieldsData(topDelsObj: searchAttri)
                
                self.tbleViewSearchDim.reloadData()
            }
            
            else{
                self.toastMessage(message ?? "")
            }
            CustomActivityIndicator2.shared.hide()
        })
        
    }
    

   
}

extension SearchDiamondVC : SearchOptionSelecteDelegate {
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
        case "Color":
            DataManager.shared.dictionaryOfSets.removeValue(forKey: "Color")
            DataManager.shared.addAttribute(toKey: searchTitle, element: filterAtribut)
        case "Color-Fancy":
            DataManager.shared.dictionaryOfSets.removeValue(forKey: "Color-Fancy")
            DataManager.shared.addAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "Clarity":
            DataManager.shared.dictionaryOfSets.removeValue(forKey: "Clarity")
            DataManager.shared.addAttribute(toKey: searchTitle, element: filterAtribut)
        case "Certificate":
            DataManager.shared.dictionaryOfSets.removeValue(forKey: "Certificate")
            DataManager.shared.addAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "Fluorescence":
            DataManager.shared.dictionaryOfSets.removeValue(forKey: "Fluorescence")
            DataManager.shared.addAttribute(toKey: searchTitle, element: filterAtribut)
        case "Make":
            DataManager.shared.dictionaryOfSets.removeValue(forKey: "Make")
            DataManager.shared.addAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "PriceFrom":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "PriceFrom")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
            
        case "PriceTo":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "PriceTo")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "CaratFrom":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "CaratFrom")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "CaratTo":
            DataManager.shared.manualFilterDictionaryOfSets.removeValue(forKey: "CaratTo")
            DataManager.shared.addManualFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "Shape":
            if shapeArr.count > 0{
                DataManager.shared.shapeArr.removeAll()
                DataManager.shared.shapeArr = shapeArr
            }
            else{
                DataManager.shared.defaultSelectedIndicesShaps.removeAll()
                DataManager.shared.shapeArr.removeAll()
            }
            
        default:
            print(searchTitle)
        }
        
        
    }
    
    
}

extension SearchDiamondVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchDiamondTVC.cellIdentifierSearchDiamondTVC, for: indexPath) as! SearchDiamondTVC
        cell.delegate = self
        cell.isLux = self.isLux
        if self.isLux == 1{
            cell.btnLabGrownDia.setGradientLayer(colorsInOrder:  [UIColor.borderClr.cgColor, UIColor.borderClr.cgColor])
            cell.btnLabGrownDia.setTitleColor(.whitClr, for: .normal)
            cell.btnLabGrownDia.isUserInteractionEnabled = false
        }
        else{
            cell.btnLabGrownDia.isUserInteractionEnabled = true
            cell.btnLabGrownDia.clearGradient()
           // cell.btnLabGrownDia.isHidden = false
        }
        cell.clearAll = {
            self.dashboardVC.txtSearchKeyword.text = ""
            DataManager.shared.keyWordSearch = ""
        }
        if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
            //let currncyVal = self.currencyRateDetailObj.value ?? 1
            cell.lblFrom.text = "\(currncySimbol)\(" ")\("From")"
            cell.lblTOO.text = "\(currncySimbol)\(" ")\("To")"
                    
        }
        else{
            cell.lblFrom.text = "₹\(" ")From"
            cell.lblTOO.text = "₹\(" ")To"
          
        }
        
        
        cell.setGradientBtn(string: self.strTitle ?? "")
        cell.filterDataStruct(searchAttributeStruct: self.searchAttributeStruct)
        cell.btnActionAdvanceFilter = { selectedMake in
            self.navigationManager(AdvanceFilterVC.self, storyboardName: "SearchDiamond", storyboardID: "AdvanceFilterVC", data1: self.searchAttributeStruct,data2: selectedMake)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1200
    }
    
}
