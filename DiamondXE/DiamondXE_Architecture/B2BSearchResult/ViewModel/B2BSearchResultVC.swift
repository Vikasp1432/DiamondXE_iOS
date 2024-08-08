//
//  B2BSearchResultVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/06/24.
//

import UIKit
import UIView_Shimmer
import SDWebImage
import DropDown


class B2BSearchResultVC: BaseViewController, ChildViewControllerProtocol {
    
    func didSendString(str: String) {
        print(str)
    }
    
    private var isLoading = true {
        didSet {
            tableViewList.isUserInteractionEnabled = !isLoading
            tableViewList.reloadData()
        }
    }
    
    var delegate : BaseViewControllerDelegate? 
    var delegateDiamond: B2BSearchResultVCDelegate?
    var dashboardVC: DashboardVC?

    
    @IBOutlet var filterCollectionView:UICollectionView!
    @IBOutlet var tableViewList:UITableView!
    @IBOutlet var btnHideShowFilter:UIButton!
    
    @IBOutlet var btnNatural:UIButton!
    @IBOutlet var btnLabGrown:UIButton!
    @IBOutlet var btnListing:UIButton!
    @IBOutlet var btnCardListing:UIButton!
    @IBOutlet var btnSorting:UIButton!
    @IBOutlet var dataNotFound:UIImageView!

    var ishideFilters = false
    
    var isDataListingView = false
    
    var filtersarryData = [SearchAttribDetail]()
    var diamondListResult = DiamondSearchDataStructB2B()
    var allDiamondListDetails = [DiamondListingDetail]()
    var diamondListDetails = [DiamondListingDetail]()
    var sessionID = String()
    var limit  = 15
    var page = 1
    var isLuxe = 0
    var filterDataDic = [String: Set<[FilterAttribDetail]>]()
    var advanceFilterDataDic = [String: Set<[FilterAttribDetail]>]()
    var manualfilterDataDic = [String: Set<[FilterAttribDetail]>]()
    
    
    var titleArr = [String]()
    var colorArr = [String]()
    var colorFancyArr = [String]()
    var clarityArr = [String]()
    var certificateArr = [String]()
    var fluoreseArr = [String]()
    var makeArr = [String]()
    let dropDown = DropDown()
    var cutArr = [String]()
    var polishFancyArr = [String]()
    var symmetryArr = [String]()
    var techeArr = [String]()
    var fancyclrIntensityArr = [String]()
    var fancyclrOvertoneArr = [String]()
    var tableFromArr = [String]()
    var tableToArr = [String]()
    var depthFromArr = [String]()
    var depthToArr = [String]()
    var lengthFromArr = [String]()
    var lengthToArr = [String]()
    var widthFromArr = [String]()
    var widthToArr = [String]()
    var depthMMFromArr = [String]()
    var depthMMToArr = [String]()
    var crownFromArr = [String]()
    var crownToArr = [String]()
    var pavllionFromArr = [String]()
    var pavllionToArr = [String]()
    var lotID = [String]()
    var location = [String]()
    var eyeClean = [String]()
    var shade = [String]()
    var luster = [String]()
    
    var caratFrom = Double()
    var caratTo = Double()
    var priceFrom = Int()
    var priceTo = Int()
    
    var selectedIndex = 1
   
    var param: [String: Any] = [:]
    var currencyRateDetailObj = CurrencyRateDetail()
    
    var loginData = UserDefaultManager.shareInstence.retrieveLoginData()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyRatesManager.shareInstence.getCurrencyRates()
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        filterCollectionView.register(UINib(nibName: FilterAppliedCVC.cellIdentifierFilterApplied, bundle: nil), forCellWithReuseIdentifier: FilterAppliedCVC.cellIdentifierFilterApplied)
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.showsVerticalScrollIndicator = false
        
//        btnNatural.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//        btnNatural.setTitleColor(.whitClr, for: .normal)
//        btnLabGrown.clearGradient()
//        btnLabGrown.setTitleColor(.themeClr, for: .normal)
        
        self.tableViewList.delegate = self
        self.tableViewList.dataSource = self
        
        tableViewList.register(UINib(nibName: B2BSearchResultListingTVC.cellIdentifierListingB2B, bundle: nil), forCellReuseIdentifier: B2BSearchResultListingTVC.cellIdentifierListingB2B)
        
        tableViewList.register(UINib(nibName: B2BSearchResultCardListingTVC.cellIdentifierCardListingB2B, bundle: nil), forCellReuseIdentifier: B2BSearchResultCardListingTVC.cellIdentifierCardListingB2B)
        
        tableViewList.register(UINib(nibName: B2CSearchResultTableListingCell.cellIdentifierTableListingB2C, bundle: nil), forCellReuseIdentifier: B2CSearchResultTableListingCell.cellIdentifierTableListingB2C)
        
        tableViewList.register(UINib(nibName: B2CSearchResultCardListingCell.cellIdentifierCardListingB2C, bundle: nil), forCellReuseIdentifier: B2CSearchResultCardListingCell.cellIdentifierCardListingB2C)
       
//        filterDataRetrive()
        self.btnSelected()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        diamondListDetails.removeAll()
        filterDataRetrive()
    }
    
    func btnSelected(){
       var btnSelected =  DataManager.shared.diaType
        if btnSelected == "natural"{
            btnNatural.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNatural.setTitleColor(.whitClr, for: .normal)
            btnLabGrown.clearGradient()
            btnLabGrown.setTitleColor(.themeClr, for: .normal)
        }
        else{
            btnLabGrown.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnLabGrown.setTitleColor(.whitClr, for: .normal)
            btnNatural.clearGradient()
            btnNatural.setTitleColor(.themeClr, for: .normal)
        }
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.isLoading = false
//        }
//    }
    
    @IBAction func btnActionSorting(_ sender : UIButton){
        let dataArr = ["Recently Added", "Price(Low to High)", "Price(High to Low)", "Size(Low to High)", "Size(High to Low)"]
        openDropDown(dataArr: dataArr, anchorView: self.btnSorting)
       }
    
    func updateCurreny(currncyOBJ:CurrencyRateDetail){
        currencyRateDetailObj = currncyOBJ
        print(currncyOBJ)
        
       if self.diamondListDetails.count > 0 {
            self.tableViewList.reloadData()
        }
    }
    
    
    func openDropDown(dataArr:[String], anchorView:UIView){
        dropDown.anchorView = anchorView
        dropDown.dataSource = dataArr
        dropDown.backgroundColor = UIColor.whitClr
        dropDown.selectionBackgroundColor = UIColor.themeClr.withAlphaComponent(0.2)
        dropDown.shadowColor = UIColor(white: 0.6, alpha: 1)
        dropDown.shadowOpacity = 0.7
        dropDown.shadowRadius = 15
        dropDown.cellHeight = 40
        dropDown.height = 250
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectRow(at: selectedIndex)
       

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectedIndex = index
            switch index {
            case 0:
                DataManager.shared.sortingBy = "RecentlyAdd"
            case 1:
                DataManager.shared.sortingBy = "PriceLow"
            case 2:
                DataManager.shared.sortingBy = "PriceHigh"
            case 3:
                DataManager.shared.sortingBy = "SizeHigh"
            case 4:
                DataManager.shared.sortingBy = "SizeLow"
            default:
                print("Selected item: \(item) at index: \(index)")
            }
            self.page = 1
            self.diamondListResult = DiamondSearchDataStructB2B()
            diamondListDetails.removeAll()
            self.setParamAndAPICalling()
            dropDown.hide()
            //(PriceHigh,PriceLow,DiscountHigh,RecentlyAdd,SizeHigh,SizeLow)
        }
        dropDown.show()
    }

    
    
    
    func filterDataRetrive(){
        let shape = DataManager.shared.shapeArr
       // print(shape)
        
        shape.forEach { value in
            titleArr.append(value)
        }
        
        filterDataDic = DataManager.shared.dictionaryOfSets
        advanceFilterDataDic = DataManager.shared.advanceFilterDictionaryOfSets
        manualfilterDataDic = DataManager.shared.manualFilterDictionaryOfSets

        filterDataDic.forEach { key, valueSet in
            valueSet.enumerated().forEach { (index, array) in
                array.forEach { detail in
                    if let attribCode = detail.attribCode {
                        titleArr.append("\(key):\(attribCode)")
                        switch key {
                        case "Color":
                            self.colorArr.append(attribCode)
                        case "Color-Fancy":
                            self.colorFancyArr.append(attribCode)
                        case "Clarity":
                            self.clarityArr.append(attribCode)
                        case "Certificate":
                            self.certificateArr.append(attribCode)
                        case "Fluorescence":
                            self.fluoreseArr.append(attribCode)
                        case "Make":
                            self.makeArr.append(attribCode)
                        default:
                            print(key)
                        }
                    }
                }
            }
        }
        
        
        if advanceFilterDataDic.count > 0{
            advanceFilterDataDic.forEach { key, valueSet in
                valueSet.enumerated().forEach { (index, array) in
                    array.forEach { detail in
                        if let attribCode = detail.attribCode {
                            titleArr.append("\(key):\(attribCode)")
                            
                            switch key {
                            case "Cut":
                                self.cutArr.append(attribCode)
                            case "Polish":
                                self.polishFancyArr.append(attribCode)
                            case "Symmetry":
                                self.symmetryArr.append(attribCode)
                            case "Technology":
                                self.techeArr.append(attribCode)
                            case "FCIntencity":
                                self.fancyclrIntensityArr.append(attribCode)
                            case "FCOvertone":
                                self.fancyclrOvertoneArr.append(attribCode)
                            case "TabplePerFrom":
                                self.tableFromArr.append(attribCode)
                            case "TablePerTo":
                                self.tableToArr.append(attribCode)
                            case "DepthPerFrom":
                                self.depthFromArr.append(attribCode)
                            case "DepthPerTo":
                                self.depthToArr.append(attribCode)
                            case "CrownFrom":
                                self.crownFromArr.append(attribCode)
                            case "CrownTo":
                                self.crownToArr.append(attribCode)
                            case "PavllionFrom":
                                self.pavllionFromArr.append(attribCode)
                            case "PavllionTo":
                                self.pavllionToArr.append(attribCode)
                            case "EyeClean":
                                self.eyeClean.append(attribCode)
                            case "Shade":
                                self.shade.append(attribCode)
                            case "Luster":
                                self.luster.append(attribCode)
                            case "LengthFrom":
                                self.lengthFromArr.append(attribCode)
                            case "LengthTo":
                                self.lengthToArr.append(attribCode)
                            case "WidthFrom":
                                self.widthFromArr.append(attribCode)
                            case "WidthTo":
                                self.widthToArr.append(attribCode)
                            case "DepthFrom":
                                self.depthMMFromArr.append(attribCode)
                            case "DepthTo":
                                self.depthMMToArr.append(attribCode)
                            case "LotID":
                                self.lotID.append(attribCode)
                            case "Location":
                                self.location.append(attribCode)
                            
                            default:
                                print(key)
                            }
                            
                        }
                    }
                }
            }
            
        }
        if manualfilterDataDic.count > 0{
            manualfilterDataDic.forEach { key, valueSet in
                valueSet.enumerated().forEach { (index, array) in
                    array.forEach { detail in
                        if let attribCode = detail.displayAttr {
                            titleArr.append("\(key):\(attribCode)")
                            print(attribCode)
                            switch key {
                            case "PriceFrom":
                                self.priceFrom = Int(attribCode) ?? 0
                            case "PriceTo":
                                self.priceTo = Int(attribCode) ?? 0
                            case "CaratFrom":
                                self.caratFrom = Double(attribCode) ?? 0
                            case "CaratTo":
                                self.caratTo = Double(attribCode) ?? 0
                           
                            default:
                                print(key)
                            }
                            
                        }
                    }
                }
            }
        }
        if DataManager.shared.keyWordSearch?.count ?? 0 > 0{
            titleArr.append("Keyword:\(DataManager.shared.keyWordSearch ?? "")")

        }
        
        
        if titleArr.count < 1{
            ishideFilters = true
            
            self.btnHideShowFilter.setImage(UIImage(named: "arrowDown"), for: .normal)
            filterCollectionView.isHidden = true
            
            
        }
        else{
            
            ishideFilters = false
            filterCollectionView.isHidden = false
            filterCollectionView.reloadData()
        }
        
        print( self.caratFrom, self.caratTo)
        self.setParamAndAPICalling()
           
    }
    
    @IBAction func btnActionFilter(_ sender:UIButton){
        ishideFilters.toggle()
        if ishideFilters{
            self.btnHideShowFilter.setImage(UIImage(named: "arrowDown"), for: .normal)
            filterCollectionView.isHidden = true
        }
        else{
            self.btnHideShowFilter.setImage(UIImage(named: "arrowUp"), for: .normal)
            filterCollectionView.isHidden = false
        }
    }
    
    @IBAction func btnActionDiamdType(_ sender:UIButton){
        switch sender.tag {
        case 0:
            btnNatural.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNatural.setTitleColor(.whitClr, for: .normal)
            btnLabGrown.clearGradient()
            btnLabGrown.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "natural"
            self.diamondListDetails.removeAll()
            self.setParamAndAPICalling()
        case 1:
            btnLabGrown.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnLabGrown.setTitleColor(.whitClr, for: .normal)
            btnNatural.clearGradient()
            btnNatural.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "labgrown"
            self.diamondListDetails.removeAll()
            self.setParamAndAPICalling()

        case 2:
            self.btnListing.tintColor = UIColor.tabSelectClr
            self.btnCardListing.tintColor = UIColor.clrGray
            self.isDataListingView = true
            tableViewList.reloadData()
        case 3:
            self.btnListing.tintColor = UIColor.clrGray
            self.btnCardListing.tintColor = UIColor.tabSelectClr
            self.isDataListingView = false
            tableViewList.reloadData()
        case 4:
            print("ddd")
        default:
            print(sender.tag)
        }
    }
    
    
    
    func setParamAndAPICalling(){
        self.sessionID = self.getSessionUniqID()
        
        var sortBy = ""
        if DataManager.shared.sortingBy == String()
        {
            sortBy = "PriceLow"
        }
        else{
            sortBy = DataManager.shared.sortingBy ?? "PriceLow"
        }
        
        
        param = ["page": page, "limit": limit, "isLuxe":self.isLuxe, "sessionId" : self.sessionID,
                 
                 "keyWord":DataManager.shared.keyWordSearch ?? "",
                 "category":DataManager.shared.diaType ?? "",       //natural/labgrown
                 "shape":DataManager.shared.shapeArr.joined(separator: ","),
                 "colorType": DataManager.shared.color ?? "",           //white/fancy
                 "color":self.colorArr.joined(separator: ","),
                 "fancyColor":self.colorFancyArr.joined(separator: ","),
                 "fancyColorIntencity":self.fancyclrIntensityArr.joined(separator: ","),
                 "fancyColorOvertone":self.fancyclrOvertoneArr.joined(separator: ","),
                 "clarity":self.clarityArr.joined(separator: ","),
                 "lengthFrom":self.lengthFromArr.joined(separator: ","),
                 "lengthTo":self.lengthToArr.joined(separator: ","),
                 "widthFrom":self.widthFromArr.joined(separator: ","),
                 "widthTo":self.widthToArr.joined(separator: ","),
                 "depthFrom":self.depthMMFromArr.joined(separator: ","),
                 "depthTo":self.depthMMToArr.joined(separator: ","),
                 "lotId":self.lotID.joined(separator: ","),
                 "searchLocation":self.location.joined(separator: ","),
                 "certificate":self.certificateArr.joined(separator: ","),
                 "fluorescence":self.fluoreseArr.joined(separator: ","),
                 "cut":self.cutArr.joined(separator: ","),
                 "polish":self.polishFancyArr.joined(separator: ","),
                 "symmetry":self.symmetryArr.joined(separator: ","),
                 "technology":self.techeArr.joined(separator: ","),
                 "eyeClean":self.eyeClean.joined(separator: ","),
                 "shade":self.shade.joined(separator: ","),
                 "luster":self.luster.joined(separator: ","),
                 "returnable":DataManager.shared.isReturnabl ?? Int(),                 // (0/1)
                 "caratFrom":self.caratFrom,
                 "caratTo":self.caratTo,
                 "priceFrom":self.priceFrom,
                 "priceTo":self.priceTo,
                 "currValue":"",                   //(By Default 1)
                 "tablePerFrom":self.tableFromArr.joined(separator: ","),
                 "tablePerTo":self.tableToArr.joined(separator: ","),
                 "depthPerFrom":depthFromArr.joined(separator: ","),
                 "depthPerTo":depthToArr.joined(separator: ","),
                 "crownFrom":self.crownFromArr.joined(separator: ","),
                 "crownTo":self.crownToArr.joined(separator: ","),
                 "pavillionFrom":self.pavllionFromArr.joined(separator: ","),
                 "pavillionTo":self.pavllionToArr.joined(separator: ","),
                 "sortBy":sortBy ]
        
        self.fetchDamondData(page: page, limit: limit, param: param)
        
    }
    
    
    func fetchDamondData(page: Int, limit: Int, param:[String:Any]) {
        
        isLoading = true
        let url = APIs().get_Diamond_API
        
       
        ModelGetDiamond().getDiamondsList(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.diamondListResult = data
                if let listDetials = self.diamondListResult.details{
                    self.diamondListDetails.append(contentsOf: listDetials)
                    if self.diamondListResult.details?.count ?? 0 > 0{
                        self.tableViewList.isHidden = false
                        self.dataNotFound.isHidden = true
                        self.tableViewList.reloadData()
                        self.isLoading = false
                    }
                    else{
                        self.tableViewList.isHidden = true
                        self.dataNotFound.isHidden = false

                    }
                    
                }
//                print(self.diamondListDetails)
               if self.diamondListResult.details?.count ?? 0 > 14 {
                    self.page += 1
                }
                
                
                
            }
            else{
                self.toastMessage(msg ?? "")
                self.isLoading = false
            }
            
        })
        
      }
    
    func addToCart(certificateNo:String, indexPath:IndexPath){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let deviceID = getSessionUniqID()
        let url = APIs().addtoCart_API
       let param = ["certificateNo":certificateNo,
                     "sessionId":deviceID]
        ModelGetDiamond().addToWishCart(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
//                self.isDataListingView
                self.diamondListDetails[indexPath.row].isCart = 1
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2BSearchResultCardListingTVC {
                    cell.btnCard.setTitleColor(.themeClr, for: .normal)
                    cell.btnCard.setTitle("Go to cart", for: .normal)
                    cartVCIsComeFromHome = false
                }
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2BSearchResultListingTVC {
                    cell.btnCard.setImage(UIImage(named: "cartFilled"), for: .normal)
                    
                }
                
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2CSearchResultTableListingCell {
                    cell.btnCard.setImage(UIImage(named: "cartFilled"), for: .normal)
                    
                }
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2CSearchResultCardListingCell {
                    cell.btnCard.setTitleColor(.themeClr, for: .normal)
                   // cell.btnCard.setTitle("", for: .normal)
                    cartVCIsComeFromHome = false
                }
                
                
            }
            else{
               print("ddd")
            }
            CustomActivityIndicator2.shared.hide()
        })
    }
    
    func addToWishList(certificateNo:String, indexPath:IndexPath){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let deviceID = getSessionUniqID()
        let url = APIs().addtoWishlist_API
       let param = ["certificateNo":certificateNo,
                     "sessionId":deviceID]
        ModelGetDiamond().addToWishCart(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
//                self.isDataListingView
                self.diamondListDetails[indexPath.row].isWishlist = 1
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2BSearchResultCardListingTVC {
                    cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                    
                }
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2BSearchResultListingTVC {
                    cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                    
                }
                
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2CSearchResultTableListingCell {
                    cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                    
                }
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2CSearchResultCardListingCell {
                    cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                }
                
                
            }
            else{
               print("ddd")
            }
            CustomActivityIndicator2.shared.hide()
        })
    }
    
    // remove Wishlist
    func removeToWishList(certificateNo:String, indexPath:IndexPath){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let deviceID = getSessionUniqID()
        let url = APIs().removetoWishlist_API
       let param = ["certificateNo":certificateNo,
                     "sessionId":deviceID]
        ModelGetDiamond().addToWishCart(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
//                self.isDataListingView
                self.diamondListDetails[indexPath.row].isWishlist = 0
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2BSearchResultCardListingTVC {
                    cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                    
                }
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2BSearchResultListingTVC {
                    cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                }
                
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2CSearchResultTableListingCell {
                    cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                    
                }
                
                if let cell = self.tableViewList.cellForRow(at: indexPath) as? B2CSearchResultCardListingCell {
                    cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                }
                
                
                
                
            }
            else{
               print("ddd")
            }
            CustomActivityIndicator2.shared.hide()
        })
    }
    
    
    func removeItemFromFilter(indexPth:IndexPath){
       
        let string = titleArr[indexPth.row]
        let components = string.components(separatedBy: ":")

        print(self.colorArr)
        switch components[0] {
        case "Color":
            self.colorArr.removeAll { $0 == components[1] }
            print(self.colorArr)
        case "Color-Fancy":
            self.colorFancyArr.removeAll { $0 == components[1] }
        case "Clarity":
            self.clarityArr.removeAll { $0 == components[1] }

        case "Certificate":
            self.certificateArr.removeAll { $0 == components[1] }

        case "Fluorescence":
            self.fluoreseArr.removeAll { $0 == components[1] }

        case "Make":
            self.makeArr.removeAll { $0 == components[1] }
            
        case "PriceFrom":
            self.priceFrom =  0
        case "PriceTo":
            self.priceTo =  0
        case "CaratFrom":
            self.caratFrom = Double()
        case "CaratTo":
            self.caratTo =  Double()
            
        case "Cut":
            self.cutArr.removeAll { $0 == components[1] }
        case "Polish":
            self.polishFancyArr.removeAll { $0 == components[1] }
        case "Symmetry":
            self.symmetryArr.removeAll { $0 == components[1] }
        case "Technology":
            self.techeArr.removeAll { $0 == components[1] }
        case "FCIntencity":
            self.fancyclrIntensityArr.removeAll { $0 == components[1] }
        case "FCOvertone":
            self.fancyclrOvertoneArr.removeAll { $0 == components[1] }
        case "TabplePerFrom":
            self.tableFromArr.removeAll { $0 == components[1] }
        case "TablePerTo":
            self.tableToArr.removeAll { $0 == components[1] }
        case "DepthPerFrom":
            self.depthFromArr.removeAll { $0 == components[1] }
        case "DepthPerTo":
            self.depthToArr.removeAll { $0 == components[1] }
        case "CrownFrom":
            self.crownFromArr.removeAll { $0 == components[1] }
        case "CrownTo":
            self.crownToArr.removeAll { $0 == components[1] }
        case "PavllionFrom":
            self.pavllionFromArr.removeAll { $0 == components[1] }
        case "PavllionTo":
            self.pavllionToArr.removeAll { $0 == components[1] }
        case "EyeClean":
            self.eyeClean.removeAll { $0 == components[1] }
        case "Shade":
            self.shade.removeAll { $0 == components[1] }
        case "Luster":
            self.luster.removeAll { $0 == components[1] }
        case "LengthFrom":
            self.lengthFromArr.removeAll { $0 == components[1] }
        case "LengthTo":
            self.lengthToArr.removeAll { $0 == components[1] }
        case "WidthFrom":
            self.widthFromArr.removeAll { $0 == components[1] }
        case "WidthTo":
            self.widthToArr.removeAll { $0 == components[1] }
        case "DepthFrom":
            self.depthMMFromArr.removeAll { $0 == components[1] }
        case "DepthTo":
            self.depthMMToArr.removeAll { $0 == components[1] }
        case "LotID":
            self.lotID.removeAll { $0 == components[1] }
        case "Location":
            self.location.removeAll { $0 == components[1] }
        
        default:
            print("key")
           

        }
        self.setParamAndAPICalling()
        titleArr.remove(at: indexPth.row)
        filterCollectionView.reloadData()
        
    }
    

}


extension B2BSearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterAppliedCVC.cellIdentifierFilterApplied, for: indexPath) as! FilterAppliedCVC
        cell.lblTitle.text = titleArr[indexPath.row]
        cell.btnAction = {
            self.removeItemFromFilter(indexPth: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 6 //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        let width = widthForText(self.titleArr[indexPath.item])
//        print(width)
        
        return CGSize(width: size + Int(width) , height: size - 18)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0) // Adjust the left padding
    }
    
    func widthForText(_ text: String) -> CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
        let width = (text as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [:], context: nil).width
        return width + 5
    }
}


extension B2BSearchResultVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if diamondListDetails.count < 1{
            if isLoading{
                return 15
            }
            else{
                self.dataNotFound.isHidden = false
                return 0
            }
            
        }
        else{
            return diamondListDetails.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.loginData?.details?.userRole == "BUYER"{
            if isDataListingView{
                let cell = tableView.dequeueReusableCell(withIdentifier: B2CSearchResultTableListingCell.cellIdentifierTableListingB2C, for: indexPath) as! B2CSearchResultTableListingCell
                cell.selectionStyle = .default
                cell.contentView.isUserInteractionEnabled = true
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
                
                
                
                cell.addToCart = {
                    if let isCart = self.diamondListDetails[indexPath.row].isCart{
                        if isCart == 0 {
                            self.addToCart(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                        }
                        else{
                            cartVCIsComeFromHome = false
                            self.navigationManager(storybordName: "AddTOCart", storyboardID: "AddToCartVC", controller: AddToCartVC())
                        }
                    }
                    
                }
                cell.addToWish = {
                    
                    if let isCart = self.diamondListDetails[indexPath.row].isWishlist{
                        if isCart == 0 {
                            self.addToWishList(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                        }
                        else{
                            self.removeToWishList(certificateNo: self.diamondListDetails[indexPath.row].stockNO ?? "", indexPath: indexPath)
                        }
                    }
                    
                    
                }
                
                
                
                if diamondListDetails.count > 0{
                    
                    if  self.diamondListDetails[indexPath.row].category == "Natural"{
                        cell.tagViewBG.backgroundColor = .themeGoldenClr
                        cell.lblTAG.text =  "NATURAL"
                    }
                    else if  self.diamondListDetails[indexPath.row].category == "Lab Grown"{
                        cell.tagViewBG.backgroundColor = .green2
                        cell.lblTAG.text =  "LAB"
                    }
                    
                    if let isCart = self.diamondListDetails[indexPath.row].isCart{
                        if isCart == 0 {
                            cell.btnCard.setTitle("Add to cart", for: .normal)
                        }
                        else{
                            cell.btnCard.setTitle("Go to cart", for: .normal)
                        }
                    }
                    
                    if let isWish = self.diamondListDetails[indexPath.row].isWishlist{
                        if isWish == 0 {
                            cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                        }
                        else{
                            cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                        }
                    }
                    
                    cell.lblCirtificateNum.text = self.diamondListDetails[indexPath.row].stockNO
                    cell.lblLotID.text = "ID: \(self.diamondListDetails[indexPath.row].supplierID ?? "")"
                    cell.lblShape.text = self.diamondListDetails[indexPath.row].shape
                    cell.lblCarat.text = "\(self.diamondListDetails[indexPath.row].carat ?? "")Ct"
                    cell.lblClor.text = self.diamondListDetails[indexPath.row].color
                    cell.lblClarity.text = self.diamondListDetails[indexPath.row].clarity
                   // cell.lblCarat.text = self.diamondListDetails[indexPath.row].carat
                    
                    if let availibility = self.diamondListDetails[indexPath.row].status{
                        if availibility == "On Hold"{
                            cell.btnAvailable.setImage(UIImage(named: "onHold"), for: .normal)
                        }
                        else if  availibility == "Available"{
                            cell.btnAvailable.setImage(UIImage(named: "available"), for: .normal)
                        }
                        else{
                            cell.btnAvailable.isHidden = true
                        }
                    }
                    else{
                        cell.btnAvailable.isHidden = true
                    }
                    
//                    let cutVal = self.diamondListDetails[indexPath.row].cutGrade
//                    if cutVal?.isEmptyStr ?? true || cutVal == "-"{
//                        cell.viewCut.isHidden = true
//                    }
//                    else{
//                        cell.lblCut.text = cutVal
//                    }
                    
//                    let polishVal = self.diamondListDetails[indexPath.row].polish
//                    if polishVal?.isEmptyStr ?? true || polishVal == "-"{
//                        cell.viewPolish.isHidden = true
//                    }
//                    else{
//                        cell.lblPolish.text = polishVal
//                    }
                    
//                    let symmetryVal = self.diamondListDetails[indexPath.row].symmetry
//                    if symmetryVal?.isEmptyStr ?? true || symmetryVal == "-"{
//                        cell.viewSymmetry.isHidden = true
//                    }
//                    else{
//                        cell.lblSymmetry.text = symmetryVal
//                    }
                    
//                    let flouroVal = self.diamondListDetails[indexPath.row].fluorescenceIntensity
//                    if flouroVal?.isEmptyStr ?? true || flouroVal == "-"{
//                        cell.viewFlouro.isHidden = true
//                    }
//                    else{
//                        cell.lblFlouro.text = flouroVal
//                    }
                    
//                    let certificateVal = self.diamondListDetails[indexPath.row].certificateName
//                    if certificateVal?.isEmptyStr ?? true || certificateVal == "-"{
//                        cell.viewCertificate.isHidden = true
//                    }
//                    else{
//                        cell.lblCertificate.text = certificateVal
//                    }
//                    
//                    
//                    let discountVal = self.diamondListDetails[indexPath.row].rDiscount
//                    if discountVal?.isEmptyStr ?? true || discountVal == "-"{
//                        cell.viewDiscount.isHidden = true
//                    }
//                    else{
//                        cell.lblDiscount.text = discountVal
//                    }
                    
//                    cell.lblTablePer.text = "T: \(self.diamondListDetails[indexPath.row].tablePerc ?? "")"
//                    cell.lblDepPer.text = "D: \(self.diamondListDetails[indexPath.row].depthPerc ?? "")"
//                    cell.lblMasurments.text = "M: \(self.diamondListDetails[indexPath.row].measurement ?? "")"
                    
                    if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                        let currncyVal = self.currencyRateDetailObj.value ?? 1
                        let finalVal = Double((self.diamondListDetails[indexPath.row].subtotal ?? 0)) * currncyVal
                        
                        let formattedNumber = formatNumberWithoutDeciml(finalVal)
                        
                        
                        cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
                        
                    }
                    else{
                        let formattedNumber = formatNumberWithoutDeciml(Double(self.diamondListDetails[indexPath.row].subtotal ?? 0))
                        cell.lblPrice.text = "₹\(formattedNumber)"
                    }
                    
                    cell.shapeClick = {
                        cell.shapeFullNameshow(name: self.diamondListDetails[indexPath.row].shape ?? "")
                    }
                    
                    
                    cell.diamondSelect = {
                        self.delegateDiamond?.didSelectDiamond(self.diamondListDetails[indexPath.row])
                    }
                    
                    cell.diamondSelect = {
                        self.dashboardVC?.currencySelectObj =  self.currencyRateDetailObj
                        self.dashboardVC?.diamondDetails = self.diamondListDetails[indexPath.row]
                        self.dashboardVC?.loadViewController(withIdentifier: "DiamondDetailsVC", fromStoryboard: "DiamondDetails")
                    }
                    
                    
                    
                }
                return cell
            }
            
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: B2CSearchResultCardListingCell.cellIdentifierCardListingB2C, for: indexPath) as! B2CSearchResultCardListingCell
                cell.selectionStyle = .default
                cell.contentView.isUserInteractionEnabled = true
               
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
                
               
                cell.addToCart = {
                    if let isCart = self.diamondListDetails[indexPath.row].isCart{
                        if isCart == 0 {
                            self.addToCart(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                        }
                        else{
                            cartVCIsComeFromHome = false
                            self.navigationManager(storybordName: "AddTOCart", storyboardID: "AddToCartVC", controller: AddToCartVC())
                        }
                    }
                    
                }
                cell.addToWish = {
                    
                    if let iswishList = self.diamondListDetails[indexPath.row].isWishlist{
                        if iswishList == 0 {
                            self.addToWishList(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                        }
                        else{
                            self.removeToWishList(certificateNo: self.diamondListDetails[indexPath.row].stockNO ?? "", indexPath: indexPath)
                        }
                    }
                    
                    
                }
                
                if diamondListDetails.count > 0{
                    if  self.diamondListDetails[indexPath.row].category == "Natural"{
                        cell.tagViewBG.backgroundColor = .themeGoldenClr
                        cell.lblTAG.text =  "NATURAL"
                    }
                    else if  self.diamondListDetails[indexPath.row].category == "Lab Grown"{
                        cell.tagViewBG.backgroundColor = .green2
                        cell.lblTAG.text =  "LAB"
                    }
                    
                    
                    if let isCart = self.diamondListDetails[indexPath.row].isCart{
                        if isCart == 0 {
                            cell.btnCard.setTitle("Add to cart", for: .normal)
                        }
                        else{
                            cell.btnCard.setTitle("Go to cart", for: .normal)
                        }
                    }
                    
                    if let isWish = self.diamondListDetails[indexPath.row].isWishlist{
                        if isWish == 0 {
                            cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                        }
                        else{
                            cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                        }
                    }
                    
                    cell.lblCirtificateNum.text = self.diamondListDetails[indexPath.row].stockNO
                    cell.lblLotID.text = "ID: \(self.diamondListDetails[indexPath.row].supplierID ?? "")"
                    cell.lblShape.text = self.diamondListDetails[indexPath.row].shape
                    cell.lblCarat.text = "Ct\(self.diamondListDetails[indexPath.row].carat ?? "")"
                    cell.lblClor.text = self.diamondListDetails[indexPath.row].color
                    cell.lblClarity.text = self.diamondListDetails[indexPath.row].clarity
                   // cell.lblCarat.text = self.diamondListDetails[indexPath.row].carat
                    
                    
                    if let availibility = self.diamondListDetails[indexPath.row].status{
                        if availibility == "On Hold"{
                            cell.btnAvailable.setImage(UIImage(named: "onHold"), for: .normal)
                        }
                        else if  availibility == "Available"{
                            cell.btnAvailable.setImage(UIImage(named: "available"), for: .normal)
                        }
                        else{
                            
                            cell.btnAvailable.isHidden = true
                        }
                    }
                    else{
                        cell.btnAvailable.isHidden = true
                    }
                    
//                    let cutVal = self.diamondListDetails[indexPath.row].cutGrade
//                    if cutVal?.isEmptyStr ?? true || cutVal == "-"{
//                        cell.viewCut.isHidden = true
//                    }
//                    else{
//                        cell.lblCut.text = cutVal
//                    }
                    
                    cell.shapeClick = {
                        cell.shapeFullNameshow(name: self.diamondListDetails[indexPath.row].shape ?? "")
                    }
                    
                    
//                    let polishVal = self.diamondListDetails[indexPath.row].polish
//                    if polishVal?.isEmptyStr ?? true || polishVal == "-"{
//                        cell.viewPolish.isHidden = true
//                    }
//                    else{
//                        cell.lblPolish.text = polishVal
//                    }
//                    
//                    let symmetryVal = self.diamondListDetails[indexPath.row].symmetry
//                    if symmetryVal?.isEmptyStr ?? true || symmetryVal == "-"{
//                        cell.viewSymmetry.isHidden = true
//                    }
//                    else{
//                        cell.lblSymmetry.text = symmetryVal
//                    }
//                    
//                    let flouroVal = self.diamondListDetails[indexPath.row].fluorescenceIntensity
//                    if flouroVal?.isEmptyStr ?? true || flouroVal == "-"{
//                        cell.viewFlouro.isHidden = true
//                    }
//                    else{
//                        cell.lblFlouro.text = flouroVal
//                    }
//                    
//                    let certificateVal = self.diamondListDetails[indexPath.row].certificateName
//                    if certificateVal?.isEmptyStr ?? true || certificateVal == "-"{
//                        cell.viewCertificate.isHidden = true
//                    }
//                    else{
//                        cell.lblCertificate.text = certificateVal
//                    }
//                    
//                    
//                    let discountVal = self.diamondListDetails[indexPath.row].rDiscount
//                    if discountVal?.isEmptyStr ?? true || discountVal == "-"{
//                        cell.viewDiscount.isHidden = true
//                    }
//                    else{
//                        cell.lblDiscount.text = discountVal
//                    }
//                    
//                    
//                    cell.lblTablePer.text = "T: \(self.diamondListDetails[indexPath.row].tablePerc ?? "")"
//                    cell.lblDepPer.text = "D: \(self.diamondListDetails[indexPath.row].depthPerc ?? "")"
//                    cell.lblMasurments.text = "M: \(self.diamondListDetails[indexPath.row].measurement ?? "")"
                    
                    if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                        let currncyVal = self.currencyRateDetailObj.value ?? 1
                        var finalVal = Double((self.diamondListDetails[indexPath.row].subtotal ?? 0)) * currncyVal
                        
                        let formattedNumber = formatNumberWithoutDeciml(finalVal)
                        cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
                        
                    }
                    else{
                        
                        let formattedNumber = formatNumberWithoutDeciml(Double(self.diamondListDetails[indexPath.row].subtotal ?? 0))
                        cell.lblPrice.text = "₹\(formattedNumber)"
                    }
                    
                    
                    cell.imgDiamond.sd_setImage(with: URL(string: self.diamondListDetails[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
                    
                    cell.diamondSelect = {
                        self.dashboardVC?.currencySelectObj =  self.currencyRateDetailObj
                        self.dashboardVC?.diamondDetails = self.diamondListDetails[indexPath.row]
                        self.dashboardVC?.loadViewController(withIdentifier: "DiamondDetailsVC", fromStoryboard: "DiamondDetails")
                    }
                    
                    
                }
                return cell
            }
        }
        else {
        
        if isDataListingView{
            let cell = tableView.dequeueReusableCell(withIdentifier: B2BSearchResultListingTVC.cellIdentifierListingB2B, for: indexPath) as! B2BSearchResultListingTVC
            cell.selectionStyle = .default
            cell.contentView.isUserInteractionEnabled = true
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
         
            
            cell.addToCart = {
                if let isCart = self.diamondListDetails[indexPath.row].isCart{
                    if isCart == 0 {
                        self.addToCart(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                    }
                    else{
                        cartVCIsComeFromHome = false
                        self.navigationManager(storybordName: "AddTOCart", storyboardID: "AddToCartVC", controller: AddToCartVC())
                    }
                }
                
            }
            cell.addToWish = {
                
                if let isCart = self.diamondListDetails[indexPath.row].isWishlist{
                    if isCart == 0 {
                        self.addToWishList(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                    }
                    else{
                        self.removeToWishList(certificateNo: self.diamondListDetails[indexPath.row].stockNO ?? "", indexPath: indexPath)
                    }
                }
                
                
            }
            
            
            
            if diamondListDetails.count > 0{
                
                
                if  self.diamondListDetails[indexPath.row].category == "Natural"{
                    cell.tagViewBG.backgroundColor = .themeGoldenClr
                    cell.lblTAG.text =  "NATURAL"
                }
                else if  self.diamondListDetails[indexPath.row].category == "Lab Grown"{
                    cell.tagViewBG.backgroundColor = .green2
                    cell.lblTAG.text =  "LAB"
                }
                
                
                
                if let isCart = self.diamondListDetails[indexPath.row].isCart{
                    if isCart == 0 {
                        cell.btnCard.setImage(UIImage(named: "cart_"), for: .normal)
                       // cell.btnCard.setTitle("Add to cart", for: .normal)
                    }
                    else{
                        cell.btnCard.setImage(UIImage(named: "cartFilled"), for: .normal)
                       //cell.btnCard.setTitle("Go to cart", for: .normal)
                    }
                }
                
                if let isWish = self.diamondListDetails[indexPath.row].isWishlist{
                    if isWish == 0 {
                        cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                    }
                    else{
                        cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                    }
                }
                
                cell.lblCirtificateNum.text = self.diamondListDetails[indexPath.row].stockNO
                cell.lblLotID.text = "ID: \(self.diamondListDetails[indexPath.row].supplierID ?? "")"
                cell.btnShape.text = self.diamondListDetails[indexPath.row].shape
                cell.lblCarat.text = "\(self.diamondListDetails[indexPath.row].carat ?? "")Ct"
                cell.lblClor.text = self.diamondListDetails[indexPath.row].color
                cell.lblClarity.text = self.diamondListDetails[indexPath.row].clarity
                //cell.lblCarat.text = self.diamondListDetails[indexPath.row].carat
                
                if let availibility = self.diamondListDetails[indexPath.row].status{
                    if availibility == "On Hold"{
                        cell.btnAvailable.setImage(UIImage(named: "onHold"), for: .normal)
                    }
                    else if  availibility == "Available"{
                        cell.btnAvailable.setImage(UIImage(named: "available"), for: .normal)
                    }
                    else{
                        cell.btnAvailable.isHidden = true
                    }
                }
                else{
                    cell.btnAvailable.isHidden = true
                }
                
                let cutVal = self.diamondListDetails[indexPath.row].cutGrade
                if cutVal?.isEmptyStr ?? true || cutVal == "-"{
                    cell.viewCut.isHidden = true
                }
                else{
                    cell.lblCut.text = cutVal
                }
                
                let polishVal = self.diamondListDetails[indexPath.row].polish
                if polishVal?.isEmptyStr ?? true || polishVal == "-"{
                    cell.viewPolish.isHidden = true
                }
                else{
                    cell.lblPolish.text = polishVal
                }
                
                let symmetryVal = self.diamondListDetails[indexPath.row].symmetry
                if symmetryVal?.isEmptyStr ?? true || symmetryVal == "-"{
                    cell.viewSymmetry.isHidden = true
                }
                else{
                    cell.lblSymmetry.text = symmetryVal
                }
                
                let flouroVal = self.diamondListDetails[indexPath.row].fluorescenceIntensity
                if flouroVal?.isEmptyStr ?? true || flouroVal == "-"{
                    cell.viewFlouro.isHidden = true
                }
                else{
                    cell.lblFlouro.text = flouroVal
                }
                
                let certificateVal = self.diamondListDetails[indexPath.row].certificateName
                if certificateVal?.isEmptyStr ?? true || certificateVal == "-"{
                    cell.viewCertificate.isHidden = true
                }
                else{
                    cell.lblCertificate.text = certificateVal
                }
                
                
                let discountVal = self.diamondListDetails[indexPath.row].rDiscount
                if discountVal?.isEmptyStr ?? true || discountVal == "-"{
                    cell.viewDiscount.isHidden = true
                }
                else{
                    cell.lblDiscount.text = discountVal
                }
                
                cell.lblTablePer.text = "T: \(self.diamondListDetails[indexPath.row].tablePerc ?? "")"
                cell.lblDepPer.text = "D: \(self.diamondListDetails[indexPath.row].depthPerc ?? "")"
                cell.lblMasurments.text = "M: \(self.diamondListDetails[indexPath.row].measurement ?? "")"
                
                if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                    let currncyVal = self.currencyRateDetailObj.value ?? 1
                    let finalVal = Double((self.diamondListDetails[indexPath.row].subtotal ?? 0)) * currncyVal
                    
                    let formattedNumber = formatNumberWithoutDeciml(finalVal)
                    
                    
                    cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
                    
                }
                else{
                    let formattedNumber = formatNumberWithoutDeciml(Double(self.diamondListDetails[indexPath.row].subtotal ?? 0))
                    cell.lblPrice.text = "₹\(formattedNumber)"
                }
                
                cell.shapeClick = {
                    cell.shapeFullNameshow(name: self.diamondListDetails[indexPath.row].shape ?? "")
                }
                
                
                cell.diamondSelect = {
                    self.delegateDiamond?.didSelectDiamond(self.diamondListDetails[indexPath.row])
                }
                
                cell.diamondSelect = {
                    self.dashboardVC?.currencySelectObj =  self.currencyRateDetailObj
                    self.dashboardVC?.diamondDetails = self.diamondListDetails[indexPath.row]
                    self.dashboardVC?.loadViewController(withIdentifier: "DiamondDetailsVC", fromStoryboard: "DiamondDetails")
                }
                
                
                
            }
            return cell
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: B2BSearchResultCardListingTVC.cellIdentifierCardListingB2B, for: indexPath) as! B2BSearchResultCardListingTVC
            cell.selectionStyle = .default
            cell.contentView.isUserInteractionEnabled = true
            
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
        
            cell.addToCart = {
                if let isCart = self.diamondListDetails[indexPath.row].isCart{
                    if isCart == 0 {
                        self.addToCart(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                    }
                    else{
                        cartVCIsComeFromHome = false
                        self.navigationManager(storybordName: "AddTOCart", storyboardID: "AddToCartVC", controller: AddToCartVC())
                    }
                }
                
            }
            cell.addToWish = {
                
                if let iswishList = self.diamondListDetails[indexPath.row].isWishlist{
                    if iswishList == 0 {
                        self.addToWishList(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                    }
                    else{
                        self.removeToWishList(certificateNo: self.diamondListDetails[indexPath.row].certificateNo ?? "", indexPath: indexPath)
                    }
                }
                
                
            }
            
            if diamondListDetails.count > 0{
                if let isCart = self.diamondListDetails[indexPath.row].isCart{
                    if isCart == 0 {
                        cell.btnCard.setTitle("Add to cart", for: .normal)
                    }
                    else{
                        cell.btnCard.setTitle("Go to cart", for: .normal)
                    }
                }
                
                if let isWish = self.diamondListDetails[indexPath.row].isWishlist{
                    if isWish == 0 {
                        cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                    }
                    else{
                        cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                    }
                }
                
                cell.lblCirtificateNum.text = self.diamondListDetails[indexPath.row].stockNO
                cell.lblLotID.text = "ID: \(self.diamondListDetails[indexPath.row].supplierID ?? "")"
                cell.btnShape.text = self.diamondListDetails[indexPath.row].shape
                cell.lblCarat.text = "Ct\(self.diamondListDetails[indexPath.row].carat ?? "")"
                cell.lblClor.text = self.diamondListDetails[indexPath.row].color
                cell.lblClarity.text = self.diamondListDetails[indexPath.row].clarity
                //cell.lblCarat.text = self.diamondListDetails[indexPath.row].carat
                
                
                if let availibility = self.diamondListDetails[indexPath.row].status{
                    if availibility == "On Hold"{
                        cell.btnAvailable.setImage(UIImage(named: "onHold"), for: .normal)
                    }
                    else if  availibility == "Available"{
                        cell.btnAvailable.setImage(UIImage(named: "available"), for: .normal)
                    }
                    else{
                        cell.btnAvailable.isHidden = true
                    }
                }
                else{
                    cell.btnAvailable.isHidden = true
                }
                
                let cutVal = self.diamondListDetails[indexPath.row].cutGrade
                if cutVal?.isEmptyStr ?? true || cutVal == "-"{
                    cell.viewCut.isHidden = true
                }
                else{
                    cell.lblCut.text = cutVal
                }
                
                cell.shapeClick = {
                    cell.shapeFullNameshow(name: self.diamondListDetails[indexPath.row].shape ?? "")
                }
                
                
                let polishVal = self.diamondListDetails[indexPath.row].polish
                if polishVal?.isEmptyStr ?? true || polishVal == "-"{
                    cell.viewPolish.isHidden = true
                }
                else{
                    cell.lblPolish.text = polishVal
                }
                
                let symmetryVal = self.diamondListDetails[indexPath.row].symmetry
                if symmetryVal?.isEmptyStr ?? true || symmetryVal == "-"{
                    cell.viewSymmetry.isHidden = true
                }
                else{
                    cell.lblSymmetry.text = symmetryVal
                }
                
                let flouroVal = self.diamondListDetails[indexPath.row].fluorescenceIntensity
                if flouroVal?.isEmptyStr ?? true || flouroVal == "-"{
                    cell.viewFlouro.isHidden = true
                }
                else{
                    cell.lblFlouro.text = flouroVal
                }
                
                let certificateVal = self.diamondListDetails[indexPath.row].certificateName
                if certificateVal?.isEmptyStr ?? true || certificateVal == "-"{
                    cell.viewCertificate.isHidden = true
                }
                else{
                    cell.lblCertificate.text = certificateVal
                }
                
                
                let discountVal = self.diamondListDetails[indexPath.row].rDiscount
                if discountVal?.isEmptyStr ?? true || discountVal == "-"{
                    cell.viewDiscount.isHidden = true
                }
                else{
                    cell.lblDiscount.text = discountVal
                }
                
                
                cell.lblTablePer.text = "T: \(self.diamondListDetails[indexPath.row].tablePerc ?? "")"
                cell.lblDepPer.text = "D: \(self.diamondListDetails[indexPath.row].depthPerc ?? "")"
                cell.lblMasurments.text = "M: \(self.diamondListDetails[indexPath.row].measurement ?? "")"
                
                if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                    let currncyVal = self.currencyRateDetailObj.value ?? 1
                    var finalVal = Double((self.diamondListDetails[indexPath.row].subtotal ?? 0)) * currncyVal
                    
                    let formattedNumber = formatNumberWithoutDeciml(finalVal)
                    cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
                    
                }
                else{
                    
                    let formattedNumber = formatNumberWithoutDeciml(Double(self.diamondListDetails[indexPath.row].subtotal ?? 0))
                    cell.lblPrice.text = "₹\(formattedNumber)"
                }
                
                
                cell.imgDiamond.sd_setImage(with: URL(string: self.diamondListDetails[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
                
                cell.diamondSelect = {
                    self.dashboardVC?.currencySelectObj =  self.currencyRateDetailObj
                    self.dashboardVC?.diamondDetails = self.diamondListDetails[indexPath.row]
                    self.dashboardVC?.loadViewController(withIdentifier: "DiamondDetailsVC", fromStoryboard: "DiamondDetails")
                }
                
                if  self.diamondListDetails[indexPath.row].category == "Natural"{
                    cell.tagViewBG.backgroundColor = .themeGoldenClr
                    cell.lblTAG.text =  "NATURAL"
                }
                else if  self.diamondListDetails[indexPath.row].category == "Lab Grown"{
                    cell.tagViewBG.backgroundColor = .green2
                    cell.lblTAG.text =  "LAB"
                }
                
               
            }
            return cell
        }
    }
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.diamondListDetails.count > 14{
            
            if indexPath.row == self.diamondListDetails.count - 1 && !isLoading {
                fetchDamondData(page: page, limit: limit, param: self.param)
            }
            
        }
    }
    
   
    
}
