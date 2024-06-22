//
//  B2BSearchResultVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/06/24.
//

import UIKit
import UIView_Shimmer
import SDWebImage


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
    
    var caratFrom = Int()
    var caratTo = Int()
    var priceFrom = Int()
    var priceTo = Int()
   
    var param: [String: Any] = [:]
    
//    var arryData = ["Color:E","Clarity:FL","Certicicate:GIA","Cerate:GIA"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        filterCollectionView.register(UINib(nibName: FilterAppliedCVC.cellIdentifierFilterApplied, bundle: nil), forCellWithReuseIdentifier: FilterAppliedCVC.cellIdentifierFilterApplied)
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.showsVerticalScrollIndicator = false
        
        btnNatural.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        btnNatural.setTitleColor(.whitClr, for: .normal)
        btnLabGrown.clearGradient()
        btnLabGrown.setTitleColor(.themeClr, for: .normal)
        
        self.tableViewList.delegate = self
        self.tableViewList.dataSource = self
        
        tableViewList.register(UINib(nibName: B2BSearchResultListingTVC.cellIdentifierListingB2B, bundle: nil), forCellReuseIdentifier: B2BSearchResultListingTVC.cellIdentifierListingB2B)
        
        tableViewList.register(UINib(nibName: B2BSearchResultCardListingTVC.cellIdentifierCardListingB2B, bundle: nil), forCellReuseIdentifier: B2BSearchResultCardListingTVC.cellIdentifierCardListingB2B)
       
        filterDataRetrive()
      
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.isLoading = false
//        }
//    }
    
    func filterDataRetrive(){
        let shape = DataManager.shared.shapeArr
        print(shape)
        
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
                            self.certificateArr.append(attribCode)
                        case "Make":
                            self.certificateArr.append(attribCode)
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
                        if let attribCode = detail.displayAttr {
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
                            
                            switch key {
                            case "PriceFrom":
                                self.priceFrom = Int(attribCode) ?? 0
                            case "PriceTo":
                                self.priceTo = Int(attribCode) ?? 0
                            case "CaratFrom":
                                self.caratFrom = Int(attribCode) ?? 0
                            case "CaratTo":
                                self.caratTo = Int(attribCode) ?? 0
                           
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
        
        self.setParam()
           
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
        case 1:
            btnLabGrown.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnLabGrown.setTitleColor(.whitClr, for: .normal)
            btnNatural.clearGradient()
            btnNatural.setTitleColor(.themeClr, for: .normal)
            
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
    
    
    
    func setParam(){
        self.sessionID = self.getSessionUniqID()
        
        
        param = ["page": page, "limit": limit, "isLuxe":self.isLuxe, "sessionId" : self.sessionID,
                 
                 "keyWord":DataManager.shared.keyWordSearch ?? "",
                 "category":DataManager.shared.diaType ?? "",       //natural/labgrown
                 "shape":DataManager.shared.shapeArr,
                 "colorType": DataManager.shared.color ?? "",           //white/fancy
                 "color":self.colorArr,
                 "fancyColor":self.colorFancyArr,
                 "fancyColorIntencity":self.fancyclrIntensityArr,
                 "fancyColorOvertone":self.fancyclrOvertoneArr,
                 "clarity":self.clarityArr,
                 "lengthFrom":self.lengthFromArr,
                 "lengthTo":self.lengthToArr,
                 "widthFrom":self.widthFromArr,
                 "widthTo":self.widthToArr,
                 "depthFrom":self.depthMMFromArr,
                 "depthTo":self.depthMMToArr,
                 "lotId":self.lotID,
                 "Location":self.location,
                 "certificate":"",
                 "fluorescence":self.fluoreseArr,
                 "cut":self.cutArr,
                 "polish":self.polishFancyArr,
                 "symmetry":self.symmetryArr,
                 "technology":self.techeArr,
                 "eyeClean":self.eyeClean,
                 "shade":self.shade,
                 "luster":self.luster,
                 "returnable":DataManager.shared.isReturnabl ?? 0,                 // (0/1)
                 "caratFrom":self.caratFrom,
                 "caratTo":self.caratTo,
                 "priceFrom":self.priceFrom,
                 "priceTo":self.priceTo,
                 "currValue":"",                   //(By Default 1)
                 "tablePerFrom":self.tableFromArr,
                 "tablePerTo":self.tableToArr,
                 "depthPerFrom":depthFromArr,
                 "depthPerTo":depthToArr,
                 "crownFrom":self.crownFromArr,
                 "crownTo":self.crownToArr,
                 "pavillionFrom":self.pavllionFromArr,
                 "pavillionTo":self.pavllionToArr,
                 "sortBy":"priceHigh" ]             //(PriceHigh,PriceLow,DiscountHigh,RecentlyAdd,SizeHigh,SizeLow)
        
        
        
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
                    }
                    else{
                        self.tableViewList.isHidden = true
                        self.dataNotFound.isHidden = false

                    }
                    
                }
//                print(self.diamondListDetails)
                self.isLoading = false
                self.page += 1
                
                
                
            }
            else{
                self.toastMessage(msg ?? "")
                self.isLoading = false
            }
            
        })
        
      }
    
    

}

extension B2BSearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterAppliedCVC.cellIdentifierFilterApplied, for: indexPath) as! FilterAppliedCVC
        cell.lblTitle.text = titleArr[indexPath.row]
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
            return 15
        }
        else{
            return diamondListDetails.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isDataListingView{
            let cell = tableView.dequeueReusableCell(withIdentifier: B2BSearchResultListingTVC.cellIdentifierListingB2B, for: indexPath) as! B2BSearchResultListingTVC
            cell.selectionStyle = .default
            cell.contentView.isUserInteractionEnabled = true
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
            if diamondListDetails.count > 1{
                cell.lblCirtificateNum.text = self.diamondListDetails[indexPath.row].certificateNo
                cell.lblLotID.text = "\(self.diamondListDetails[indexPath.row].supplierID ?? 0)"
                cell.btnShape.text = self.diamondListDetails[indexPath.row].shape
                cell.lblCarat.text = self.diamondListDetails[indexPath.row].carat
                cell.lblClor.text = self.diamondListDetails[indexPath.row].color
                cell.lblClarity.text = self.diamondListDetails[indexPath.row].clarity
                cell.lblCarat.text = self.diamondListDetails[indexPath.row].carat
                
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
                cell.lblPrice.text = "₹\(self.diamondListDetails[indexPath.row].totalPrice ?? 0)"
                
                cell.diamondSelect = {
                    self.delegateDiamond?.didSelectDiamond(self.diamondListDetails[indexPath.row])
                }
                
                cell.diamondSelect = {
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
            
            if diamondListDetails.count > 1{
                cell.lblCirtificateNum.text = self.diamondListDetails[indexPath.row].certificateNo
                cell.lblLotID.text = "ID: \(self.diamondListDetails[indexPath.row].supplierID ?? 0)"
                cell.btnShape.text = self.diamondListDetails[indexPath.row].shape
                cell.lblCarat.text = "Ct\(self.diamondListDetails[indexPath.row].carat ?? "")"
                cell.lblClor.text = self.diamondListDetails[indexPath.row].color
                cell.lblClarity.text = self.diamondListDetails[indexPath.row].clarity
                cell.lblCarat.text = self.diamondListDetails[indexPath.row].carat
                
                
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
                cell.lblPrice.text = "₹\(self.diamondListDetails[indexPath.row].totalPrice ?? 0)"
                
                cell.imgDiamond.sd_setImage(with: URL(string: self.diamondListDetails[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
                
                cell.diamondSelect = {
                    self.dashboardVC?.diamondDetails = self.diamondListDetails[indexPath.row]
                    self.dashboardVC?.loadViewController(withIdentifier: "DiamondDetailsVC", fromStoryboard: "DiamondDetails")
                }
                
                
            }
            return cell
        }
    }
    

     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

         if indexPath.row == self.diamondListDetails.count - 1 && !isLoading {
             fetchDamondData(page: page, limit: limit, param: self.param)
           }
       }
    
   
    
}
