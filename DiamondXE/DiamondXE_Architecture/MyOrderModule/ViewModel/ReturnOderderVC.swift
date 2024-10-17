//
//  ReturnOderderVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 03/10/24.
//

import UIKit
import DropDown
import DTTextField
import Alamofire

class ReturnOderderVC: BaseViewController , DataReceiver{
    
    func receiveData(_ data: [Int : [MyOrderDiamond]]) {
        // Use the received data here
        orderDIC = data
    }
    
    var cellManageTag = 0
    
    
    @IBOutlet var tableViewReturnOrder:UITableView!
    
    @IBOutlet var btnReturnOrder:UIButton!
    @IBOutlet var btnReturnResion:UIButton!
    @IBOutlet var btnOrderReview:UIButton!
    
    @IBOutlet var btnContinue:UIButton!
    
    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    
    private var isLoading = true {
        didSet {
            tableViewReturnOrder.isUserInteractionEnabled = !isLoading
            tableViewReturnOrder.reloadData()
        }
    }
    
    var orderSummryData = ReturnOrderCheckoutStruct()
    var resionsStruct = ResionsDataStruct()
    var orderDIC : [Int : [MyOrderDiamond]] = [:]
    var resionStrArr = [String]()
    
    var returnDiaObject = [ReturnDiaObject]()
    
    
    
    var orderID = Int()
    var returnType = "full"
    var cnDiamonsList = [String]()
    
    var selectedItemsArray: [MyOrderDiamond] = []
    var selectedState: [Bool] = []
    var reloadIND = true
    
    
    var paymentSource = "Wallet" // Wallet, Source
    var reasionSelected = [Int:String]()
    var imageSelection = [Int:String]()
    var videoSelection = [Int:String]()
    var linkArr = [Int:String]()
    var enterOtherResion = [Int:String]()
    
    var isReturnObjAvailable =  false

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
        //ReturnOrderItemListTVC
        tableViewReturnOrder.register(UINib(nibName: ItemSummaryDiamondsList.cellIdentifierItemSummaryDiamondsList, bundle: nil), forCellReuseIdentifier: ItemSummaryDiamondsList.cellIdentifierItemSummaryDiamondsList)
        
        
        tableViewReturnOrder.register(UINib(nibName: ReturnOrderItemListTVC.cellIdentifierReturnOrderItemListTVC, bundle: nil), forCellReuseIdentifier: ReturnOrderItemListTVC.cellIdentifierReturnOrderItemListTVC)
        
        tableViewReturnOrder.register(UINib(nibName: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC)
        
        tableViewReturnOrder.register(UINib(nibName: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC)
        
        tableViewReturnOrder.register(UINib(nibName: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC)
        
        
        tableViewReturnOrder.register(UINib(nibName: ReturnOrderItemReasionsTVC.cellIdentifierReturnOrderItemReasionsTVC, bundle: nil), forCellReuseIdentifier: ReturnOrderItemReasionsTVC.cellIdentifierReturnOrderItemReasionsTVC)
        
        
        tableViewReturnOrder.register(UINib(nibName: RefundAddressPayModeTVC.cellIdentifierRefundAddressPayModeTVC, bundle: nil), forCellReuseIdentifier: RefundAddressPayModeTVC.cellIdentifierRefundAddressPayModeTVC)
        
        
        tableViewReturnOrder.register(UINib(nibName: ItemAgreeToRefundTVC.cellIdentifierItemAgreeToRefundTVC, bundle: nil), forCellReuseIdentifier: ItemAgreeToRefundTVC.cellIdentifierItemAgreeToRefundTVC)
        
        
        self.orderID = self.orderDIC.keys.first ?? 0
        
        for (key, diamonds) in orderDIC {
            for diamond in diamonds {
                self.cnDiamonsList.append(diamond.certificateNo ?? "")
            }
        }
        
        
        self.returnOrderChekoutAPI(returnType: self.returnType)
        self.getReturnResionAPI()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActionButtonsManage(_ sender: UIButton){
        
        switch sender.tag {
        case 0:
            print("")
            self.cellManageTag = sender.tag
            self.btnReturnOrder.backgroundColor = UIColor.tabSelectClr
            self.btnReturnOrder.tintColor = .whitClr
            self.btnReturnResion.backgroundColor = UIColor.whitClr
            self.btnReturnResion.tintColor = .tabSelectClr
            self.btnOrderReview.backgroundColor = UIColor.whitClr
            self.btnOrderReview.tintColor = .tabSelectClr
            self.btnContinue.isEnabled = true
            self.btnContinue.backgroundColor = UIColor.themeClr
            self.tableViewReturnOrder.reloadData()
        case 1:
            print("")
            self.cellManageTag = sender.tag
            self.btnReturnResion.backgroundColor = UIColor.tabSelectClr
            self.btnReturnResion.tintColor = .whitClr
            self.btnReturnOrder.backgroundColor = UIColor.tabSelectClr
            self.btnReturnOrder.tintColor = .whitClr
            self.btnOrderReview.backgroundColor = UIColor.whitClr
            self.btnOrderReview.tintColor = .tabSelectClr
            self.btnContinue.isEnabled = true
            self.btnContinue.backgroundColor = UIColor.themeClr
            self.tableViewReturnOrder.reloadData()
        case 2:
            print("")
            self.cellManageTag = sender.tag
            self.btnOrderReview.backgroundColor = UIColor.tabSelectClr
            self.btnOrderReview.tintColor = .whitClr
            self.btnReturnOrder.backgroundColor = UIColor.tabSelectClr
            self.btnReturnOrder.tintColor = .whitClr
            self.btnReturnResion.backgroundColor = UIColor.tabSelectClr
            self.btnReturnResion.tintColor = .whitClr
            self.btnContinue.isEnabled = true
            self.btnContinue.backgroundColor = UIColor.themeClr
            self.tableViewReturnOrder.reloadData()
        case 3:
            print("")
        case 4:
            print("")
        case 5:
            print("")
            if self.cellManageTag == 1{
                self.cellManageTag = 0
                self.btnReturnOrder.backgroundColor = UIColor.tabSelectClr
                self.btnReturnOrder.tintColor = .whitClr
                
                self.btnReturnResion.backgroundColor = UIColor.whitClr
                self.btnReturnResion.tintColor = .tabSelectClr
                self.btnOrderReview.backgroundColor = UIColor.whitClr
                self.btnOrderReview.tintColor = .tabSelectClr
                self.btnContinue.isEnabled = true
                self.btnContinue.backgroundColor = UIColor.themeClr
                self.tableViewReturnOrder.reloadData()
            }
            
            else if self.cellManageTag == 2{
                self.cellManageTag = 1
                self.btnReturnResion.backgroundColor = UIColor.tabSelectClr
                self.btnReturnResion.tintColor = .whitClr
                
                self.btnReturnOrder.backgroundColor = UIColor.tabSelectClr
                self.btnReturnOrder.tintColor = .whitClr
                self.btnOrderReview.backgroundColor = UIColor.whitClr
                self.btnOrderReview.tintColor = .tabSelectClr
                self.btnContinue.isEnabled = true
                self.btnContinue.backgroundColor = UIColor.themeClr
                self.tableViewReturnOrder.reloadData()
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
            
            
        case 6:
            print("")
            
            if self.cellManageTag == 0{
                self.cellManageTag = 1
              
                self.btnReturnResion.backgroundColor = UIColor.tabSelectClr
                self.btnReturnResion.tintColor = .whitClr
                
                self.btnReturnOrder.backgroundColor = UIColor.tabSelectClr
                self.btnReturnOrder.tintColor = .whitClr
                self.btnOrderReview.backgroundColor = UIColor.whitClr
                self.btnOrderReview.tintColor = .tabSelectClr
                self.tableViewReturnOrder.reloadData()
            }
            
            else if self.cellManageTag == 1{
                self.cellManageTag = 2
                self.btnOrderReview.backgroundColor = UIColor.tabSelectClr
                self.btnOrderReview.tintColor = .whitClr
                
                self.btnReturnOrder.backgroundColor = UIColor.tabSelectClr
                self.btnReturnOrder.tintColor = .whitClr
                self.btnReturnResion.backgroundColor = UIColor.tabSelectClr
                self.btnReturnResion.tintColor = .whitClr
                
                self.tableViewReturnOrder.reloadData()
            }
            
            else if self.cellManageTag == 2{
                self.returnOrderRequestAPI()
            }
            
            
        default:
            print("")
        }
        
        
    }
    
    func getReturnResionAPI(){
        let url = APIs().getReturnResion_API
        MyOrderDataModel.shareInstence.getResionsAPI(url: url, requestParam: [:], completion: { data, msg in
            if data.status == 1 {
                self.resionsStruct = data
                self.resionsStruct.details?.enumerated().forEach { val, indx in
                    self.resionStrArr.append(indx.reason ?? "")
                }
                
            }

        })
    }
    
    
    func returnOrderChekoutAPI(returnType:String){
        let url = APIs().returnChekout_API
        self.isLoading = true
        let param : [String : Any] = [
            "orderId":self.orderID,
            "type": returnType,  // full, partial
            "diamonds": cnDiamonsList.joined(separator: ",")
            
        ]
        
        
            MyOrderDataModel.shareInstence.returnOrderCheckoutAPI(url: url, requestParam: param, completion: { data, msg in
                if data.status == 1 {
                    self.orderSummryData = data
                    //self.isLoading = false
                   
                    
                }
                else{
                    self.toastMessage(msg ?? "")
                }
                self.tableViewReturnOrder.reloadData()
                self.isLoading = false
            })
        }
    
    
    func returnOrderRequestAPI() {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        
        self.orderSummryData.details?.diamonds?.enumerated().forEach{ indx, val in
            appendOrUpdateValue(for: indx, key: "certificateno", value: val.certificateNo ?? "")
        }
        
        if reasionSelected.keys.count != self.orderSummryData.details?.diamonds?.count {
            self.toastMessage("Refund resion is mandatory.")
            return
        }
        let url = APIs().returnOrderRequest_API
        let headers: HTTPHeaders = HeaderInfoLocation().headers
        var objData = self.returnDiaObject.map { $0.toDictionary() }
        var paramobj : [String : Any] = [:]
       
        paramobj = ["diamonds": objData,
         "orderId": "\(self.orderID)",
         "type": "\(returnType)",  // full, partial
         "pickupAddressId": "\(self.orderSummryData.details?.userDetails?.shippingAddressID ?? 0)",
         "paymentMode": "\(self.paymentSource)"]
        
        MyOrderDataModel.shareInstence.returnOrderSubmiitedAPI(url: url, requestParam: paramobj, completion: { data, msg in
            if data.status == 1 {
                self.toastMessage(msg ?? "")
                self.navigationController?.popViewController(animated: true)
            }
            else{
                self.toastMessage(msg ?? "")
            }
            CustomActivityIndicator2.shared.hide()
        })
    
    }
  
    
    
    func openDropDown(anchrView:DTTextField, indx: Int){
        let dropDown = DropDown()
        dropDown.anchorView = anchrView
        dropDown.dataSource = resionStrArr
        dropDown.backgroundColor = UIColor.whitClr
        dropDown.selectionBackgroundColor = UIColor.themeClr.withAlphaComponent(0.2)
        dropDown.shadowColor = UIColor(white: 0.6, alpha: 1)
        dropDown.shadowOpacity = 0.7
        dropDown.shadowRadius = 15
        dropDown.cellHeight = 40
        dropDown.height = 250
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
       

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            anchrView.text = item
            self.reasionSelected[indx] = item
            self.appendOrUpdateValue(for: indx, key: "reason", value: item)

            
            dropDown.hide()

        }
        dropDown.show()
    }
    
    
    func appendOrUpdateValue(for index: Int, key: String, value: String) {
        // Ensure the index is within bounds
        if index >= 0 && index < returnDiaObject.count {
            // Update the value based on the key
            switch key {
            case "certificateno":
                returnDiaObject[index].certificateno = value
            case "reason":
                returnDiaObject[index].reason = value
            case "remark":
                returnDiaObject[index].remark = value
            case "videoURL":
                returnDiaObject[index].videoURL = value
            case "image":
                returnDiaObject[index].image = value
            case "video":
                returnDiaObject[index].video = value
            default:
                print("Invalid key")
            }
        } else {
            // If the index is out of bounds, append a new empty object and then set the value
            var newObject = ReturnDiaObject()
            switch key {
            case "certificateno":
                newObject.certificateno = value
            case "reason":
                newObject.reason = value
            case "remark":
                newObject.remark = value
            case "videoURL":
                newObject.videoURL = value
            case "image":
                newObject.image = value
            case "video":
                newObject.video = value
            default:
                print("Invalid key")
            }
            returnDiaObject.append(newObject)
        }
    }

    

}


extension ReturnOderderVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.cellManageTag {
        case 0:
            if self.cnDiamonsList.count <= 0{
                return 3
            }
            else{
                return 4
            }
            
        case 1:
            return 3
        default:
            self.btnContinue.isEnabled = false
            self.btnContinue.backgroundColor = UIColor.themeFadeClr
            return 5
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch self.cellManageTag {
        case 0:
            
            if self.cnDiamonsList.count <= 0{
                switch indexPath.section {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ReturnOrderItemListTVC.cellIdentifierReturnOrderItemListTVC, for: indexPath) as! ReturnOrderItemListTVC
                    cell.selectionStyle = .none
                    cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                    // cell.reloadData()
                    if let dataArr = self.orderDIC.values.first{
                        if reloadIND{
                            cell.reloadData(diamonds: dataArr)
                        }
                    }
                    
                    cell.lblOrderID.text = "Order ID : \(self.orderSummryData.details?.orderID ?? 0)"
                    
                    if let localDateString = convertUTCToLocal(dateString: self.orderSummryData.details?.createdAt ?? "") {
                        cell.lblDateTime.text = localDateString
                    } else {
                        print("Conversion failed")
                    }
                    cell.lblDateTime.text = self.orderSummryData.details?.createdAt
                    cell.btnActionsProcesses = { tag in
                        if tag  == 0{
                            self.reloadIND = true
                            self.returnType = "full"
                            self.cnDiamonsList.removeAll()
                            for (key, diamonds) in self.orderDIC {
                                for diamond in diamonds {
                                    self.cnDiamonsList.append(diamond.certificateNo ?? "")
                                }
                            }
                            self.returnOrderChekoutAPI(returnType: self.returnType)
                        }
                        else if tag  == 1{
                            self.reloadIND = false
                            self.returnType = "partial"
                            self.cnDiamonsList.removeAll()
                            self.returnOrderChekoutAPI(returnType: self.returnType)
                        }
                    }
                    cell.btnActionsCancel =  { data , selet in
                        self.reloadIND = false
                        self.cnDiamonsList.removeAll()
                        data.enumerated().forEach{ index, value in
                            self.cnDiamonsList.append(value.certificateNo ?? "")
                            
                        }
                        self.returnType = "partial"
                        self.returnOrderChekoutAPI(returnType: self.returnType)
                    }
                    
                    return cell
//                case 2:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC, for: indexPath) as! ItemsSummaryPriceTVC
//                    cell.selectionStyle = .none
//                    cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
//                    
//                    cell.lblDiaPrice.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.subTotal ?? 0)))"
//                    cell.lblGrandTotal.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.totalAmount ?? 0) ))"
//                    cell.lblSubTotal.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.subTotal ?? 0)))"
//                    
//                    return cell
//                    
//                    
//                    
                    
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, for: indexPath) as! ItemsSummaryAllInfoTVC
                    cell.selectionStyle = .none
                    cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                    
                    cell.lblTitle.text = "Order Summary"
                    if let currencySymbol = self.currencyRateDetailObj?.currencySymbol {
                        // Set all labels with formatted values using the provided currency symbol
                        cell.lblDiamondPrice.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                        cell.lblCouponDiscount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                        cell.lblShippingHandling.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                        cell.lblPlatformFee.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                        cell.lblTotalCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                        cell.lblOtherTaxes.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                        cell.lblDiamondsTAX.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                        cell.lblTotalTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                        cell.lblSubTotal.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                        cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                        cell.lblBNKCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                        cell.lblFinalAmount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                        
                    } else {
                        // Set all labels with formatted values using default currency symbol "₹"
                        cell.lblDiamondPrice.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                        cell.lblCouponDiscount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                        cell.lblShippingHandling.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                        cell.lblPlatformFee.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                        cell.lblTotalCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                        cell.lblOtherTaxes.text = "-"//"₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                        cell.lblDiamondsTAX.text = "-"//"₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                        cell.lblTotalTaxes.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                        cell.lblSubTotal.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                        cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                        cell.lblBNKCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                        cell.lblFinalAmount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                    }
                    
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC, for: indexPath) as! ItemsSummaryAddressesInfoTVC
                    cell.selectionStyle = .none
                    cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                    cell.lblUTRCheckNo.text = self.orderSummryData.details?.transactionID
                    if self.orderSummryData.details?.orderStatus ==  "Cancelled"{
                        cell.lblOrderStatus.textColor = UIColor.red
                    }
                    cell.lblOrderStatus.text = self.orderSummryData.details?.orderStatus
                    
                    if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
                        let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0)
                        cell.lblAmount.text = "\(currncySimbol)\(formattedNumber)"
                        
                    }
                    else{
                        let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0)
                        cell.lblAmount.text = "₹\(formattedNumber)"
                    }
                    
                    cell.ViewCmtResion.isHidden = true
                    //                cell.lblCmt.text = "Comment : \(self.orderSummryData.details?.comment ?? "")"
                    //                cell.lblResion.text = "Resion : \(self.orderSummryData.details?.reason ?? "")"
                    
                    cell.lblOrderPlaced.text = self.orderSummryData.details?.createdAt
                    cell.lblDeliveryDate.text = self.orderSummryData.details?.deliveryDate
                    cell.lblPaymentMode.text = self.orderSummryData.details?.paymentMode
                    cell.lblShippingAddress.text = self.orderSummryData.details?.userDetails?.shippingAddress
                    cell.lblBillingAddress.text = self.orderSummryData.details?.userDetails?.billingAddress
                    cell.lblContactNo.text = "Contact no. - \(self.orderSummryData.details?.userDetails?.userMobile ?? "")"
                    cell.lblEmail.text = "Email : \(self.orderSummryData.details?.userDetails?.userEmail ?? "")"
                    
                    return cell
                }
            }
            else{
                
                switch indexPath.section {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ReturnOrderItemListTVC.cellIdentifierReturnOrderItemListTVC, for: indexPath) as! ReturnOrderItemListTVC
                    cell.selectionStyle = .none
                    cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                    // cell.reloadData()
                    if let dataArr = self.orderDIC.values.first{
                        if reloadIND{
                            cell.reloadData(diamonds: dataArr)
                        }
                    }
                    
                    cell.lblOrderID.text = "Order ID : \(self.orderSummryData.details?.orderID ?? 0)"
                    
                    if let localDateString = convertUTCToLocal(dateString: self.orderSummryData.details?.createdAt ?? "") {
                        cell.lblDateTime.text = localDateString
                    } else {
                        print("Conversion failed")
                    }
                    cell.lblDateTime.text = self.orderSummryData.details?.createdAt
                    cell.btnActionsProcesses = { tag in
                        if tag  == 0{
                            self.reloadIND = true
                            self.returnType = "full"
                            self.cnDiamonsList.removeAll()
                            for (key, diamonds) in self.orderDIC {
                                for diamond in diamonds {
                                    self.cnDiamonsList.append(diamond.certificateNo ?? "")
                                }
                            }
                            self.returnOrderChekoutAPI(returnType: self.returnType)
                        }
                        else if tag  == 1{
                            self.reloadIND = false
                            self.returnType = "partial"
                            self.cnDiamonsList.removeAll()
                            self.returnOrderChekoutAPI(returnType: self.returnType)
                        }
                    }
                    cell.btnActionsCancel =  { data , selet in
                        self.reloadIND = false
                        self.cnDiamonsList.removeAll()
                        data.enumerated().forEach{ index, value in
                            self.cnDiamonsList.append(value.certificateNo ?? "")
                            
                        }
                        self.returnType = "partial"
                        self.returnOrderChekoutAPI(returnType: self.returnType)
                    }
                    
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC, for: indexPath) as! ItemsSummaryPriceTVC
                    cell.selectionStyle = .none
                    cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                    
                    cell.lblDiaPrice.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.subTotal ?? 0)))"
                    cell.lblGrandTotal.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.totalAmount ?? 0) ))"
                    cell.lblSubTotal.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.subTotal ?? 0)))"
                    
                    return cell
                    
                    
                    
                    
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, for: indexPath) as! ItemsSummaryAllInfoTVC
                    cell.selectionStyle = .none
                    cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                    
                    cell.lblTitle.text = "Order Summary"
                    if let currencySymbol = self.currencyRateDetailObj?.currencySymbol {
                        // Set all labels with formatted values using the provided currency symbol
                        cell.lblDiamondPrice.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                        cell.lblCouponDiscount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                        cell.lblShippingHandling.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                        cell.lblPlatformFee.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                        cell.lblTotalCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                        cell.lblOtherTaxes.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                        cell.lblDiamondsTAX.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                        cell.lblTotalTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                        cell.lblSubTotal.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                        cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                        cell.lblBNKCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                        cell.lblFinalAmount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                        
                    } else {
                        // Set all labels with formatted values using default currency symbol "₹"
                        cell.lblDiamondPrice.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                        cell.lblCouponDiscount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                        cell.lblShippingHandling.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                        cell.lblPlatformFee.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                        cell.lblTotalCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                        cell.lblOtherTaxes.text = "-"//"₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                        cell.lblDiamondsTAX.text = "-"//"₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                        cell.lblTotalTaxes.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                        cell.lblSubTotal.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                        cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                        cell.lblBNKCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                        cell.lblFinalAmount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                    }
                    
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC, for: indexPath) as! ItemsSummaryAddressesInfoTVC
                    cell.selectionStyle = .none
                    cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                    cell.lblUTRCheckNo.text = self.orderSummryData.details?.transactionID
                    if self.orderSummryData.details?.orderStatus ==  "Cancelled"{
                        cell.lblOrderStatus.textColor = UIColor.red
                    }
                    cell.lblOrderStatus.text = self.orderSummryData.details?.orderStatus
                    
                    if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
                        let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0)
                        cell.lblAmount.text = "\(currncySimbol)\(formattedNumber)"
                        
                    }
                    else{
                        let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0)
                        cell.lblAmount.text = "₹\(formattedNumber)"
                    }
                    
                    cell.ViewCmtResion.isHidden = true
                    //                cell.lblCmt.text = "Comment : \(self.orderSummryData.details?.comment ?? "")"
                    //                cell.lblResion.text = "Resion : \(self.orderSummryData.details?.reason ?? "")"
                    
                    cell.lblOrderPlaced.text = self.orderSummryData.details?.createdAt
                    cell.lblDeliveryDate.text = self.orderSummryData.details?.deliveryDate
                    cell.lblPaymentMode.text = self.orderSummryData.details?.paymentMode
                    cell.lblShippingAddress.text = self.orderSummryData.details?.userDetails?.shippingAddress
                    cell.lblBillingAddress.text = self.orderSummryData.details?.userDetails?.billingAddress
                    cell.lblContactNo.text = "Contact no. - \(self.orderSummryData.details?.userDetails?.userMobile ?? "")"
                    cell.lblEmail.text = "Email : \(self.orderSummryData.details?.userDetails?.userEmail ?? "")"
                    
                    return cell
                }
            }
            
        case 1:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReturnOrderItemReasionsTVC.cellIdentifierReturnOrderItemReasionsTVC, for: indexPath) as! ReturnOrderItemReasionsTVC
                cell.selectionStyle = .none
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
               // cell.reloadData()
                if let dataArr = self.orderSummryData.details?.diamonds{
                    cell.reloadData(diamonds: dataArr)
                }
                
                cell.btnActionsProcesses = { tag in
                    if tag == 0{
                        self.paymentSource = "Wallet"
                    }
                    else{
                        self.paymentSource = "Source"
                    }
                }
  
                cell.btnActionsManage = { index, tag , textAncher in
                    if tag == 0{
                        self.openDropDown(anchrView: textAncher, indx: index)
                    }
                    if tag == 1{
                        ImagePickerManager().pickImage(self){ image in
                            //here is the image
                            let indexPath = IndexPath(row: index, section: 0)
                            if let cell2 = cell.tableViewMultiItem.cellForRow(at: indexPath) as? ReturnItemImgVideoTVC {
                                cell2.viewIMGGet.isHidden = true
                                cell2.viewIMGGetDone.isHidden = false
                            }
                            
                            //self.returnDiaObject[index].image = image
                           // self.imageSelection[index] = image
                            self.appendOrUpdateValue(for: index, key: "image", value: image)

                        }
                    }
                    else if tag == 2{
                        ImagePickerManager().pickVideo(self){ video in
                            //here is the image
                           
                            //self.returnDiaObject[index].video = video
                            //self.videoSelection[index] = video
                            let videoHandler = VideoHandler()
                            videoHandler.processVideo(url: video) { base64String in
                                self.appendOrUpdateValue(for: index, key: "video", value: base64String)
                              
                                }
                                
                            
                            
                            let indexPath = IndexPath(row: index, section: 0)
                            if let cell2 = cell.tableViewMultiItem.cellForRow(at: indexPath) as? ReturnItemImgVideoTVC {
                                cell2.viewVideoGet.isHidden = true
                                cell2.viewVideoGetDone.isHidden = false
                            }
                            
                            
                        }
                    }
                    
                    else if tag == 4{
                        let indexPath = IndexPath(row: index, section: 0)
                        if let cell2 = cell.tableViewMultiItem.cellForRow(at: indexPath) as? ReturnItemImgVideoTVC {
                            self.linkArr[index] = cell2.txtVideoURL.text
                           // self.returnDiaObject[index].videoURL = cell2.txtVideoURL.text
                            
                            self.appendOrUpdateValue(for: index, key: "videoURL", value: cell2.txtVideoURL.text ?? "")
                        }
                    }
                    else if tag == 5{
                        let indexPath = IndexPath(row: index, section: 0)
                        if let cell2 = cell.tableViewMultiItem.cellForRow(at: indexPath) as? ReturnItemImgVideoTVC {
                            self.enterOtherResion[index] = cell2.textView.text
                           // self.returnDiaObject[index].remark = cell2.textView.text
                            
                            self.appendOrUpdateValue(for: index, key: "remark", value: cell2.textView.text ?? "")
                            
                        }
                        
                    }
                }
                
                
                
                return cell
           
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, for: indexPath) as! ItemsSummaryAllInfoTVC
                cell.selectionStyle = .none
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                
                cell.lblTitle.text = "Order Summary"
                if let currencySymbol = self.currencyRateDetailObj?.currencySymbol {
                    // Set all labels with formatted values using the provided currency symbol
                    cell.lblDiamondPrice.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                    cell.lblCouponDiscount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                    cell.lblShippingHandling.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                    cell.lblPlatformFee.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                    cell.lblTotalCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                    cell.lblOtherTaxes.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                    cell.lblDiamondsTAX.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                    cell.lblTotalTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                    cell.lblSubTotal.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                    cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                    cell.lblBNKCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                    cell.lblFinalAmount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                    
                } else {
                    // Set all labels with formatted values using default currency symbol "₹"
                    cell.lblDiamondPrice.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                    cell.lblCouponDiscount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                    cell.lblShippingHandling.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                    cell.lblPlatformFee.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                    cell.lblTotalCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                    cell.lblOtherTaxes.text = "-"//"₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                    cell.lblDiamondsTAX.text = "-"//"₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                    cell.lblTotalTaxes.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                    cell.lblSubTotal.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                    cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                    cell.lblBNKCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                    cell.lblFinalAmount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                }

                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC, for: indexPath) as! ItemsSummaryAddressesInfoTVC
                cell.selectionStyle = .none
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                cell.lblUTRCheckNo.text = self.orderSummryData.details?.transactionID
                if self.orderSummryData.details?.orderStatus ==  "Cancelled"{
                    cell.lblOrderStatus.textColor = UIColor.red
                }
                cell.lblOrderStatus.text = self.orderSummryData.details?.orderStatus
               
                if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
                    let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0)
                    cell.lblAmount.text = "\(currncySimbol)\(formattedNumber)"
                    
                }
                else{
                    let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0)
                    cell.lblAmount.text = "₹\(formattedNumber)"
                }
                
                cell.ViewCmtResion.isHidden = true
//                cell.lblCmt.text = "Comment : \(self.orderSummryData.details?.comment ?? "")"
//                cell.lblResion.text = "Resion : \(self.orderSummryData.details?.reason ?? "")"
                
                cell.lblOrderPlaced.text = self.orderSummryData.details?.createdAt
                cell.lblDeliveryDate.text = self.orderSummryData.details?.deliveryDate
                cell.lblPaymentMode.text = self.orderSummryData.details?.paymentMode
                cell.lblShippingAddress.text = self.orderSummryData.details?.userDetails?.shippingAddress
                cell.lblBillingAddress.text = self.orderSummryData.details?.userDetails?.billingAddress
                cell.lblContactNo.text = "Contact no. - \(self.orderSummryData.details?.userDetails?.userMobile ?? "")"
                cell.lblEmail.text = "Email : \(self.orderSummryData.details?.userDetails?.userEmail ?? "")"
                
                return cell
            
            }
        default:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: RefundAddressPayModeTVC.cellIdentifierRefundAddressPayModeTVC, for: indexPath) as! RefundAddressPayModeTVC
                cell.selectionStyle = .none

                cell.lblHeading.text = "Address"
                cell.lblTitle.text = "Pickup Address"
                cell.lblAddress.text = self.orderSummryData.details?.userDetails?.shippingAddress
                cell.lblEmail.text = "Email : \(self.orderSummryData.details?.userDetails?.userEmail ?? "")"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: RefundAddressPayModeTVC.cellIdentifierRefundAddressPayModeTVC, for: indexPath) as! RefundAddressPayModeTVC
                cell.selectionStyle = .none
                cell.lblHeading.text = "Refund Mode"
                cell.lblTitle.text = self.paymentSource
                cell.lblAddress.text = "A string is a series of characters, such as swift, that forms a collection. "
                cell.lblEmail.isHidden = true
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC, for: indexPath) as! ItemsSummaryPriceTVC
                cell.selectionStyle = .none
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)

                cell.lblDiaPrice.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.subTotal ?? 0)))"
                cell.lblGrandTotal.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.totalAmount ?? 0) ))"
                cell.lblSubTotal.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.returnOrderSummery?.subTotal ?? 0)))"

                return cell
                
                
                
                
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, for: indexPath) as! ItemsSummaryAllInfoTVC
                cell.selectionStyle = .none
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
                
                cell.lblTitle.text = "Order Summary"
                if let currencySymbol = self.currencyRateDetailObj?.currencySymbol {
                    // Set all labels with formatted values using the provided currency symbol
                    cell.lblDiamondPrice.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                    cell.lblCouponDiscount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                    cell.lblShippingHandling.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                    cell.lblPlatformFee.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                    cell.lblTotalCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                    cell.lblOtherTaxes.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                    cell.lblDiamondsTAX.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                    cell.lblTotalTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                    cell.lblSubTotal.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                    cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                    cell.lblBNKCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                    cell.lblFinalAmount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                    
                } else {
                    // Set all labels with formatted values using default currency symbol "₹"
                    cell.lblDiamondPrice.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                    cell.lblCouponDiscount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                    cell.lblShippingHandling.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                    cell.lblPlatformFee.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                    cell.lblTotalCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                    cell.lblOtherTaxes.text = "-"//"₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                    cell.lblDiamondsTAX.text = "-"//"₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTax ?? "") ?? 0))"
                    cell.lblTotalTaxes.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                    cell.lblSubTotal.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                    cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                    cell.lblBNKCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                    cell.lblFinalAmount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                }

                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: ItemAgreeToRefundTVC.cellIdentifierItemAgreeToRefundTVC, for: indexPath) as! ItemAgreeToRefundTVC
                cell.selectionStyle = .none
                
                cell.isSelectCondition = { select in
                    if select {
                        self.btnContinue.isEnabled = true
                        self.btnContinue.backgroundColor = UIColor.themeClr
                    }
                    else{
                        self.btnContinue.isEnabled = false
                        self.btnContinue.backgroundColor = UIColor.themeFadeClr
                    }
                }
                
                return cell
            }
        }
        
        

       
    }
    
    
    
}
