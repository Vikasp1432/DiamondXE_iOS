//
//  AddToCartVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/06/24.
//

import UIKit


protocol BackVCDelegate: AnyObject {
    func didBackAction(vc: AddToCartVC)
}

var cartVCIsComeFromHome:Bool?

class AddToCartVC: BaseViewController , ChildViewControllerProtocol {
    
    func didSendString(str: String) {
        print(str)
    }
    
    var delegate : BaseViewControllerDelegate?
    var backDelegate : BackVCDelegate?
    
    @IBOutlet var cartTableView:UITableView!
    @IBOutlet var footerView:UIView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblTotalPrice:UILabel!
    
    @IBOutlet var emipityView:UIView!
    @IBOutlet var lblHeading:UILabel!
    @IBOutlet var lblsubHeading:UILabel!
    @IBOutlet var imgICon:UIImageView!
    
    @IBOutlet var headerViewHeight:NSLayoutConstraint!
    @IBOutlet var footerViewHeight:NSLayoutConstraint!
    @IBOutlet var footerViewBTNWidth:NSLayoutConstraint!
    @IBOutlet var footerHeight:NSLayoutConstraint!

    
    @IBOutlet var btnBuyNow:UIButton!
    
    var cartDataStruct = CartDataStruct()
    var grandTotal = 000

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        emipityView.isHidden  = true
        btnBuyNow.clearGradient()
        btnBuyNow.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
       
        // define uitableview cell
        cartTableView.register(UINib(nibName: CartItemTVC.cellIdentifierCartItem, bundle: nil), forCellReuseIdentifier: CartItemTVC.cellIdentifierCartItem)
        
        cartTableView.register(UINib(nibName: LocationPinAddTVC.cellIdentifierLocation, bundle: nil), forCellReuseIdentifier: LocationPinAddTVC.cellIdentifierLocation)
        
        cartTableView.register(UINib(nibName: OrderSummaryTVC.cellIdentifierOrderSummary, bundle: nil), forCellReuseIdentifier: OrderSummaryTVC.cellIdentifierOrderSummary)
        // get cart data
        self.fetchCartData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
      
        if cartVCIsComeFromHome ?? true {
            headerViewHeight.constant = 0
            footerViewHeight.constant = 0
            footerViewBTNWidth.constant = 100
            btnBuyNow.clearGradient()
            btnBuyNow.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            
        }else{
            footerView.addTopShadow()
            headerViewHeight.constant = 70
            footerViewHeight.constant = 0
            footerViewBTNWidth.constant = 172
        }
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
       // backDelegate?.didBackAction(vc: self)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActionPlace(_ sender: UIButton){
        self.navigationManager(storybordName: "BillingAddress", storyboardID: "AddBillingAddress", controller: AddBillingAddress())
    }
    
    
    
    func fetchCartData() {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        let url = APIs().get_CartData_API
        let sessnID = getSessionUniqID()
        let param :[String:Any] = ["sessionId":sessnID]
      
        CartDataModel().getMyCartData(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                 self.cartDataStruct = data
                DataManager.shared.cartDataHolder = self.cartDataStruct
                self.cartDataStruct.details?.enumerated().forEach{ int, val in
                    self.grandTotal += self.cartDataStruct.details?[int].totalPrice ?? 0
                }
                
                let gTotal = self.formatNumberWithoutDeciml(Double(self.grandTotal))
                self.lblTotalPrice.text = "₹\(gTotal)"
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.checkToDataCount()
                }
                
                self.cartTableView.reloadData()
            }
            else{
                if msg ?? "" ==  "Cart is empty"{
                    self.checkToDataCount()
                }
                else{
                    self.toastMessage(msg ?? "")
                }
               
//                self.isLoading = false
            }
            
            CustomActivityIndicator2.shared.hide()

        })
        
      }
    
    func checkToDataCount(){
        if  let count = self.cartDataStruct.details?.count {
            if count > 0{
                self.btnBuyNow.clearGradient()
               
                self.btnBuyNow.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                //self.btnBuyNow.backgroundColor = .red
                self.footerView.isHidden = false
                self.footerHeight.constant = 100
                self.emipityView.isHidden = true
            }
            else{
                self.footerView.isHidden = true
                self.footerHeight.constant = 0
                self.emipityView.isHidden = false
            }
            
        }
        else{
            self.footerView.isHidden = true
            self.footerHeight.constant = 0
            self.emipityView.isHidden = false
        }
       
    }
    
    func removeFromCartItem(certificateNo:String) {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        let url = APIs().removetoCart_API
        let sessnID = getSessionUniqID()
        let param :[String:Any] = ["sessionId":sessnID, "certificateNo":certificateNo]
      
        CartDataModel().removeItemFromCart(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                
                let item = self.cartDataStruct.details?.filter { $0.certificateNo == certificateNo }
                
                self.cartDataStruct.details = self.cartDataStruct.details?.filter { $0.certificateNo != certificateNo }
                
                
                self.grandTotal = self.grandTotal - (item?.first?.totalPrice ?? 0)
                
                let grandTotal = self.formatNumberWithoutDeciml(Double(self.grandTotal))
                self.lblTotalPrice.text = "₹\(grandTotal)"
                
                if  let count = self.cartDataStruct.details?.count {
                    if count > 0{
                        self.emipityView.isHidden = true
                    }
                    else{
                        self.footerView.isHidden = true
                        self.footerHeight.constant = 0
                        self.emipityView.isHidden = false
                    }
                }
                self.cartTableView.reloadData()
            }
            else{
                self.toastMessage(msg ?? "")
//                self.isLoading = false
            }
            CustomActivityIndicator2.shared.hide()

        })
        
      }
    
    func moveFromCartToWishlistItem(certificateNo:String) {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        let url = APIs().addtoWishlist_API
        let sessnID = getSessionUniqID()
        let param :[String:Any] = ["sessionId":sessnID, "certificateNo":certificateNo, "source": "cart"]
      
        CartDataModel().removeItemFromCart(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                let item = self.cartDataStruct.details?.filter { $0.certificateNo == certificateNo }
               
                self.cartDataStruct.details = self.cartDataStruct.details?.filter { $0.certificateNo != certificateNo }
                
                self.grandTotal = self.grandTotal - (item?.first?.totalPrice ?? 0)
                
                let grandTotal = self.formatNumberWithoutDeciml(Double(self.grandTotal))
                self.lblTotalPrice.text = "₹\(grandTotal)"
                
                
                if  let count = self.cartDataStruct.details?.count {
                    if count > 0{
                        self.emipityView.isHidden = true
                    }
                    else{
                        self.footerView.isHidden = true
                        self.footerHeight.constant = 0
                        self.emipityView.isHidden = false
                    }
                }
               
              
                
                self.cartTableView.reloadData()
            }
            else{
                self.toastMessage(msg ?? "")
//                self.isLoading = false
            }
            CustomActivityIndicator2.shared.hide()

        })
        
      }
    
}

extension AddToCartVC : PinCodeDelegate{
    func didEnterPincode(pincode: String, indexPath: IndexPath) {
        if let cell = self.cartTableView.cellForRow(at: indexPath) as? LocationPinAddTVC {
            cell.lblPinCode.text = "Delivering to \(pincode)"
            
        }
    }
}

extension AddToCartVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            
            if let count = self.cartDataStruct.details?.count {
                self.lblTitle.text = "My Cart (\(count))"
                
               
                return count
            }
            else{
                self.footerView.isHidden = true
                self.footerHeight.constant = 0
               
                return 0
            }
            
            
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTVC.cellIdentifierCartItem, for: indexPath) as! CartItemTVC
            cell.selectionStyle = .none
            
            cell.imgDiamond.sd_setImage(with: URL(string: self.cartDataStruct.details?[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
            
            cell.lblCirtificateNum.text = self.cartDataStruct.details?[indexPath.row].certificateNo
            cell.lblLotID.text = "ID: \(self.cartDataStruct.details?[indexPath.row].supplierID ?? 0)"
            cell.lblShape.text = self.cartDataStruct.details?[indexPath.row].shape
            cell.lblCarat.text = "Ct\(self.cartDataStruct.details?[indexPath.row].carat ?? "")"
            cell.lblClor.text = self.cartDataStruct.details?[indexPath.row].color
            cell.lblClarity.text = self.cartDataStruct.details?[indexPath.row].clarity
            cell.lblCarat.text = self.cartDataStruct.details?[indexPath.row].carat
            
            if let availibility = self.cartDataStruct.details?[indexPath.row].status{
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
            
            let formattedNumber = formatNumberWithoutDeciml(Double(self.cartDataStruct.details?[indexPath.row].totalPrice ?? 0))
            cell.lblPrice.text = "₹\(formattedNumber)"
            
          
            cell.alertAction = {
                if let items = self.cartDataStruct.details{
                    cell.setupSelectedItem(items: items)
                }
                
                if self.cartDataStruct.details?.count ?? 0 > 1{
                    if cell.isSelectedItem{
                        let itemPrice = self.cartDataStruct.details?[indexPath.row].totalPrice ?? 0
                        self.grandTotal = self.grandTotal + itemPrice
                        
                        let grandTotal = self.formatNumberWithoutDeciml(Double(self.grandTotal))
                        self.lblTotalPrice.text = "₹\(grandTotal)"
                    }
                    else{
                        let itemPrice = self.cartDataStruct.details?[indexPath.row].totalPrice ?? 0
                        self.grandTotal = self.grandTotal - itemPrice
                        
                        let grandTotal = self.formatNumberWithoutDeciml(Double(self.grandTotal))
                        self.lblTotalPrice.text = "₹\(grandTotal)"
                    }
                }
            }
            
           
            
            cell.actionWishNRemove = { tag in
                if tag == 1{
                    self.removeFromCartItem(certificateNo: self.cartDataStruct.details?[indexPath.row].certificateNo ?? "")
                }
                else{
                    self.moveFromCartToWishlistItem(certificateNo: self.cartDataStruct.details?[indexPath.row].certificateNo ?? "")
                }
            }
            
            return cell
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: LocationPinAddTVC.cellIdentifierLocation, for: indexPath) as! LocationPinAddTVC
//            cell.selectionStyle = .none
//            cell.alertAction = {
//                let overLayerView = LocationPinView()
//                overLayerView.pincodeDelagate = self
//                overLayerView.indexPath = indexPath
//                overLayerView.appear(sender: self, pincode: 0)
//            }
//            cell.actionShipingChrg = {
//                
//            }
//            return cell
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: OrderSummaryTVC.cellIdentifierOrderSummary, for: indexPath) as! OrderSummaryTVC
//            cell.selectionStyle = .none
//            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 2{
//            return 355
//        }
//        if indexPath.section == 1{
//            return 150
//        }
//        else{
            return 160
//        }
        
    }
    
    
}


