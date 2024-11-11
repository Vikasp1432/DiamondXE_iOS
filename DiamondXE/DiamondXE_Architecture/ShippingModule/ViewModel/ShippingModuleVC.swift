//
//  ShippingModuleVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/07/24.
//

import UIKit
import DropDown
import FirebaseCrashlytics

class ShippingModuleVC: BaseViewController {
    
    @IBOutlet var btnShipping : UIButton!
    @IBOutlet var btnKYC : UIButton!
    @IBOutlet var btnPayment : UIButton!
    var isCellExpandedPointsView = false
    
    @IBOutlet var shippingTableView:UITableView!
    
    
    @IBOutlet var btnProceadPayment:UIButton!
    @IBOutlet var lblTotalAmount:UILabel!
    
    @IBOutlet var viewFooter:UIView!
    @IBOutlet var viewFooterHeight:NSLayoutConstraint!
    
    
    var billingAddressesStruct = GetAddressStruct()
    var shippingAddressesStruct = GetAddressStruct()
    
    var shippingCountry = String()
    var billingCountry = String()
    
    var shippingAddUpdate = false
    var billingAddUpdate = false
   
    var selectedIndexPathBilling: IndexPath?
    var selectedIndexPathShipping: IndexPath?
    
    var isCellExpandedPaymentOption = false
    var isCellExpandedPaymentOption2 = false
    var isCellExpandedPaymentOption3 = false
    
    var isCellExpandedTag = 0

    var isExpand = true
    var isOpenNEFT = false
    
    var isAmountLess1L = true
    var manageTopButtonTag = 0
    var isresubmitTag = false
    
    var name = String()
    var companyName = String()
    var amount = String()
    var remark = String()
    
    var indexSectionCnt = 5
    var seletedBankInt = 0
    
    var checkNum = String()
    var paymentMode = String()
    var selectedDate = String()
    var neftID = Int()
    
    
    
    var paymentModeSelected = String()
    var amountTotal = String()
    
    var pageLimit = 12
    var page = 1
    
    var selectedBankID = String()
    
    var selectedUPIName = String()
    var selectedUPIBundl = String()
    
    var refreshControl = UIRefreshControl()

    

    
    var bankInfoStruct = BankInfoDataStruct()
    var bankChargesInfoStruct = BankChargesStruct()
    var paymentModeStruct = PaymentModeDataStruct()
    var bankingInfoStruct = PaymentModeDataStruct()
    var customDatePicker = CustomDatePicker()
    var customPaymentStruct = CustomPaymentDataStruct()
    var paymentINProcessStruct = PaymentINProcessStruct()
    var paymentStatusDataStruct = PaymentStatusStruct()
    
    var isCustomPaymentHistory = false
    
    
    // diamondDetails Objest
    var diamondDetailsOBJ = DiamondDetails()
    var CartDataObj = [CardDataDetail]()
    var currencyRateDetailObj = CurrencyRateDetail()
    
    var checkOutDetails = CheckOutDataStruct()
    var isShippingByHub = ""
    
    var orderType =  String() // cart, buy now
    var certificateNo = String()
    
    var walletPoints =  String()
    var couponCode = String()
    
    var createOrderStruct = CreateOrderStruct()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        shippingTableView.delegate = self
        shippingTableView.dataSource = self

        // Do any additional setup after loading the view.
        
        btnShipping.layer.shadowColor = UIColor.black.cgColor
        btnShipping.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        btnShipping.layer.shadowRadius = 3.0
        btnShipping.layer.shadowOpacity = 0.3
        btnShipping.layer.masksToBounds = false
        
        btnKYC.layer.shadowColor = UIColor.black.cgColor
        btnKYC.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        btnKYC.layer.shadowRadius = 3.0
        btnKYC.layer.shadowOpacity = 0.3
        btnKYC.layer.masksToBounds = false
        
        btnPayment.layer.shadowColor = UIColor.black.cgColor
        btnPayment.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        btnPayment.layer.shadowRadius = 3.0
        btnPayment.layer.shadowOpacity = 0.3
        btnPayment.layer.masksToBounds = false
        
//        shippingTableView.register(UINib(nibName: ShippingItemsTVCell.cellIdentifierShippingItems, bundle: nil), forCellReuseIdentifier: ShippingItemsTVCell.cellIdentifierShippingItems)
        self.btnProceadPayment.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        shippingTableView.register(UINib(nibName: ShippingAddressListingTVC.cellIdentifierShippingAddressListingTVc, bundle: nil), forCellReuseIdentifier: ShippingAddressListingTVC.cellIdentifierShippingAddressListingTVc)
        
        shippingTableView.register(UINib(nibName: BillingAddressSameAsShippingTVC.cellIdentifierBillingAddressSameAsShippingTVC, bundle: nil), forCellReuseIdentifier: BillingAddressSameAsShippingTVC.cellIdentifierBillingAddressSameAsShippingTVC)
        
        shippingTableView.register(UINib(nibName: OrderSummeryWithItemTVC.cellIdentifierOrderSummeryWithItemTVC, bundle: nil), forCellReuseIdentifier: OrderSummeryWithItemTVC.cellIdentifierOrderSummeryWithItemTVC)
        
        shippingTableView.register(UINib(nibName: KYCDocResubmittedTVC.cellIdentifierKYCDocResubmittedTVC, bundle: nil), forCellReuseIdentifier: KYCDocResubmittedTVC.cellIdentifierKYCDocResubmittedTVC)
        
        shippingTableView.register(UINib(nibName: KYCDocStatusTVC.cellIdentifierShippingKYCDocStatusTVC, bundle: nil), forCellReuseIdentifier: KYCDocStatusTVC.cellIdentifierShippingKYCDocStatusTVC)
        
        shippingTableView.register(UINib(nibName: PointsInfoTVC.cellIdentifierPointsInfoTVC, bundle: nil), forCellReuseIdentifier: PointsInfoTVC.cellIdentifierPointsInfoTVC)
        
        shippingTableView.register(UINib(nibName: CouponInfoTVC.cellIdentifierCouponInfoTVC, bundle: nil), forCellReuseIdentifier: CouponInfoTVC.cellIdentifierCouponInfoTVC)
        
        shippingTableView.register(UINib(nibName: PaymentOptionTVC.cellIdentifierPaymentOptionTVC, bundle: nil), forCellReuseIdentifier: PaymentOptionTVC.cellIdentifierPaymentOptionTVC)
        shippingTableView.register(UINib(nibName: UPITVC.cellIdentifierUPITVC, bundle: nil), forCellReuseIdentifier: UPITVC.cellIdentifierUPITVC)
        
        
        
       
        self.getTypeChekOut()
        self.getBankInfo()
        self.getPaymentModeInfo()
        self.getBankChargesInfo()
        self.getNetBankingInfo()
       
        
    }
    
  
    
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    

    
    func fetchDataFromAPIs() {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)

        // Create a DispatchGroup
        let dispatchGroup = DispatchGroup()

        // First API call for Billing Address
        dispatchGroup.enter()
        getBillingAddressAPICalling { success in
            // Reload the Billing Address section
            self.shippingTableView.reloadSections(IndexSet(integer: 1), with: .none)
            // Mark the completion of this API
            dispatchGroup.leave()
        }

        // Second API call for Shipping Address
        dispatchGroup.enter()
        getShippingAddressAPICalling { success in
            // Reload the Shipping Address section
            self.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
            // Mark the completion of this API
            dispatchGroup.leave()
        }

        // Wait for both Shipping and Billing Address API calls to complete
        dispatchGroup.notify(queue: .main) {
            // Now we call getCheckOutDetailsAPI
            dispatchGroup.enter() // Start tracking the Checkout API
            self.getCheckOutDetailsAPI { success in
                // Handle the checkout data after both previous calls are done
                if self.checkOutDetails.details?.count ?? 0 <= 0{
                    self.navigationController?.popViewController(animated: true)
                }
                self.setupPriceManage()
                // Mark the completion of the Checkout API
                dispatchGroup.leave()
            }
            
            // Hide activity indicator when checkout API call is done
            dispatchGroup.notify(queue: .main) {
                CustomActivityIndicator2.shared.hide()
               // self.shippingTableView.reloadData()
                print("All API calls completed")
            }
        }
    }
    
  
    
    func getBillingAddressAPICalling(completion: @escaping (Bool) -> Void){
        DispatchQueue.global().async {
            let url = APIs().get_GetAddressBilling_API
            
            HomeDataModel().getAddresses(url: url, completion: { data, msg in
                if data.status == 1{
                    self.billingAddressesStruct = data
                    
                  // self.shippingTableView.reloadSections(IndexSet(integer: 2), with: .none)
                    
                    completion(true)
                }
                else{
                    self.toastMessage(msg ?? "")
                    completion(false)
                }

                
            })
        }
            
          
    }
    
    func getShippingAddressAPICalling(completion: @escaping (Bool) -> Void){
        DispatchQueue.global().async {

            let url = APIs().get_GetAddressShipping_API
            
            HomeDataModel().getAddresses(url: url, completion: { data, msg in
                if data.status == 1{
                    self.shippingAddressesStruct = data
                   // self.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
                    //self.toastMessage(msg ?? "")
                    completion(true)
                }
                else{
                    completion(false)
                    self.toastMessage(msg ?? "")
                    //                self.isLoading = false
                }
               
                
            })
        }
            
          
    }
    
    func getBankInfo(){
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let url = APIs().getBankInfo_API
        
        
        var countryNm = String()
        
        if selectedIndexPathShipping != nil {

        
         let isInterNatl = self.shippingAddressesStruct.details?[self.selectedIndexPathShipping?.row ?? 0]
            countryNm = isInterNatl?.countryNameS ?? ""
           
        }
        else{
           // var returnCnt = Int()
            self.shippingAddressesStruct.details?.enumerated().forEach{ index, val in
                if val.isDefault == 1{
                    countryNm = val.countryNameS ?? ""
                  
                }
            }
           
        }
        
        var param : [String :Any] = ["countryName" : "\(countryNm)"]
            
        CustomPaymentModel.shareInstence.getBankInfoData(url: url, requestParam: param, completion: { data, msg in
                if data.status == 1{
                    self.bankInfoStruct = data
                    self.shippingTableView.reloadData()
                }
                else{
                   // self.toastMessage(msg ?? "")
                    
                }
              //  CustomActivityIndicator2.shared.hide()
                
            })
    }
    
    func getBankChargesInfo(){
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let url = APIs().getBankCharges_API
      
            
        CustomPaymentModel.shareInstence.getBankChargesInfoData(url: url, completion: { data, msg in
                if data.status == 1{
                    self.bankChargesInfoStruct = data
                }
                else{
                    
                }
              //  CustomActivityIndicator2.shared.hide()
                
            })
    }
    
    func getPaymentModeInfo(){
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let url = APIs().getBankInfo_API
      
            
        CustomPaymentModel.shareInstence.getPaymentModeData(url: url, completion: { data, msg in
                if data.status == 1{
                    self.paymentModeStruct = data
                }
                else{
                   // self.toastMessage(msg ?? "")
                    
                }
               // CustomActivityIndicator2.shared.hide()
                
            })
    }
    
    
    
    func getNetBankingInfo(){
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let url = APIs().getPaymentMode_API
      
            
        CustomPaymentModel.shareInstence.getPaymentModeData(url: url, completion: { data, msg in
                if data.status == 1{
                    self.bankingInfoStruct = data
                    
                    self.shippingTableView.reloadData()
                    
//                    let indexPath = IndexPath(row: 0, section: 2)
//                    if let cell = self.shippingTableView.cellForRow(at: indexPath) as? PaymentOptionTVC {
//                        if let netBankInfo = self.bankingInfoStruct.details?.netBanking {
//                            cell.netBankingData = netBankInfo
//                            cell.banksCollectionView.reloadData()
//                        }
//                    }

                    
                }
                else{
                   // self.toastMessage(msg ?? "")
                    
                }
               // CustomActivityIndicator2.shared.hide()
                
            })
    }
    
    
    
    // checkout api
    func getCheckOutDetailsAPI(completion: @escaping (Bool) -> Void){
        
//        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        var deliveryPin = String()
        
        self.shippingAddressesStruct.details?.enumerated().forEach { index, itm in
            
            if itm.isDefault == 1{
                deliveryPin = itm.pinCode ?? ""
                self.shippingCountry = itm.countryNameS ?? ""
            }
            
        }
        
        self.billingAddressesStruct.details?.enumerated().forEach { index, itm in
            
            if itm.isDefault == 1{
                
                self.billingCountry = itm.countryNameS ?? ""
            }
            
        }
        
        let param : [String : Any] = [
            "couponCode" : "",
            "walletPoints" : "",
            "paymentMode" : "",
            "deliveryPincode" : deliveryPin,
            "collectFromHub" : self.isShippingByHub,
            "orderType": self.orderType,// cart, buy now
            "certificateNo" : self.certificateNo,
            "billingCountry" : self.billingCountry,
            "shippingCountry" : self.shippingCountry

        ]
            
        let url = APIs().checkOutDetails_API
      
        
        ShippingModuleModel.shareInstence.getCheckOutDetailsAPI(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
                self.checkOutDetails = data
                
                completion(true)
                //self.shippingTableView.reloadData()
                
//                let indexPath = IndexPath(row: 0, section: 4)
//                if let cell = self.shippingTableView.cellForRow(at: indexPath) as? OrderSummeryWithItemTVC {
//                    cell.setupData(checkOutData: self.checkOutDetails)
//                }
            }
            else{
                completion(false)
                self.toastMessage(msg ?? "")
                
            }
//            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
//            CustomActivityIndicator2.shared.hide()
            
        })
        
      
    }
    
    
    func openDropDown(dataArr:[String], anchorView:UIView, txtField : UITextField){
       var dropDown = DropDown()
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
       

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            txtField.text = item
            self.neftID = index

            if !isOpenNEFT{
                if let bnkID = self.bankingInfoStruct.details?.netBanking?.allBanks?[index].bankID {
                    self.selectedBankID  = bnkID
                   // self.shippingTableView.reloadSections(IndexSet(integer: 2), with: .none)
                }
                
                
                let indexPath = IndexPath(row: 0, section: 2)
                if let cell = self.shippingTableView.cellForRow(at: indexPath) as? PaymentOptionTVC {
                   // if index < 2{
                        
                        let indexPath = IndexPath(row: index, section: 0)
                        cell.selectedIndex(index: indexPath)
                        
//                    }
//                    else{
//                        cell.selectedIndexPath = IndexPath()
//                        cell.banksCollectionView.reloadData()
//                    }
//                    
                    
                }
            }
            
            dropDown.hide()

        }
        dropDown.show()
    }
    
    
    func checkAddressSelectedShipping() -> Bool{
       
        var isShippingAddress = false

        
        if selectedIndexPathShipping != nil {

         let isInterNatl = self.shippingAddressesStruct.details?[self.selectedIndexPathShipping?.row ?? 0]
            isShippingAddress = true
         
        }
        
        else {  self.shippingAddressesStruct.details?.enumerated().forEach { index, itm in
            if itm.isDefault == 1{
                isShippingAddress = true
            }
            
          }
            
        }
        
      
        return isShippingAddress
    }
    
    func checkAddressSelectedBilling() -> Bool{
       
        var isBillingAddress = false
       

        if selectedIndexPathBilling != nil {
       
            let isInterNatl = self.billingAddressesStruct.details?[self.selectedIndexPathBilling?.row ?? 0]
            isBillingAddress = true
            
        }
        else {
            self.billingAddressesStruct.details?.enumerated().forEach { index, itm in
                if itm.isDefault == 1{
                    isBillingAddress = true
                }
                
            }
        }
        return isBillingAddress
    }
    
    
    @IBAction func btnActionProceedPayment(_ sender:UIButton){
        
        if !checkAddressSelectedShipping() {
            self.toastMessage("Addn Shipping Address")
            return
        }
      
        if !checkAddressSelectedBilling() {
            self.toastMessage("Addn Billing Address")
            return
        }
      
        if checkAddressSelectedShipping() && checkAddressSelectedBilling(){
            
            if self.manageTopButtonTag == 0 {
                self.manageTopButtonTag = 1
                self.btnKYC.backgroundColor = UIColor.tabSelectClr
                self.btnKYC.tintColor = .whitClr
                self.btnProceadPayment.setTitle("Continue", for: .normal)
                self.shippingTableView.reloadData()
            }
            else if self.manageTopButtonTag == 1 {
                
                if self.btnProceadPayment.titleLabel?.text == "Submit"{
                    self.callAPiForUploadDoc()
                }
                else{
                    self.manageTopButtonTag = 2
                    self.btnPayment.backgroundColor = UIColor.tabSelectClr
                    self.btnPayment.tintColor = .whitClr
                    
                    self.btnProceadPayment.setTitle("Tap To Pay", for: .normal)
                    
                    self.shippingTableView.reloadData()
                }
                
            }
            else{
                // self.btnProceadPayment.setTitle("Place To payment", for: .normal)
                // payment method
                self.callAPiForProceadPayment()
                
                //            if self.btnProceadPayment.titleLabel?.text == "Submit"{
                //                self.callAPiForUploadDoc()
                //            }
                //            else{
                //                //self.callAPiForProceadPayment()
                //            }
                
            }
        }
    }
    
    
    
    func callAPiForUploadDoc(){
        var indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.shippingTableView.cellForRow(at: indexPath) as? KYCDocResubmittedTVC {
            var param : [String:Any] = [:]

            if cell.isGSTVerify{
                param = ["companyGSTNo" : cell.txtGSTNum.text ?? "","companyGSTNoDoc": "\(cell.docGST)" ,"companyGSTNoId": "\(cell.companyGSTDocID)" ]
            }
          
            if cell.isCompanyDetailsPANVerified{
                param = ["companyPANNo" : cell.txtComPAN.text ?? "","companyPANNoDoc": "\(cell.docComPAN)" ,"companyPANNoId": "\(cell.companyPANDocID)" ]
            }
            
            if !cell.txtIECNum.text!.isEmptyStr {
                param = ["IEC" : cell.txtIECNum.text ?? "","IECDoc": "\(cell.docIEC)" ,"IECId": "\(cell.IECDocID)" ]
            }
            
            
            if cell.isAdharVerify{
                param = ["aadhaarNo" : cell.txtAadharNum.text ?? "","aadhaarNoFrontDoc": "\(cell.docAAdhaarFront)" ,"aadhaarFrontId": "\(cell.aadhaarFrontDocID)", "aadhaarBackId": "\(cell.aadhaarBackDocID)" , "aadhaarNoBackDoc": "\(cell.docAAdhaarBack)"]
            }
           
            
            if cell.isPanVerify{
     
                param = ["PANNo" : cell.txPANNum.text ?? "","PANNoDoc": "\(cell.docPAN)" ,"PANNoId": "\(cell.pANDocID)" ]
            }
           
            if cell.isPassportVerify{
                param = ["passportNo" : cell.txPassportNum.text ?? "","passportFrontDoc": "\(cell.docPassportFront)" ,"passportFrontDocId": "\(cell.passportFrontDocID)", "passportBackDocId": "\(cell.passportBackDocID)" , "passportBackDoc": "\(cell.docPassportBack)"]
            }
           
            if cell.isDrivingLincVerify{
                
                param = ["dob" :cell.txtDateOFBirth.text ?? "","drivingLicenseNo" : cell.txtDrivingLicenceNum.text ?? "","drivingLicenseDoc": "\(cell.docDrivingLicence)" ,"drivingLicenseDocId": "\(cell.DrivingLincDocID)" ]
            }
            print(param)
            
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().verifyDoc(url: APIs().upload_KYCDoc_API, requestParam: param, completion: { result , msg in
                CustomActivityIndicator2.shared.hide()
                if result.status == 1{
                    self.btnProceadPayment.setTitle("Continue", for: .normal)
                    self.isresubmitTag = false
                    self.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
                }
                else{
                    self.toastMessage(msg ?? "")
                }
                
                //self.toastMessage(result.msg ?? "")
               
            })
        }
        
        
    }
    
    func callAPiForProceadPayment(){
        switch self.paymentModeSelected {
        case "NEFT":
            
            self.callAPICrerateOrder()

//                        let indexPath1 = IndexPath(row: 0, section: 2)
//                        if let cell = self.shippingTableView.cellForRow(at: indexPath1) as? PaymentOptionTVC {
//                           // cell.customPymnt = self
//                            isDataCollect =  cell.dataCollect()
//            
//                        }
//            
//            if isDataCollect{
//                callAPIProceedPayment()
//            }
        case "CreditCard":
            PaymentManager.shared.upiName = name.uppercased()
            PaymentManager.shared.paymentType = "CreditCard"
            PaymentManager.shared.delegate = self
            //            PaymentManager.shared.initiatePhonePeTransaction(from: self)
           // self.callAPIWithPhonePeProceedPayment()
            
            self.callAPICrerateOrder()
        case "NetBanking":
            PaymentManager.shared.paymentType = "NetBanking"
            PaymentManager.shared.paymentInstrumentbnkID = self.selectedBankID
            PaymentManager.shared.delegate = self
            //            PaymentManager.shared.initiatePhonePeTransaction(from: self)
           // self.callAPIWithPhonePeProceedPayment()
            
            
            if selectedBankID.isEmpty && selectedBankID == ""{
                self.toastMessage("Select Bank First")
            }
            else{
                self.callAPICrerateOrder()
            }
            
        case "UPI":
            
            PaymentManager.shared.upiName = self.selectedUPIName.uppercased()
            PaymentManager.shared.paymentType = "UPI"
            PaymentManager.shared.upiPackageName = self.selectedUPIBundl
            self.callAPICrerateOrder()
            //self.callAPIWithPhonePeProceedPayment()
            
        default:
            let topOffset = CGPoint(x: 0, y: 0)
            self.shippingTableView.setContentOffset(topOffset, animated: true)
            self.toastMessage("Select payment method first")
        }
    }

//    func callAPIWithPhonePeProceedPayment(){
//        var dataCollect = false
//        let indexPath = IndexPath(row: 0, section: 0)
////        if let cell = self.customPaymentTV.cellForRow(at: indexPath) as? CustomInfoTVC {
////            cell.customPymnt = self
////            self.remark = cell.textView.text
////            self.amount = cell.txtAmount.text ?? ""
////            
////        }
//      
//        let url = APIs().proceedPayment_API
//        let param :[String:Any] = [
//            "amount": self.amount,
//            "paymentMode": paymentModeSelected,
//            "remark": self.remark,
//            "submit": 1
//        
//        ]
//        
//        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
//        
//        CustomPaymentModel.shareInstence.proceedPaymentAPI(url: url, requestParam: param, completion: { data, msg in
//            CustomActivityIndicator2.shared.hide()
//            if data.status == 1{
//                self.paymentINProcessStruct = data
//                PaymentManager.shared.paymentINProcessStruct = data
//                PaymentManager.shared.initiatePhonePeTransaction(from: self)
//            }
//            else{
//                self.toastMessage(msg ?? "")
//            }
//           
//            
//        })
//        
//        
//        
//    }
    
    func callAPIProceedPayment(){
        var uniqDeviceID = self.getSessionUniqID()
        let url = APIs().proceedPayment_API
        let param :[String:Any] = [
           
            "deviceId" : uniqDeviceID,
            "deviceType" : "iOS",
            "amount": self.amountTotal,
            "paymentMode": paymentModeSelected, //'NEFT','DebitCard','CreditCard','NetBanking','UPI'
            "bankPaymentMethod": self.paymentMode,
            "bankUTRNo": self.checkNum,
            "bankPaymentDate": self.selectedDate,
            "bankNeftId": self.bankInfoStruct.details?[self.seletedBankInt].bankID ?? 0,
                // "currencyCode":"INR",
                // "currency":"₹",
                // "currencyExRate":"1",
            "remark": self.remark,
            "submit": 1 // 0 Or 1 for submission
        
        
        ]
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        CustomPaymentModel.shareInstence.proceedPaymentAPI(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.paymentINProcessStruct = data
                let storyBoard: UIStoryboard = UIStoryboard(name: "CustomPayment", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentInProgressVC") as! PaymentInProgressVC
                vc.checqNum = self.checkNum
                vc.paymentINProcessStruct = self.paymentINProcessStruct
                self.navigationController?.pushViewController(vc, animated: true)
                //self.navigationController?.popViewController(animated: true)
            }
            else{
                self.toastMessage(msg ?? "")
                //                self.isLoading = false
            }
            CustomActivityIndicator2.shared.hide()
            
        })
        
        
        
    }
    
    
    
    @IBAction func btnActionTopButton(_ sender: UIButton){
        
        switch sender.tag {
        case 0:
            self.manageTopButtonTag = sender.tag
            self.btnShipping.backgroundColor = UIColor.tabSelectClr
            self.btnShipping.tintColor = .whitClr
            
            self.btnKYC.backgroundColor = UIColor.whitClr
            self.btnKYC.tintColor = .tabSelectClr
            self.btnPayment.backgroundColor = UIColor.whitClr
            self.btnPayment.tintColor = .tabSelectClr
            self.btnProceadPayment.setTitle("Continue", for: .normal)
            //self.applyCouponCode(couponCode: "", waletPoint: "", paymentMode: "")
        case 1:
            
            if !checkAddressSelectedShipping() {
                self.toastMessage("Addn Shipping Address")
                return
            }
          
            if !checkAddressSelectedBilling() {
                self.toastMessage("Addn Billing Address")
                return
            }
            
            if checkAddressSelectedBilling() && checkAddressSelectedShipping() {
                
                self.manageTopButtonTag = sender.tag
                self.btnShipping.backgroundColor = UIColor.tabSelectClr
                self.btnShipping.tintColor = .whitClr
                
                self.btnKYC.backgroundColor = UIColor.tabSelectClr
                self.btnKYC.tintColor = .whitClr
                
                self.btnPayment.backgroundColor = UIColor.whitClr
                self.btnPayment.tintColor = .tabSelectClr
                self.btnProceadPayment.setTitle("Continue", for: .normal)
            }
            //self.applyCouponCode(couponCode: "", waletPoint: "", paymentMode: "")
        case 2:
            if !checkAddressSelectedShipping() {
                self.toastMessage("Addn Shipping Address")
                return
            }
          
            if !checkAddressSelectedBilling() {
                self.toastMessage("Addn Billing Address")
                return
            }
            
            if checkAddressSelectedBilling() && checkAddressSelectedShipping() {
                
                self.manageTopButtonTag = sender.tag
                self.btnShipping.backgroundColor = UIColor.tabSelectClr
                self.btnShipping.tintColor = .whitClr
                self.btnKYC.backgroundColor = UIColor.tabSelectClr
                self.btnKYC.tintColor = .whitClr
                self.btnPayment.backgroundColor = UIColor.tabSelectClr
                self.btnPayment.tintColor = .whitClr
                self.btnProceadPayment.setTitle("Tap to Pay", for: .normal)
            }
        default:
            print("")
        }
        self.shippingTableView.reloadData()
        
    }
  
    
    func applyCouponCode(couponCode:String,waletPoint:String, paymentMode:String){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        var deliveryPin = String()

        if selectedIndexPathShipping != nil {

         let isInterNatl = self.shippingAddressesStruct.details?[self.selectedIndexPathShipping?.row ?? 0]
            self.shippingCountry = isInterNatl?.countryNameS ?? ""
            deliveryPin = isInterNatl?.pinCode ?? ""
            
    
            if self.shippingAddUpdate{
                self.shippingAddressesStruct.details?.enumerated().forEach { index, itm in
                    if itm.isDefault == 1{
                        deliveryPin = itm.pinCode ?? ""
                        self.shippingCountry = itm.countryNameS ?? ""
                    }
                }
            }
            
        }
        
        else {  self.shippingAddressesStruct.details?.enumerated().forEach { index, itm in
            if itm.isDefault == 1{
                deliveryPin = itm.pinCode ?? ""
                self.shippingCountry = itm.countryNameS ?? ""
            }
            
          }
            
        }
        
        if selectedIndexPathBilling != nil {

         let isInterNatl = self.billingAddressesStruct.details?[self.selectedIndexPathBilling?.row ?? 0]
            self.billingCountry = isInterNatl?.countryNameS ?? ""
            
            if billingAddUpdate{
                self.billingAddressesStruct.details?.enumerated().forEach { index, itm in
                    if itm.isDefault == 1{
                        self.billingCountry = itm.countryNameS ?? ""
                    }
                    
                }
            }
        }
        else {
            self.billingAddressesStruct.details?.enumerated().forEach { index, itm in
                if itm.isDefault == 1{
                    self.billingCountry = itm.countryNameS ?? ""
                }
                
            }
        }
        
        
        let param : [String : Any] = [
            "couponCode" : "\(couponCode)",
            "walletPoints" : "\(waletPoint)",
            "paymentMode" : paymentMode,
            "deliveryPincode" : deliveryPin,
            "collectFromHub" : self.isShippingByHub,
            "orderType": self.orderType,// cart, buy now
            "certificateNo" : self.certificateNo,
            "billingCountry" : self.billingCountry,
            "shippingCountry" : self.shippingCountry
            
        ]
        
        let url = APIs().checkOutDetails_API
        
        
        ShippingModuleModel.shareInstence.getCheckOutDetailsAPI(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
                self.checkOutDetails = data
                
                if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                    let currncyVal = self.currencyRateDetailObj.value ?? 1
                    let finalVal = Double(self.checkOutDetails.finalAmount ?? 0) * currncyVal
                    let formattedNumber = self.formatNumberWithoutDeciml(Double(finalVal))
                    self.lblTotalAmount.text = "\(currncySimbol)\(formattedNumber)"
                    self.amountTotal = "\(finalVal)"
                }
                else{
                    let formattedNumber = self.formatNumberWithoutDeciml(Double(self.checkOutDetails.finalAmount ?? 0))
                    self.amountTotal = "\(self.checkOutDetails.finalAmount ?? 0)"
                    self.lblTotalAmount.text = "₹\(formattedNumber)"
                }
                
                if self.manageTopButtonTag == 0{
                    DispatchQueue.main.async {
                           let sectionIndices = IndexSet(integersIn: 2...3)
                           self.shippingTableView.reloadSections(sectionIndices, with: .automatic)
                       }
                }
                else{
                    self.shippingTableView.reloadData()
                }
                
                
                
                
                //  let indexPath = IndexPath(row: 0, section: 4)
                //                if let cell = self.shippingTableView.cellForRow(at: indexPath) as? OrderSummeryWithItemTVC {
                //                    cell.setupData(checkOutData: self.checkOutDetails)
                //                }
            }
            else{
                self.toastMessage(msg ?? "")
                
            }
            
            CustomActivityIndicator2.shared.hide()
            
        })
        
        
    }
    
    
    // call api for Procead payment
    func callAPICrerateOrder(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        var deliveryPin = String()
        var shippingAddssID = Int()
        var billingAddssID = Int()
        self.shippingAddressesStruct.details?.enumerated().forEach { index, itm in
            
            if itm.isDefault == 1{
                deliveryPin = itm.pinCode ?? ""
                shippingAddssID = itm.addressID ?? 0
            }
            
        }
        
        self.billingAddressesStruct.details?.enumerated().forEach { index, itm in
            
            if itm.isDefault == 1{
                deliveryPin = itm.pinCode ?? ""
                billingAddssID = itm.addressID ?? 0
            }
            
        }
        
        let indexPath = IndexPath(row: 0, section: 2)
        if let cell = self.shippingTableView.cellForRow(at: indexPath) as? PaymentOptionTVC {
          if cell.dataCollect() {
                print("Dta\\get")
            }
            
        }
        
        let uniqDeviceID = self.getSessionUniqID()
        
        let param : [String : Any] = [
               "billingAddress": billingAddssID,
               "shippingAddress": shippingAddssID,
               "specialInstructions": "",
               "walletPoints": self.checkOutDetails.walletPoint ?? "",
               "couponCode": self.couponCode,
               "paymentMode": self.paymentModeSelected,
               "bankPaymentMethod": self.paymentMode,
               "bankUTRNo": self.checkNum,
               "bankPaymentDate": self.selectedDate,
               "bankNeftId": self.neftID,
               "deliveryPincode": deliveryPin,
               "collectFromHub": self.isShippingByHub,
               "orderType": self.orderType,// cart, buy now
               "certificateNo" : self.certificateNo,
               "deviceId" : uniqDeviceID,
               "deviceType" : "iOS"
            
        ]
        
        let url = APIs().createOrder_API
        
        
        var paymentProcessStruct = PaymentINProcessStruct()
        ShippingModuleModel.shareInstence.createOrderAPI(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
                self.createOrderStruct = data
                
                var details = PymtInProcessDetails()
                //
                details.totalAmount = self.createOrderStruct.details?.amount
                details.orderID = self.createOrderStruct.details?.orderID
                details.userID = self.createOrderStruct.details?.userDetails?.userID
                details.userData?.mobile = self.createOrderStruct.details?.userDetails?.mobile
                // print(details)
                paymentProcessStruct.details = details
                
                if self.paymentMode == "NEFT" {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "CustomPayment", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentInProgressVC") as! PaymentInProgressVC
                    vc.checqNum = self.checkNum
                    vc.paymentINProcessStruct = paymentProcessStruct
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    
                    PaymentManager.shared.paymentINProcessStruct = paymentProcessStruct
                    PaymentManager.shared.callBackURl = self.createOrderStruct.details?.callbackURL
                    PaymentManager.shared.initiatePhonePeTransaction(from: self)
                }
                
            }
            else{
                self.toastMessage(msg ?? "")
                
            }
            
            CustomActivityIndicator2.shared.hide()
            
        })
        
        
    }

    
    func checkUPIAmount() -> Bool{
        guard let amount = self.checkOutDetails.finalAmount else { return false }
        if amount > 100000{
            return true
        }
        else{
            return false
        }
    }

}

extension ShippingModuleVC : TransactionIDDelegate{
    func paymentTransactionID(transectionID: String, paymentStatus: String) {
        
        if paymentStatus == "success"{
            self.getPaymentStatus(orderID: transectionID)
        }
        else{
            
            //print(paymentStatus)
            if let extractedMessage = extractMessage(from: paymentStatus) {
                print("Extracted message: \(extractedMessage)")
                
                if extractedMessage == "Request failed."{
                    toastMessage(extractedMessage)
                }
                else{
                    self.getPaymentStatus(orderID: transectionID)
                }
                
            } else {
                toastMessage("Request failed.")
            }
        }
        
       
    }
    
  
    func getPaymentStatus(orderID : String){
      
        let url = APIs().proceedPayment_Status_API
        let param :[String:Any] = [
            "orderId": orderID
        ]
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        CustomPaymentModel.shareInstence.getpaymentStatusApi(url: url, requestParam: param, completion: { data, msg in
            CustomActivityIndicator2.shared.hide()
            if data.status == 1{
                self.paymentStatusDataStruct = data
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "CustomPayment", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentStatusVC") as! PaymentStatusVC
                vc.paymentStatusDataStruct = self.paymentStatusDataStruct
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self.toastMessage(msg ?? "")
            }
           
            
        })
        
        
        
    }
    
    func extractMessage(from input: String) -> String? {
        let pattern = #"message: \"(.*?)\""# // Regular expression pattern to find the message
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let nsString = input as NSString
            let results = regex.matches(in: input, options: [], range: NSRange(location: 0, length: nsString.length))
            
            if let match = results.first {
                return nsString.substring(with: match.range(at: 1))
            }
        }
        return nil
    }
    
    
//    override func viewDidDisappear(_ animated: Bool) {
//        print("lasr")
//        self.CartDataObj.removeAll()
//        self.diamondDetailsOBJ = DiamondDetails()
//    }
    
    func getTypeChekOut(){
      
        if self.CartDataObj.count > 0{
            self.orderType = "cart"
            self.certificateNo = String()
            
        }
        else if self.diamondDetailsOBJ.certificateNo != nil{
            self.orderType = "buy now"
            self.certificateNo = self.diamondDetailsOBJ.certificateNo ?? ""
           
        }
        
        self.fetchDataFromAPIs()
        
    }
    
    
    func setupPriceManage(){
      
        if self.CartDataObj.count > 0{
            
            if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                let currncyVal = self.currencyRateDetailObj.value ?? 1
                let finalVal = Double(checkOutDetails.finalAmount ?? 0) * currncyVal
               let formattedNumber = formatNumberWithoutDeciml(Double(finalVal))
                self.lblTotalAmount.text = "\(currncySimbol)\(formattedNumber)"
                self.amountTotal = "\(finalVal)"
            }
            else{
                let formattedNumber = formatNumberWithoutDeciml(Double(checkOutDetails.finalAmount ?? 0))
                self.amountTotal = "\(checkOutDetails.finalAmount ?? 0)"
                self.lblTotalAmount.text = "₹\(formattedNumber)"
            }
            
        }
        else if self.diamondDetailsOBJ.certificateNo != nil{
            
            if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                let currncyVal = self.currencyRateDetailObj.value ?? 1
                let finalVal = Double(checkOutDetails.finalAmount ?? 0) * currncyVal
                let formattedNumber = formatNumberWithoutDeciml(finalVal)
                self.lblTotalAmount.text = "\(currncySimbol)\(formattedNumber)"
                self.amountTotal = "\(finalVal)"
            }
            else{
                let formattedNumber = formatNumberWithoutDeciml(Double(checkOutDetails.finalAmount ?? 0))
                self.amountTotal = "\(checkOutDetails.finalAmount ?? 0)"
                self.lblTotalAmount.text = "₹\(formattedNumber)"
            }
        }
        
    }
    

    
}



extension ShippingModuleVC:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.manageTopButtonTag {
        case 0:
            return 4
        case 1:
            if !isresubmitTag{
                return 2
            }
            else{
                return 2
            }
        case 2:
            
            
            if selectedIndexPathShipping != nil {

            
             let isInterNatl = self.shippingAddressesStruct.details?[self.selectedIndexPathShipping?.row ?? 0]
                if isInterNatl?.countryNameS == "United Arab Emirates"{
                    isAmountLess1L = true
                }
                else{
                    if self.checkUPIAmount(){
                        isAmountLess1L = true
                        
                    }
                    else{
                        
                        isAmountLess1L = false
                    }
                   
                }
               
            }
            else{
               // var returnCnt = Int()
                self.shippingAddressesStruct.details?.enumerated().forEach{ index, val in
                    if val.isDefault == 1{
                        if val.countryNameS == "United Arab Emirates"{
                            isAmountLess1L = true
                        }
                        else{
                            if self.checkUPIAmount(){
                                isAmountLess1L = true
                               
                            }
                            else{
                                isAmountLess1L = false
                            }
                        }
                    }
                    
                }
               // return 4
            }
            return  4
            
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.manageTopButtonTag {
        case 0:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: ShippingAddressListingTVC.cellIdentifierShippingAddressListingTVc, for: indexPath) as! ShippingAddressListingTVC
                cell.selectionStyle = .none
                cell.lblHeaderTitle.text = "Shipping Address"
              
                cell.updateDataIncell(cellData: self.shippingAddressesStruct)
                
                cell.btnActionAddAddress = {
                    self.gotoAddAddress(index: 1)
                }
                
                if let selected = self.selectedIndexPathShipping {
                    cell.selectedIndexPath = selected
                    cell.ischangeAddress = true
                }
                
                
                cell.btnActionEdit = { index in
                    if let data = self.shippingAddressesStruct.details{ 
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "ShippingAddress", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "AddShippingAddressVC") as! AddShippingAddressVC
                        vc.delegate = self
                        vc.isEdit = true
                        vc.dataObj = data[index]
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                       // self.navigationManager(AddShippingAddressVC.self, storyboardName: "ShippingAddress", storyboardID: "AddShippingAddressVC", data: data[index])
                    }
                }
              
                cell.btnActionCell22 = { tag in
                        if let selected = self.selectedIndexPathShipping {
                            tableView.deselectRow(at: selected, animated: true)
                        }
                        
                    
                        self.selectedIndexPathShipping = tag
                        self.applyCouponCode(couponCode: "", waletPoint: "", paymentMode: "")
                        cell.shippingAddressCollectionView.reloadData()
//
                }
                
                return cell
                
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: BillingAddressSameAsShippingTVC.cellIdentifierBillingAddressSameAsShippingTVC, for: indexPath) as! BillingAddressSameAsShippingTVC
                cell.selectionStyle = .none
                cell.btnActionCell = {tag in
                    cell.isSelectedCell.toggle()
                    if cell.isSelectedCell{
                        self.isShippingByHub = "Mumbai"
                        
                    }
                    else{
                        self.isShippingByHub = ""
                    }
                    
                    CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
                 
                    self.getCheckOutDetailsAPI { success in
                        // Leave the group when the API call is complete
                      //self.shippingTableView.reloadSections(IndexSet(integer: 4), with: .none)
                        self.setupPriceManage()
                        self.shippingTableView.reloadData()
                        CustomActivityIndicator2.shared.hide()
                     
                    }
                }
                return cell
            case 1:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: ShippingAddressListingTVC.cellIdentifierShippingAddressListingTVc, for: indexPath) as! ShippingAddressListingTVC
                cell.lblHeaderTitle.text = "Choose a different billing address"
                cell.updateDataIncell(cellData: self.billingAddressesStruct)
                cell.selectionStyle = .none
                cell.btnActionAddAddress = {
                    self.gotoAddAddress(index: 0)
                }
                
                
                if let selected = self.selectedIndexPathBilling {
                    cell.selectedIndexPath = selected
                    cell.ischangeAddress = true
                }
                
                cell.btnActionEdit = { index in
                    if  let data = self.billingAddressesStruct.details{
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "BillingAddress", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "AddBillingAddress") as! AddBillingAddress
                        vc.delegate = self
                        vc.isEdit = true
                     
                        vc.dataObj = data[index]
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                       // self.navigationManager(AddBillingAddress.self, storyboardName: "BillingAddress", storyboardID: "AddBillingAddress", data: data[index])
                    }
                }
                
    
                
                cell.btnActionCell22 = { tag in
                  
                        if let selected = self.selectedIndexPathBilling {
                            tableView.deselectRow(at: selected, animated: true)
                        }
                        
                        self.selectedIndexPathBilling = tag
                        self.applyCouponCode(couponCode: "", waletPoint: "", paymentMode: "")
                        cell.shippingAddressCollectionView.reloadData()
                }
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: OrderSummeryWithItemTVC.cellIdentifierOrderSummeryWithItemTVC, for: indexPath) as! OrderSummeryWithItemTVC
                cell.selectionStyle = .none
                cell.baseVC = self
                cell.currencyRateDetailObj = currencyRateDetailObj
                cell.setupData(checkOutData: self.checkOutDetails, isPaymentSection: self.manageTopButtonTag)
                cell.reloadCollection(cartData: self.CartDataObj, singleDimd: self.diamondDetailsOBJ)
              
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            
            switch indexPath.section {
            case 0:
                if !isresubmitTag{
                    let cell = tableView.dequeueReusableCell(withIdentifier: KYCDocStatusTVC.cellIdentifierShippingKYCDocStatusTVC, for: indexPath) as! KYCDocStatusTVC
                    cell.selectionStyle = .none
                    cell.baseVCObj(vc: self)
                    cell.btnActionResubmit = {
                        self.btnProceadPayment.setTitle("Submit", for: .normal)

                        self.isresubmitTag = true
                        self.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
                    }
                    
                    cell.reloadTBLE = { data in
                        cell.kycDocDataStruct = data
                        self.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
                        
                    }
                    
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: KYCDocResubmittedTVC.cellIdentifierKYCDocResubmittedTVC, for: indexPath) as! KYCDocResubmittedTVC
                    cell.selectionStyle = .none
                    cell.baseVCObj(vc: self)
                    cell.btnAction = { tag in
                        if tag == 0 {
                            self.btnProceadPayment.setTitle("Continue", for: .normal)
                            self.isresubmitTag = false
                           //
                            self.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
                            let topIndexPath = IndexPath(row: 0, section: 0)
                            if self.shippingTableView.numberOfSections > 0 && self.shippingTableView.numberOfRows(inSection: 0) > 0 {
                                // Scroll to the top row in section 0
                                self.shippingTableView.scrollToRow(at: topIndexPath, at: .top, animated: true)
                            }
                        }
                        else{
                            
                        }
                    }
                    return cell
                }
               
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: OrderSummeryWithItemTVC.cellIdentifierOrderSummeryWithItemTVC, for: indexPath) as! OrderSummeryWithItemTVC
                cell.selectionStyle = .none
                cell.currencyRateDetailObj = currencyRateDetailObj
                cell.setupData(checkOutData: self.checkOutDetails, isPaymentSection: self.manageTopButtonTag)
                cell.reloadCollection(cartData: self.CartDataObj, singleDimd: self.diamondDetailsOBJ)
                return cell
            }
            
        case 2:
            
//            if self.indexSectionCnt == 5{
                switch indexPath.section {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: PointsInfoTVC.cellIdentifierPointsInfoTVC, for: indexPath) as! PointsInfoTVC
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.lblTotalWalletPoints.text = "Available \(self.checkOutDetails.availableWalletPoints ?? "") Points"
                    cell.btnAction = { tag in
                        self.isCellExpandedPointsView.toggle()
                        cell.pointsView(isShow: self.isCellExpandedPointsView)
                        self.shippingTableView.reloadData()
                    }
                    
                    
                    if self.checkOutDetails.walletPoint ?? 0 > 0 {
                        // if self.checkOutDetails.coupon_status == 1 {
                            cell.btnWalletPointVerify.isHidden = true
                            cell.btnWalletPointVerified.isHidden = false
                       // }
                     }
                    
                    cell.btnActionApply = {
                        self.view.endEditing(true)
                        if cell.txtWalletPoint.text?.count ?? 0 > 0{
                            self.walletPoints = cell.txtWalletPoint.text ?? ""
                            self.applyCouponCode(couponCode: self.checkOutDetails.couponCode ?? "", waletPoint: cell.txtWalletPoint.text?.replacingOccurrences(of: " ", with: "") ?? "", paymentMode: self.paymentModeSelected)
                        }
                        else{
                            self.toastMessage("Enter Wallet Point")
                        }
                    }
                    
                    
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: CouponInfoTVC.cellIdentifierCouponInfoTVC, for: indexPath) as! CouponInfoTVC
                    cell.selectionStyle = .none
                    cell.delegate = self
                   if self.checkOutDetails.isCoupanApplied == 1{
                       // if self.checkOutDetails. == 1 {
                      if self.checkOutDetails.coupenStatus == 1 {
                           cell.btnPointVeryfy.isHidden = true
                           cell.btnPointVeryfied.isHidden = false
                       }
                       else{
                           cell.btnPointVeryfy.isHidden = false
                           cell.btnPointVeryfied.isHidden = true
                           self.toastMessage(self.checkOutDetails.couperMSG ?? "")
                       }
                       
                       
                          
                      // }
                    }
                    
                    cell.btnAction = {
                        self.view.endEditing(true)
                        if cell.txtCouponCode.text?.count ?? 0 > 0{
                            self.couponCode = cell.txtCouponCode.text ?? ""
                            self.applyCouponCode(couponCode: cell.txtCouponCode.text?.replacingOccurrences(of: " ", with: "") ?? "", waletPoint: "\(self.checkOutDetails.walletPoint ?? 0)", paymentMode: self.paymentModeSelected)
                        }
                        else{
                            self.toastMessage("Enter coupon code")
                        }
                    }
                    
                    cell.btnActionViewAll = {
                        let bottomSheetVC = CouponListVC()
                        bottomSheetVC.delegate = self
                        bottomSheetVC.appear(sender: self)
                    }
                    
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: PaymentOptionTVC.cellIdentifierPaymentOptionTVC, for: indexPath) as! PaymentOptionTVC
                    cell.selectionStyle = .none
                    cell.buttonGroup.delegate = self
                    
    //                cell.viewNetBnkBG.isHidden = true
    //                cell.viewCreditCrdBG.isHidden = true
    //
                    
                    cell.shippingVC = self
                    
                    if let netBnk = bankingInfoStruct.details?.netBanking{
                        cell.netBankingData = netBnk
                        cell.banksCollectionView.reloadData()
                    }
                    
                    
                    cell.selectBankAction = {
                        if let allBnks = self.bankingInfoStruct.details?.netBanking?.allBanks {
                            var bankArr = [String]()
                            allBnks.enumerated().forEach{ (index, bank) in
                                bankArr.append(bank.bankName ?? "")
                            }
                            self.isOpenNEFT = false
                            self.openDropDown(dataArr: bankArr, anchorView: cell.txtSelectedBnk, txtField: cell.txtSelectedBnk)
                        }
                      
                    }
                    
                    cell.bnkCellTap = { tag in
                       
                            if let netBankInfo = self.bankingInfoStruct.details?.netBanking?.popularBanks {
                                //var selectedIndex = netBankInfo.popularBanks?[indexPath.row].img
                                self.selectedBankID  = netBankInfo[tag].bankID ?? ""
                                cell.txtSelectedBnk.text = netBankInfo[tag].bankName
                            }
                        
                    }
                    
                    
                        
                        if isAmountLess1L{
                            cell.viewUPIBG.isHidden = true
                            self.paymentModeSelected = String()
                            self.selectedUPIName = String()
                            self.selectedUPIBundl = String()
                            self.amountCalculation()
                        }
                        else{
                            cell.viewUPIBG.isHidden = false
                        }
                        
                    
                    cell.btnAction = { tag in
                        self.isCellExpandedTag = tag
                      
                        if tag == 0 {
                            cell.selectedIndexPathUPI = nil
                            self.isCellExpandedPaymentOption.toggle()
                            cell.paymentOptionViewHideShow(isShow: self.isCellExpandedPaymentOption)
                            cell.banksViewBG.isHidden = true
                            cell.viewUPIListBG.isHidden = true
                            self.isCellExpandedPaymentOption2 = false
                            self.isCellExpandedPaymentOption3 = false
                            self.shippingTableView.reloadData()
                            
                        }
                        else if tag == 2{
                            cell.selectedIndexPathUPI = nil
                            cell.paymentOptionBG.isHidden = true
                            cell.viewUPIListBG.isHidden = true
                            self.isCellExpandedPaymentOption = false
                            self.isCellExpandedPaymentOption3 = false
                            self.isCellExpandedPaymentOption2.toggle()
                            cell.bnkViewHideShow(isShow: self.isCellExpandedPaymentOption2)
    //                        if let netBankInfo = self.bankingInfoStruct.details?.netBanking {
    //                            cell.netBankingData = netBankInfo
    //                            cell.banksCollectionView.reloadData()
    //                        }
                            
                           
                            self.shippingTableView.reloadData()
                        }
                        else if tag == 1{
                            cell.selectedIndexPathUPI = nil
                            cell.paymentOptionBG.isHidden = true
                            cell.viewUPIListBG.isHidden = true
                            self.isCellExpandedPaymentOption = false
                            self.isCellExpandedPaymentOption2 = false
                            self.isCellExpandedPaymentOption3 = false
                           
                            cell.banksViewBG.isHidden = true
                            self.shippingTableView.reloadData()
                        }
                        else{
                            cell.collectionUPIApps.reloadData()
                            cell.paymentOptionBG.isHidden = true
                            cell.banksViewBG.isHidden = true
                            self.isCellExpandedPaymentOption = false
                            self.isCellExpandedPaymentOption2 = false
                            self.isCellExpandedPaymentOption3.toggle()
                            cell.UPIViewHideShow(isShow: self.isCellExpandedPaymentOption3)
                            
                            
                            
                            self.shippingTableView.reloadData()
                        }
                        
//                        let UPIIndexPath = IndexPath(row: 0, section: 2)
//                        if let cell = self.customPaymentTV.cellForRow(at: UPIIndexPath) as? UPITVC {
//                            cell.selectedIndexPath = nil
//                            cell.collectionUPIApps.reloadData()
//                        }
                    }
                    
                    cell.lblIFSC.text = self.bankInfoStruct.details?.first?.ifsc
                    cell.lblSWIFT.text = self.bankInfoStruct.details?.first?.swift
                    cell.lblBranchName.text = self.bankInfoStruct.details?.first?.branchName
                    cell.lblBankName.text = self.bankInfoStruct.details?.first?.bankName
                    cell.lblAccountNum.text = self.bankInfoStruct.details?.first?.accountNumber
                    
                    cell.lblTitle1.text = self.bankInfoStruct.details?.first?.bank?.uppercased()
                    cell.lblTitle2.text = self.bankInfoStruct.details?.last?.bank?.uppercased()
                    
                    
                    cell.btnActionBanks = { tag in
                        self.seletedBankInt = tag
                       // if tag == 0{
                            cell.lblIFSC.text = self.bankInfoStruct.details?[tag].ifsc
                            cell.lblSWIFT.text = self.bankInfoStruct.details?[tag].swift
                            cell.lblBranchName.text = self.bankInfoStruct.details?[tag].branchName
                            cell.lblBankName.text = self.bankInfoStruct.details?[tag].bankName
                            cell.lblAccountNum.text = self.bankInfoStruct.details?[tag].accountNumber
//                        }
//                        else{
//                            cell.lblIFSC.text = self.bankInfoStruct.details?.last?.ifsc
//                            cell.lblSWIFT.text = self.bankInfoStruct.details?.last?.swift
//                            cell.lblBranchName.text = self.bankInfoStruct.details?.last?.branchName
//                            cell.lblBankName.text = self.bankInfoStruct.details?.last?.bankName
//                            cell.lblAccountNum.text = self.bankInfoStruct.details?.last?.accountNumber
//                        }
                    }
                    
                    cell.btnDate = {
                        self.customDatePicker.delegate = self
                        self.customDatePicker.showDatePicker(in: self)
                        
                    }
                    
                    
                    if  let imageURLfst = URL(string: self.bankInfoStruct.details?[self.seletedBankInt].image ?? "") {
                        cell.btnBank1SBG.applyVerticalGradientBackgroundWithImageURL(colors: [UIColor.btnGradient1, UIColor.btnGradient2], imageURL: imageURLfst)
                        cell.imgViewBnk1.sd_setImage(with: imageURLfst, placeholderImage: nil, options: .highPriority, completed: nil)
                    }
                    
                    cell.tapActionUPI = { name, package in
                       
                        self.paymentModeSelected = "UPI"
                        self.selectedUPIName = name
                        self.selectedUPIBundl = package
                        //self.amountCalculation()
                       
                        if name == ""{
                            
                            self.lblTotalAmount.text = self.amount
                            self.shippingTableView.reloadData()
                            // self.customPaymentTV.reloadRows(at: [payIndexPath], with: .none)
                        }
                    }
                    
                    cell.paymentModeAction = {
                        self.isOpenNEFT = true
                        self.openDropDown(dataArr: ["Cheque","NEFT","RTGS","Wire Transfer", "Other"], anchorView: cell.txtPaymentMode, txtField: cell.txtPaymentMode)
                    }
                    
                    
                    
                    return cell
//                case 3:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: UPITVC.cellIdentifierUPITVC, for: indexPath) as! UPITVC
//                    cell.selectionStyle = .none
//                    cell.tapAction = { name, package in
//                        let formattedNumber = self.formatNumberWithoutDeciml(Double(self.amount) ?? 0)
//                        self.lblTotalAmount.text = formattedNumber
//                        
//                        let payIndexPath = IndexPath(row: 0, section: 2)
//                        if let cell = self.shippingTableView.cellForRow(at: payIndexPath) as? PaymentOptionTVC {
//                            cell.buttonGroup.clearSelection()
//                            cell.btnNetBankSBG.borderColor = .clear
//                            cell.btnRTGSBG.borderColor = .clear
//                            cell.btnDebitCSBG.borderColor = .clear
//                            cell.paymentOptionBG.isHidden = true
//                            cell.banksViewBG.isHidden = true
//                            self.isCellExpandedPaymentOption = false
//                            self.isCellExpandedPaymentOption2 = false
//                            self.shippingTableView.reloadData()
//                            
//                           // self.customPaymentTV.reloadRows(at: [payIndexPath], with: .none)
//                        }
//                        
//                        ///
//                        self.paymentModeSelected = "UPI"
//                        self.selectedUPIName = name
//                        self.selectedUPIBundl = package
//                        self.amountCalculation()
//                        
//                        if name == ""{
//                            let formattedNumber = self.formatNumberWithoutDeciml(Double(self.amount) ?? 0)
//                            self.lblTotalAmount.text = formattedNumber
//                            
//                          //  self.lblTotalAmount.text = self.amount
//                            self.shippingTableView.reloadData()
//                            // self.customPaymentTV.reloadRows(at: [payIndexPath], with: .none)
//                        }
//                    }
//                    return cell
                    
                case 3:
                    let cell = tableView.dequeueReusableCell(withIdentifier: OrderSummeryWithItemTVC.cellIdentifierOrderSummeryWithItemTVC, for: indexPath) as! OrderSummeryWithItemTVC
                    cell.selectionStyle = .none
                    cell.baseVC = self
                    cell.currencyRateDetailObj = currencyRateDetailObj
                    cell.setupData(checkOutData: self.checkOutDetails, isPaymentSection: self.manageTopButtonTag)
                    cell.reloadCollection(cartData: self.CartDataObj, singleDimd: self.diamondDetailsOBJ)
                    return cell
                    
                default:
                   return UITableViewCell()
                }
//            }
//            else{
//                switch indexPath.section {
//                case 0:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: PointsInfoTVC.cellIdentifierPointsInfoTVC, for: indexPath) as! PointsInfoTVC
//                    cell.selectionStyle = .none
//                    cell.delegate = self
//                    cell.lblTotalWalletPoints.text = "Available \(self.checkOutDetails.availableWalletPoints ?? "") Points"
//                    cell.btnAction = { tag in
//                        self.isCellExpandedPointsView.toggle()
//                        cell.pointsView(isShow: self.isCellExpandedPointsView)
//                        self.shippingTableView.reloadData()
//                    }
//                    
//                    
//                    if self.checkOutDetails.walletPoint ?? 0 > 0 {
//                        // if self.checkOutDetails.coupon_status == 1 {
//                            cell.btnWalletPointVerify.isHidden = true
//                            cell.btnWalletPointVerified.isHidden = false
//                       // }
//                     }
//                    
//                    cell.btnActionApply = {
//                        self.view.endEditing(true)
//                        if cell.txtWalletPoint.text?.count ?? 0 > 0{
//                            self.walletPoints = cell.txtWalletPoint.text ?? ""
//                            self.applyCouponCode(couponCode: self.checkOutDetails.couponCode ?? "", waletPoint: cell.txtWalletPoint.text?.replacingOccurrences(of: " ", with: "") ?? "", paymentMode: self.paymentModeSelected)
//                        }
//                        else{
//                            self.toastMessage("Enter Wallet Point")
//                        }
//                    }
//                    
//                    
//                    return cell
//                case 1:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: CouponInfoTVC.cellIdentifierCouponInfoTVC, for: indexPath) as! CouponInfoTVC
//                    cell.selectionStyle = .none
//                    cell.delegate = self
//                    
//                   if self.checkOutDetails.isCoupanApplied == 1{
//                       
//                       if self.checkOutDetails.coupenStatus == 1 {
//                            cell.btnPointVeryfy.isHidden = true
//                            cell.btnPointVeryfied.isHidden = false
//                        }
//                        else{
//                            cell.btnPointVeryfy.isHidden = false
//                            cell.btnPointVeryfied.isHidden = true
//                            self.toastMessage(self.checkOutDetails.couperMSG ?? "")
//                        }
//                       // if self.checkOutDetails. == 1 {
////                           cell.btnPointVeryfy.isHidden = true
////                           cell.btnPointVeryfied.isHidden = false
//                      // }
//                    }
//                    
//                    cell.btnAction = {
//                        self.view.endEditing(true)
//                        if cell.txtCouponCode.text?.count ?? 0 > 0{
//                            self.couponCode = cell.txtCouponCode.text ?? ""
//                            self.applyCouponCode(couponCode: cell.txtCouponCode.text?.replacingOccurrences(of: " ", with: "") ?? "", waletPoint: "\(self.checkOutDetails.walletPoint ?? 0)", paymentMode: self.paymentModeSelected)
//                        }
//                        else{
//                            self.toastMessage("Enter coupon code")
//                        }
//                    }
//                    return cell
//                case 2:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: PaymentOptionTVC.cellIdentifierPaymentOptionTVC, for: indexPath) as! PaymentOptionTVC
//                    cell.selectionStyle = .none
//                    cell.buttonGroup.delegate = self
//                    
//                    if self.isAmountLess1L{
//                        cell.viewNetBnkBG.isHidden = true
//                        cell.viewCreditCrdBG.isHidden = true
//                    }
//                    else{
//                        cell.viewNetBnkBG.isHidden = false
//                        cell.viewCreditCrdBG.isHidden = false
//                    }
//                    
//                   
//    //
//                    
//                    cell.shippingVC = self
//                    
//                    if let netBnk = bankingInfoStruct.details?.netBanking{
//                        cell.netBankingData = netBnk
//                        cell.banksCollectionView.reloadData()
//                    }
//                    
//                    
//                    cell.selectBankAction = {
//                        if let allBnks = self.bankingInfoStruct.details?.netBanking?.allBanks {
//                            var bankArr = [String]()
//                            allBnks.enumerated().forEach{ (index, bank) in
//                                bankArr.append(bank.bankName ?? "")
//                            }
//                            self.isOpenNEFT = false
//                            self.openDropDown(dataArr: bankArr, anchorView: cell.txtSelectedBnk, txtField: cell.txtSelectedBnk)
//                        }
//                      
//                    }
//                    
//                    cell.bnkCellTap = { tag in
//                       
//                            if let netBankInfo = self.bankingInfoStruct.details?.netBanking?.popularBanks {
//                                // var selectedIndex = netBankInfo.popularBanks?[indexPath.row].img
//                                self.selectedBankID  = netBankInfo[tag].bankID ?? ""
//                                cell.txtSelectedBnk.text = netBankInfo[tag].bankName
//                            }
//                        
//                    }
//                    
//                    cell.btnAction = { tag in
//                        self.isCellExpandedTag = tag
//                      
//                        if tag == 0 {
//                            
//                            self.isCellExpandedPaymentOption.toggle()
//                            cell.paymentOptionViewHideShow(isShow: self.isCellExpandedPaymentOption)
//                            cell.banksViewBG.isHidden = true
//                            self.isCellExpandedPaymentOption2 = false
//                            //self.shippingTableView.reloadData()
//                            
//                          
//                            
//                        }
//                        else if tag == 2{
//                            cell.paymentOptionBG.isHidden = true
//                            self.isCellExpandedPaymentOption = false
//                            self.isCellExpandedPaymentOption2.toggle()
//                            cell.bnkViewHideShow(isShow: self.isCellExpandedPaymentOption2)
//    //                        if let netBankInfo = self.bankingInfoStruct.details?.netBanking {
//    //                            cell.netBankingData = netBankInfo
//    //                            cell.banksCollectionView.reloadData()
//    //                        }
//                            
//                    
//                        }
//                        else{
//                            
//                            cell.paymentOptionBG.isHidden = true
//                            self.isCellExpandedPaymentOption = false
//                            self.isCellExpandedPaymentOption2 = false
//                           
//                            cell.banksViewBG.isHidden = true
//                            //self.shippingTableView.reloadData()
//                        }
//                        
//                        let UPIIndexPath = IndexPath(row: 0, section: 2)
//                        if let cell = self.shippingTableView.cellForRow(at: UPIIndexPath) as? UPITVC {
//                            cell.selectedIndexPath = nil
//                            cell.collectionUPIApps.reloadData()
//                        }
//                    }
//                    
//                    cell.lblIFSC.text = self.bankInfoStruct.details?.first?.ifsc
//                    cell.lblSWIFT.text = self.bankInfoStruct.details?.first?.swift
//                    cell.lblBranchName.text = self.bankInfoStruct.details?.first?.branchName
//                    cell.lblBankName.text = self.bankInfoStruct.details?.first?.bankName
//                    cell.lblAccountNum.text = self.bankInfoStruct.details?.first?.accountNumber
//                    
//                    cell.lblTitle1.text = self.bankInfoStruct.details?.first?.bank?.uppercased()
//                    cell.lblTitle2.text = self.bankInfoStruct.details?.last?.bank?.uppercased()
//                    
//                    
//                    cell.btnActionBanks = { tag in
//                        self.seletedBankInt = tag
//                        if tag == 0{
//                            cell.lblIFSC.text = self.bankInfoStruct.details?.first?.ifsc
//                            cell.lblSWIFT.text = self.bankInfoStruct.details?.first?.swift
//                            cell.lblBranchName.text = self.bankInfoStruct.details?.first?.branchName
//                            cell.lblBankName.text = self.bankInfoStruct.details?.first?.bankName
//                            cell.lblAccountNum.text = self.bankInfoStruct.details?.first?.accountNumber
//                        }
//                        else{
//                            cell.lblIFSC.text = self.bankInfoStruct.details?.last?.ifsc
//                            cell.lblSWIFT.text = self.bankInfoStruct.details?.last?.swift
//                            cell.lblBranchName.text = self.bankInfoStruct.details?.last?.branchName
//                            cell.lblBankName.text = self.bankInfoStruct.details?.last?.bankName
//                            cell.lblAccountNum.text = self.bankInfoStruct.details?.last?.accountNumber
//                        }
//                    }
//                    
//                    cell.btnDate = {
//                        self.customDatePicker.delegate = self
//                        self.customDatePicker.showDatePicker(in: self)
//                        
//                    }
//                    
//                    
//                    if  let imageURLfst = URL(string: self.bankInfoStruct.details?.first?.image ?? "") {
//                        cell.btnBank1SBG.applyVerticalGradientBackgroundWithImageURL(colors: [UIColor.btnGradient1, UIColor.btnGradient2], imageURL: imageURLfst)
//                        cell.imgViewBnk1.sd_setImage(with: imageURLfst, placeholderImage: nil, options: .highPriority, completed: nil)
//                    }
//                    
//                    
//                    if  let imageURLlst = URL(string: self.bankInfoStruct.details?.last?.image ?? "") {
//                        cell.btnBank2BG.applyVerticalGradientBackgroundWithImageURL(colors: [UIColor.btnGradient1, UIColor.btnGradient2], imageURL: imageURLlst)
//                        
//                        cell.imgViewBnk2.sd_setImage(with: imageURLlst, placeholderImage: nil, options: .highPriority, completed: nil)
//                        
//                    }
//                    
//                    cell.paymentModeAction = {
//                        self.isOpenNEFT = true
//                        self.openDropDown(dataArr: ["Cheque","NEFT","RTGS","Wire Transfer", "Other"], anchorView: cell.txtPaymentMode, txtField: cell.txtPaymentMode)
//                    }
//                    
//                    
//                    
//                    return cell
////                case 3:
////                    let cell = tableView.dequeueReusableCell(withIdentifier: UPITVC.cellIdentifierUPITVC, for: indexPath) as! UPITVC
////                    cell.selectionStyle = .none
////                    cell.tapAction = { name, package in
////                        let formattedNumber = self.formatNumberWithoutDeciml(Double(self.amount) ?? 0)
////                        self.lblTotalAmount.text = formattedNumber
////                        
////                        let payIndexPath = IndexPath(row: 0, section: 2)
////                        if let cell = self.shippingTableView.cellForRow(at: payIndexPath) as? PaymentOptionTVC {
////                            cell.buttonGroup.clearSelection()
////                            cell.btnNetBankSBG.borderColor = .clear
////                            cell.btnRTGSBG.borderColor = .clear
////                            cell.btnDebitCSBG.borderColor = .clear
////                            cell.paymentOptionBG.isHidden = true
////                            cell.banksViewBG.isHidden = true
////                            self.isCellExpandedPaymentOption = false
////                            self.isCellExpandedPaymentOption2 = false
////                            self.shippingTableView.reloadData()
////                            
////                           // self.customPaymentTV.reloadRows(at: [payIndexPath], with: .none)
////                        }
////                        
////                        ///
////                        self.paymentModeSelected = "UPI"
////                        self.selectedUPIName = name
////                        self.selectedUPIBundl = package
////                        self.amountCalculation()
////                        
////                        if name == ""{
////                            let formattedNumber = self.formatNumberWithoutDeciml(Double(self.amount) ?? 0)
////                            self.lblTotalAmount.text = formattedNumber
////                            
////                          //  self.lblTotalAmount.text = self.amount
////                            self.shippingTableView.reloadData()
////                            // self.customPaymentTV.reloadRows(at: [payIndexPath], with: .none)
////                        }
////                    }
////                    return cell
//                default:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: OrderSummeryWithItemTVC.cellIdentifierOrderSummeryWithItemTVC, for: indexPath) as! OrderSummeryWithItemTVC
//                    cell.selectionStyle = .none
//                    cell.baseVC = self
//                    cell.currencyRateDetailObj = currencyRateDetailObj
//                    cell.setupData(checkOutData: self.checkOutDetails, isPaymentSection: self.manageTopButtonTag)
//                    cell.reloadCollection(cartData: self.CartDataObj, singleDimd: self.diamondDetailsOBJ)
//                    return cell
//                }
//            }
            
            
            
        default:
            return UITableViewCell()
        }
        
       // return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.manageTopButtonTag {
        case 2:
            switch indexPath.section {
            case 0:
                return isCellExpandedPointsView ? 210 : 70
//            case 3:
//                return isCellExpandedPaymentOption3 ? 280 : 190
            default:
                return UITableView.automaticDimension
            }
                
        default:
            return UITableView.automaticDimension
        }
         
    }
    

    
//    @IBAction func btnActionPayment(_ sender:UIButton){
//        self.navigationManager(storybordName: "PaymentModule", storyboardID: "PaymentModuleVC", controller: PaymentModuleVC())
//    }
    
    func gotoAddAddress(index:Int){
        if index == 0{
           // self.navigationManager(storybordName: "BillingAddress", storyboardID: "AddBillingAddress", controller: AddBillingAddress())
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "BillingAddress", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddBillingAddress") as! AddBillingAddress
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "ShippingAddress", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddShippingAddressVC") as! AddShippingAddressVC
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
          //  self.navigationManager(storybordName: "ShippingAddress", storyboardID: "AddShippingAddressVC", controller: AddShippingAddressVC())
        }
    }

    
}

extension ShippingModuleVC :  AddAddressDelegate, CouponCodeDelegate{
    func applyCouponObj(dataObj: CouponListDetail, text: String) {
        let indexPath = IndexPath(row: 0, section: 1)
        if let cell = self.shippingTableView.cellForRow(at: indexPath) as? CouponInfoTVC {
            cell.txtCouponCode.text = dataObj.code
            self.couponCode = cell.txtCouponCode.text ?? ""
            self.applyCouponCode(couponCode: cell.txtCouponCode.text?.replacingOccurrences(of: " ", with: "") ?? "", waletPoint: "\(self.checkOutDetails.walletPoint ?? 0)", paymentMode: self.paymentModeSelected)
            
        }
    }
    
    func didUpdateAPISuccessfully(message: String) {
        print(message)
        if message == "Shipping"{
            self.getShippingAddressAPICalling { success in
                if isDefalutShipping {
                    self.shippingAddUpdate = true
                }
                self.shippingCountry = String()
                self.selectedIndexPathShipping = nil
                self.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
                self.applyCouponCode(couponCode: "", waletPoint: "", paymentMode: "")
            }
            
        }
        else{
            self.getBillingAddressAPICalling { success in
                if isDefalutBilling {
                    self.billingAddUpdate = true
                }
                
                self.billingCountry = String()
                self.selectedIndexPathBilling = nil
                self.shippingTableView.reloadSections(IndexSet(integer: 1), with: .none)
                self.applyCouponCode(couponCode: "", waletPoint: "", paymentMode: "")
            }
           
        }
       
    }
    
    
}



extension ShippingModuleVC : SingleSelectionButtonGroupDelegate , CustomDatePickerDelegate, TextFieldUpdateDelegate{
    func didUpdateText(_ text: String, tag: Int) {
        if tag == 0{
            let indexPath = IndexPath(row: 0, section: 0)
            if let cell = self.shippingTableView.cellForRow(at: indexPath) as? PointsInfoTVC {
                //cell.ifUpdatePoint = false
                if cell.btnWalletPointVerify.isHidden {
                    if text.count <= 0{
                        self.applyCouponCode(couponCode: self.checkOutDetails.couponCode ?? "", waletPoint: "", paymentMode: self.paymentModeSelected)
                        cell.btnWalletPointVerify.isHidden = false
                        cell.btnWalletPointVerified.isHidden = true
                    }
                    
                }

            }
        }
        else{
            let indexPath = IndexPath(row: 0, section: 1)
            if let cell = self.shippingTableView.cellForRow(at: indexPath) as? CouponInfoTVC {
                //cell.ifUpdatePoint = false
               
                if cell.btnPointVeryfy.isHidden {
                    if text.count <= 0{
                        self.applyCouponCode(couponCode: "", waletPoint: "\(self.checkOutDetails.walletPoint ?? 0)", paymentMode: self.paymentModeSelected)
                        cell.btnPointVeryfy.isHidden = false
                        cell.btnPointVeryfied.isHidden = true
                    }
                    
                }

            }
        }
    }
    
  
    
    func didSelectDate(date: String) {
            let indexPath = IndexPath(row: 0, section: 2)
            if let cell = self.shippingTableView.cellForRow(at: indexPath) as? PaymentOptionTVC {
                cell.txtChecqDate.text = date
                
            }
     
    }
    func didSelectButton(withTag tag: Int?) {
        
        //'NEFT','DebitCard','CreditCard','NetBanking','UPI'
        switch tag {
        case 0:
            self.paymentModeSelected = "NEFT"
        case 1:
            self.paymentModeSelected = "CreditCard"
        case 2:
            self.paymentModeSelected = "NetBanking"
        case 3:
            self.paymentModeSelected = "UPI"
        default:
            self.paymentModeSelected = String()
        }
        
        self.applyCouponCode(couponCode: self.checkOutDetails.couponCode ?? "", waletPoint: "\(self.checkOutDetails.walletPoint ?? 0)", paymentMode: self.paymentModeSelected)
        
        //amountCalculation()
        //print(tag)
    }
    
    
    
//    func textFieldDidEndEditing(cell: CustomInfoTVC, text: String) {
//          print(text)
//        self.amountTotal = text
//        self.lblTotalAmount.text = "₹\(self.amountTotal)"
//       }
    
    
    
    func amountCalculation(){
        let baseAmount: Double = Double(self.checkOutDetails.totalAmount ?? 0)
       
        switch self.paymentModeSelected {
        case "CreditCard":
           let percentage = self.bankChargesInfoStruct.details?.creditCard
            let calculatedAmount = baseAmount + (baseAmount * (percentage ?? 0)  / 100)
            let formattedNumber = self.formatNumberWithoutDeciml(Double(calculatedAmount))
            //self.lblTotalAmount.text = formattedNumber
            self.lblTotalAmount.text = "₹\(formattedNumber)"
        case "NetBanking":
            let percentage = self.bankChargesInfoStruct.details?.netBanking
            let calculatedAmount = baseAmount + (baseAmount * (percentage ?? 0) / 100)
            //self.lblTotalAmount.text = "₹\(calculatedAmount)"
            let formattedNumber = self.formatNumberWithoutDeciml(Double(calculatedAmount))
            //self.lblTotalAmount.text = formattedNumber
            self.lblTotalAmount.text = "₹\(formattedNumber)"
        case "UPI":
            let percentage = self.bankChargesInfoStruct.details?.upi
            let  calculatedAmount = baseAmount + (baseAmount * Double((percentage ?? 0 )) / 100)
           // self.lblTotalAmount.text = "₹\(calculatedAmount)"
            let formattedNumber = self.formatNumberWithoutDeciml(Double(calculatedAmount))
            //self.lblTotalAmount.text = formattedNumber
            self.lblTotalAmount.text = "₹\(formattedNumber)"
        default:
            self.lblTotalAmount.text = "₹\(self.amountTotal)"
            
            let formattedNumber = self.formatNumberWithoutDeciml(Double(self.amountTotal) ?? 0)
            //self.lblTotalAmount.text = formattedNumber
            self.lblTotalAmount.text = "₹\(formattedNumber)"
        }
    }
    
    
}
