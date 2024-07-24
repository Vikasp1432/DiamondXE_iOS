//
//  DiamondDetailsVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 20/06/24.
//

import UIKit
import UIView_Shimmer


class DiamondDetailsVC: BaseViewController, ChildViewControllerProtocol{
    var delegate: (any BaseViewControllerDelegate)?
    
    func didSendString(str: String) {
        print("ASE")
    }
    var isCellExpandedDetails = false
    var isAddtoCartItem = false
    
   
    @IBOutlet var tbleViewDetails:UITableView!
    
    var  diamondInfo = DiamondListingDetail()
    var  diamondDetails = DiamondDetailsStruct()
    var  recommendentDataStruct = RecommendentDiamondStruct()
    var cut = "--"
    var polish = "--"
    var symmetry = "--"
    var flouro = "--"
    var certificate = "--"
    var discount = String()
    
    private var isLoading = true {
        didSet {
            tbleViewDetails.isUserInteractionEnabled = !isLoading
            tbleViewDetails.reloadData()
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // define uitableview cell
        tbleViewDetails.register(UINib(nibName: DiamondImagesTVC.cellIdentifierDiaDetailsTVC, bundle: nil), forCellReuseIdentifier: DiamondImagesTVC.cellIdentifierDiaDetailsTVC)
        tbleViewDetails.register(UINib(nibName: ProductDetailsTVC.cellIdentifierProductDetailsTVC, bundle: nil), forCellReuseIdentifier: ProductDetailsTVC.cellIdentifierProductDetailsTVC)
        tbleViewDetails.register(UINib(nibName: AllDiamondDetailsTVC.cellIdentifierAllDimdDetailsTVC, bundle: nil), forCellReuseIdentifier: AllDiamondDetailsTVC.cellIdentifierAllDimdDetailsTVC)
        tbleViewDetails.register(UINib(nibName: SimillarProductTVC.cellIdentifierSimmilarDiaTVC, bundle: nil), forCellReuseIdentifier: SimillarProductTVC.cellIdentifierSimmilarDiaTVC)
        
        tbleViewDetails.showsHorizontalScrollIndicator = false
        tbleViewDetails.showsVerticalScrollIndicator = false
        self.fetchDamondDetails(certificate: self.diamondInfo.certificateNo ?? "")
        self.fetchRecomdantDiamond()
       
    }
    
    
    func fetchDamondDetails(certificate:String) {
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let url = APIs().get_DiamondDetails_API
        let sessonID = getSessionUniqID()
        let param :[String:Any] = ["certificateNo":certificate,"sessionId":sessonID]
      
        DiamondDetailsModel().getDiamondsDetails(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.diamondDetails = data
                print(self.diamondDetails)
                
                
                self.cut = self.diamondDetails.details?.cutGrade ?? ""
                self.polish = self.diamondDetails.details?.polish ?? ""
                self.symmetry = self.diamondDetails.details?.symmetry ?? ""
                self.flouro = self.diamondDetails.details?.fluorescenceColor ?? ""
                self.certificate  = self.diamondDetails.details?.certificateName ?? ""
                self.discount = "\(self.diamondDetails.details?.discountAmout ?? "")%"
//                print(self.cut, self.polish, self.symmetry, self.certificate, self.flouro, self.discount)
                self.tbleViewDetails.reloadData()
            }
            else{
                self.toastMessage(msg ?? "")
                
            }
            self.isLoading = false
            CustomActivityIndicator2.shared.hide()
            
        })
        
      }
    
    
    
    func fetchRecomdantDiamond() {
        
        let url = APIs().recommendent_API
        let param :[String:Any] = ["certificateNo":self.diamondInfo.certificateNo ?? ""]
      
        DiamondDetailsModel().getRecommendentDiamond(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.recommendentDataStruct = data
                if let dataObj = self.recommendentDataStruct.details{
                    RecommendentDiamondDataManager.shareInstence.recommendentDataObj = dataObj
                }
            }
            else{
                self.toastMessage(msg ?? "")
//                self.isLoading = false
            }
        })
        
      }
    
    // setup url add to cart
    
    func addToCart(certificateNo:String, indexPath:IndexPath){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let deviceID = getSessionUniqID()
        let url = APIs().addtoCart_API
       let param = ["certificateNo":certificateNo,
                     "sessionId":deviceID]
        ModelGetDiamond().addToWishCart(url: url, requestParam: param, completion: { data, msg in
            print(data)
            if data.status == 1{
                if let cell = self.tbleViewDetails.cellForRow(at: indexPath) as? ProductDetailsTVC {
                    cell.btnBuyNow.setTitle("Go To Cart", for: .normal)
                    self.isAddtoCartItem = true
                }
            }
            else{
               print("ddd")
            }
            CustomActivityIndicator2.shared.hide()
        })
    }
    
    func addToCartRecommendent(certificateNo:String, cell:UICollectionViewCell){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let deviceID = getSessionUniqID()
        let url = APIs().addtoCart_API
       let param = ["certificateNo":certificateNo,
                     "sessionId":deviceID]
        ModelGetDiamond().addToWishCart(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{

                self.recommendentDataStruct.details?.enumerated().forEach{ index, val in
                    if val.certificateNo == certificateNo{
                        self.recommendentDataStruct.details?[index].isCart = 1
                    }
                }
                
                if let newObj = self.recommendentDataStruct.details {
                    RecommendentDiamondDataManager.shareInstence.recommendentDataObj.removeAll()
                    RecommendentDiamondDataManager.shareInstence.recommendentDataObj = newObj
                    let indexPath = IndexPath(item: 0, section: 3)
                    self.tbleViewDetails.reloadRows(at: [indexPath], with: .none)
                }
               
                if let cell = cell as? SimillarProductCVC {
                    cell.btnCard.setTitleColor(.themeClr, for: .normal)
                    cell.btnCard.setTitle("Go To Cart", for: .normal)
                    cartVCIsComeFromHome = false
                }
                
              
            }
            else{
               print("ddd")
            }
            CustomActivityIndicator2.shared.hide()
        })
    }
    
    func addToWishList(certificateNo:String, cell: UICollectionViewCell){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let deviceID = getSessionUniqID()
        let url = APIs().addtoWishlist_API
       let param = ["certificateNo":certificateNo,
                     "sessionId":deviceID]
        ModelGetDiamond().addToWishCart(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
//                self.isDataListingView
                self.recommendentDataStruct.details?.enumerated().forEach{ index, val in
                    if val.certificateNo == certificateNo{
                        self.recommendentDataStruct.details?[index].isWishlist = 1
                    }
                }
                
                if let newObj = self.recommendentDataStruct.details {
                    RecommendentDiamondDataManager.shareInstence.recommendentDataObj.removeAll()
                    RecommendentDiamondDataManager.shareInstence.recommendentDataObj = newObj
                    let indexPath = IndexPath(item: 0, section: 3)
                    self.tbleViewDetails.reloadRows(at: [indexPath], with: .none)
                }
                
                if let cell = cell as? SimillarProductCVC {
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
    func removeToWishList(certificateNo:String, cell: UICollectionViewCell){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let deviceID = getSessionUniqID()
        let url = APIs().removetoWishlist_API
        let param = ["certificateNo":certificateNo,
                     "sessionId":deviceID]
        ModelGetDiamond().addToWishCart(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
//                self.isDataListingView
                self.recommendentDataStruct.details?.enumerated().forEach{ index, val in
                    if val.certificateNo == certificateNo{
                        self.recommendentDataStruct.details?[index].isWishlist = 0
                    }
                }
                
                if let newObj = self.recommendentDataStruct.details {
                    RecommendentDiamondDataManager.shareInstence.recommendentDataObj.removeAll()
                    RecommendentDiamondDataManager.shareInstence.recommendentDataObj = newObj
                    
                    let indexPath = IndexPath(item: 0, section: 3)
                    self.tbleViewDetails.reloadRows(at: [indexPath], with: .none)
                }
             
                if let cell = cell as? SimillarProductCVC {
                    cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                }
                
            }
            else{
               print("ddd")
            }
            CustomActivityIndicator2.shared.hide()
        })
    }
    

   
}

extension DiamondDetailsVC : CustomRcommCellDelegate{
    func cellViewTapped(in certificateNO: String, _ cell: SimillarProductCVC, tag: Int) {
        switch tag {
        case -1:
            self.fetchDamondDetails(certificate: certificateNO)
            self.tbleViewDetails.setContentOffset(.zero, animated: true)
        case 0:
            
            self.recommendentDataStruct.details?.enumerated().forEach{ index, val in
                if val.certificateNo == certificateNO{
                    var cart = self.recommendentDataStruct.details?[index].isCart ?? 0
                    if cart == 0{
                        self.addToCartRecommendent(certificateNo: certificateNO, cell: cell)
                    }
                    else{
                        cartVCIsComeFromHome = false
                        self.navigationManager(storybordName: "AddTOCart", storyboardID: "AddToCartVC", controller: AddToCartVC())
                    }
                }
            }
            
            
           
            
        case 1:
            self.recommendentDataStruct.details?.enumerated().forEach{ index, val in
                if val.certificateNo == certificateNO{
                    var wishList = self.recommendentDataStruct.details?[index].isWishlist ?? 0
                    if wishList == 0{
                        self.addToWishList(certificateNo: certificateNO, cell: cell)
                    }
                    else{
                        self.removeToWishList(certificateNo: certificateNO, cell: cell)
                    }
                }
            }
            
            
            
        default:
            fatalError("Somthing wrong")
        }
    }

}

extension DiamondDetailsVC : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiamondImagesTVC.cellIdentifierDiaDetailsTVC, for: indexPath) as! DiamondImagesTVC
            cell.selectionStyle = .none
            cell.lblTypeDia.text = self.diamondDetails.details?.category
            
            if let availibility = self.diamondDetails.details?.status{
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
            
            
            cell.imgDiamndView.sd_setImage(with: URL(string:  self.diamondDetails.details?.diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
            cell.alertAction = { tag in
                let overLayerView = OverLayerView()
                if tag == 1{
                    overLayerView.appear(sender: self, tag: tag, url: self.diamondDetails.details?.diamondVideo ?? "")
                }
                if tag == 0{
                    overLayerView.appear(sender: self, tag: tag, url: self.diamondDetails.details?.diamondImage ?? "")
                }
                if tag == 3{
                    let sizesXIB = SizesViewXIB()
                    sizesXIB.appear(sender: self, tag: tag, url:  "")
                }
                if tag == 2{
                    let sizesXIB = CertificateViewVC()
                    sizesXIB.appear(sender: self, tag: tag, url:  self.diamondDetails.details?.certificateFile ?? "")
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailsTVC.cellIdentifierProductDetailsTVC, for: indexPath) as! ProductDetailsTVC
            cell.selectionStyle = .none
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
            
            cell.lblDocNumber.text = self.diamondDetails.details?.certificateNo ?? ""
            cell.lblLotID.text = "ID:\(self.diamondDetails.details?.supplierID ?? 0)"
            cell.lblShape.text = self.diamondDetails.details?.shape ?? ""
            cell.lblCarat.text = self.diamondDetails.details?.carat ?? ""
            cell.lblClr.text = self.diamondDetails.details?.color ?? ""
            cell.lblClarity.text = self.diamondDetails.details?.clarity ?? ""
           
            
            let formattedNumber = formatNumberWithoutDeciml(Double(self.diamondDetails.details?.subtotal ?? 0))
            cell.lblPrice.text = "₹\(formattedNumber)"
//            cell.lblPrice.text = "₹\(self.diamondDetails.details?.totalPrice ?? 0)"
           // print(self.cut, self.polish, self.symmetry, self.certificate, self.flouro, self.discount)
            if !self.cut.isEmpty  {
                cell.lblCut.text = self.cut
            }
            else{
                cell.viewCut.isHidden = true
            }
            if !self.polish.isEmpty  {
                cell.lblPolish.text = self.polish
            }
            else{
                cell.viewPolish.isHidden = true
            }
            
            if !self.symmetry.isEmpty  {
                cell.lblSymmetry.text = self.symmetry
            }
            else{
                cell.viewSymmetry.isHidden = true
            }
            
            if !self.flouro.isEmpty  {
                cell.lblFlouro.text = self.flouro
            }
            else{
                cell.viewFlouro.isHidden = true
            }
            if !self.certificate.isEmpty  {
                cell.lblCertificate.text = certificate
            }
            else{
                cell.viewCertificate.isHidden = true
            }
           
            if self.diamondDetails.details?.rDescount ?? "" == "-"{
                cell.viewDiscount.isHidden = true
            }else{
                cell.viewDiscount.isHidden = false
                cell.lblDiscount.text = self.diamondDetails.details?.rDescount ?? ""
            }
           
            
            cell.alertAction = {
                let overLayerView = LocationPinView()
                overLayerView.pincodeDelagate = self
                overLayerView.indexPath = indexPath
                overLayerView.appear(sender: self, pincode: 0)
            }
            
            
            if self.diamondDetails.details?.isCart == 1 {
                self.isAddtoCartItem = true
                cell.btnBuyNow.setTitle("Go To Cart", for: .normal)
            }
            else{
                self.isAddtoCartItem = false
                cell.btnBuyNow.setTitle("Add To Cart", for: .normal)
                
            }
            
            cell.alertBuyResrv = { tag in
                if tag == 0 {
                    if self.isAddtoCartItem{
                        cartVCIsComeFromHome = false
                        self.navigationManager(storybordName: "AddTOCart", storyboardID: "AddToCartVC", controller: AddToCartVC())
                    }
                    else{
                        self.addToCart(certificateNo: self.diamondDetails.details?.certificateNo ?? "", indexPath: indexPath)
                    }
                    
                }
                else{
                    self.navigationManager(storybordName: "BillingAddress", storyboardID: "AddBillingAddress", controller: AddBillingAddress())
                }
            }
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: AllDiamondDetailsTVC.cellIdentifierAllDimdDetailsTVC, for: indexPath) as! AllDiamondDetailsTVC
            cell.selectionStyle = .none
            if  self.diamondDetails.details?.measurement?.count ?? 0 > 0{
                cell.lblMasurment.text = self.diamondDetails.details?.measurement ?? ""
            }
            else{
                cell.lblMasurment.text =  "-"
            }
            
            if self.diamondDetails.details?.depth?.count ?? 0 > 0{
                cell.lblDepth.text = self.diamondDetails.details?.depth ?? ""
            }
            else{
                cell.lblDepth.text =  "-"
            }
            if self.diamondDetails.details?.tablePerc?.count ?? 0 > 0{
                cell.lblTable.text = "\(self.diamondDetails.details?.tablePerc ?? "")%"
            }
            else{
                cell.lblTable.text =  "-"
            }
            
    
            if self.diamondDetails.details?.crownHeight?.count ?? 0 > 0{
                cell.lblCrownHeight.text = self.diamondDetails.details?.crownHeight ?? ""
            }
            else{
                cell.lblCrownHeight.text =  "-"
            }
            
            if self.diamondDetails.details?.crownAngle?.count ?? 0 > 0{
                cell.lblCrownAngle.text = self.diamondDetails.details?.crownAngle ?? ""
            }
            else{
                cell.lblCrownAngle.text =  "-"
            }
            
            if  self.diamondDetails.details?.pavillionDepth?.count ?? 0 > 0 {
                cell.lblPalivionDepth.text = self.diamondDetails.details?.pavillionDepth ?? ""
            }
            else{
                cell.lblPalivionDepth.text =  "-"
            }
            
            if self.diamondDetails.details?.pavillionAngle?.count ?? 0 > 0{
                cell.lblPalivionAngle.text = self.diamondDetails.details?.pavillionAngle ?? ""
            }
            else{
                cell.lblPalivionAngle.text =  "-"
            }
            
            if self.diamondDetails.details?.shade?.count ?? 0 > 0{
                cell.lblShade.text = self.diamondDetails.details?.shade ?? ""
            }
            else{
                cell.lblShade.text =  "-"
            }
           
            if self.diamondDetails.details?.cutGrade?.count ?? 0 > 0{
                cell.lblGridCulet.text = self.diamondDetails.details?.cutGrade ?? ""
            }
            else{
                cell.lblGridCulet.text =  "-"
            }

            if self.diamondDetails.details?.growthType?.count ?? 0 > 0{
                cell.lblGrowthType.text = self.diamondDetails.details?.growthType ?? ""
            }
            else{
                cell.lblGrowthType.text =  "-"
            }
            
            if self.diamondDetails.details?.inscription?.count ?? 0 > 0{
                cell.lblInclusion.text = self.diamondDetails.details?.inscription ?? ""
            }
            else{
                cell.lblInclusion.text =  "-"
            }
            
            if self.diamondDetails.details?.location?.count ?? 0 > 0{
                cell.lblLocation.text = self.diamondDetails.details?.location ?? ""
            }
            else{
                cell.lblLocation.text =  "-"
            }
           
            cell.lblStatus.text =  "-"
            
            if self.diamondDetails.details?.keyToSymbols?.count ?? 0 > 0{
                cell.lblKeytoSymbole.text = self.diamondDetails.details?.keyToSymbols ?? ""
            }
            else{
                cell.lblKeytoSymbole.text = "-"
            }
            
            if self.diamondDetails.details?.currencyMarkup?.count ?? 0 > 0{
                cell.lblRemark.text = self.diamondDetails.details?.currencyMarkup ?? ""
            }
            else{
                cell.lblRemark.text = "-"
            }
            
            if self.diamondDetails.details?.reportComments?.count ?? 0 > 0{
                cell.lblReportComment.text = self.diamondDetails.details?.reportComments ?? ""
            }
            else{
                cell.lblReportComment.text = "-"
            }
            
          
            cell.buttonPressed = { tag in
                self.isCellExpandedDetails.toggle()
                cell.setupData(isExpand: self.isCellExpandedDetails)
                self.tbleViewDetails.reloadRows(at: [indexPath], with: .automatic)
               }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: SimillarProductTVC.cellIdentifierSimmilarDiaTVC, for: indexPath) as! SimillarProductTVC
            cell.selectionStyle = .none
            cell.isLoading = true
            cell.delegate = self
            cell.setupRecommendentData(dataObj: RecommendentDiamondDataManager.shareInstence.recommendentDataObj)
            return cell
            
        default:
            return UITableViewCell()
        }
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return isCellExpandedDetails ? 680 : 70
        }
        if indexPath.section == 3{
            return 350
        }
        else{
            return UITableView.automaticDimension
        }
        
    }
}

extension DiamondDetailsVC : PinCodeDelegate{
    func didEnterPincode(pincode: String, indexPath: IndexPath) {
        if let cell = self.tbleViewDetails.cellForRow(at: indexPath) as? ProductDetailsTVC {
            cell.lblPincode.text = "Delivering to \(pincode)"
           
        }
    }
    
    
}
