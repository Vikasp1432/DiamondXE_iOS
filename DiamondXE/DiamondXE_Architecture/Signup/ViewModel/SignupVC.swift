//
//  SignupVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/04/24.
//

import UIKit
import DropDown
import SDWebImage



class SignupVC: BaseViewController {
    
    @IBOutlet var tableViewSingup:UITableView!
    @IBOutlet var btnBuyer:UIButton!
    @IBOutlet var btnDealer:UIButton!
    @IBOutlet var btnSupplier:UIButton!
    @IBOutlet var viewBGButtons:UIView!
    @IBOutlet var lblHeading:UILabel!
    
  

   // let userTypeManager = UserTypeManager()
    var userType = Int()
    var isCellExpandedKYC = false
    var isCellExpandedBasic = false
    
    var isCellExpandedOtherD = false
    var isCellExpandedCompanyD = true
    
    var isCellExpandedInternlKYC = false
    var isIndiaPin = true
    var isIndiaPinForSupplir = true
    var isCellExpandedAuthPersion = false
    
   
    
//    var isCellExpandedSuppKYC = false
    var isCellExpandedSuppIntKYC = false
    var isCellExpandedSuppOtherD = false
    var isCellExpandedBankInfo = false
    var isCellExpandedAuthoriseInfo = false
    var isCellExpandedSuppCompanyD = true
    
    // struct model data object variables
    var buyerDataParam : BuyerParamDataStruct?
    var signupResponceStruct = SignupReponceDataStruct()
    let dropDown = DropDown()
    
    // dealer signup
    var dealerDataStruct = DealerSignupDataStruct()
    
    // suplier signup
    var suplierDataStruct = SupplierSignupDataStruct()

    
    var countryId = 101
    var btnTag = 0
    var stateID : Int?
    var stateName : String?
    
    var cityID : Int?
    var cityName : String?
    
    var isEmailVerified = 1
   
    
    // doc base64
    var adharFront : String?
    var adharBack : String?
    var panFront : String?
    
    var passportFront : String?
    var passportBack : String?
    var drivLicence : String?
    
    var businessLicenNum : String?
    var iECDoc : String?
    
   
    
    //company details
    var companyGST : String?
    var companyPAN : String?
    var companyIEC : String?
    var companyTrade : String?
    var businessLicenceDoc : String?
    var isDataCellHide = true
    var otheraDocList = [String]()
    
    //
    var dealerSection : Int?
    var supplierSection : Int?
    var supervisorContryCode : String?
    var supervisorContryFlag : String?
    var supplierCODetailContryCode : String?
    var supplierCODetailContryFlag : String?
    var isAdharVerify = false
    var isPanVerify = false
    var isGSTVerify = false
    var isBasicInfoEmailVerified = false
    var isCompanyDetailsEmailVerified = false
    var isCompanyDetailsPANVerified = false
    var isCompanyDetailsGSTVerified = false
    
    var isSupllierGSTVerified = false
    var isSupllierPANVerified = false
    var isSupllierEmailVerified = false
    var isSupllierPANDoc = false
    var isSupllierGSTDoc = false
    
    
    var aadharVerify = DocVerifyStruct()
    var panVerify = DocVerifyStruct()
    
    var companyGSTVerify = DocVerifyStruct()
    var companyPANVerify = DocVerifyStruct()
    
    
    var customDatePicker = CustomDatePicker()




    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.viewBGButtons.addBottomShadow()
//        self.navigationController?.isNavigationBarHidden = true
        
        btnBuyer.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])

       
        self.defineXIBUItableView()
        //get otherDoc
        self.getOtherDoc()
    }
    
    
    // define xib in uitableview
    func defineXIBUItableView(){
        // define buyer tableview cell
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.buyerCell1, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.buyerCell1)
        
        // define dealer tableview cell
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.dealer_KycCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.dealer_headerCell)
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.dealer_KycCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.dealer_KycCell)
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.dealer_BasicCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.dealer_BasicCell)
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.dealer_OtherDocCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.dealer_OtherDocCell)
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.dealer_CompanyDetailCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.dealer_CompanyDetailCell)
        tableViewSingup.register(UINib(nibName: OutherCountryKYC.cellIdentifierInternationalCell, bundle: nil), forCellReuseIdentifier: OutherCountryKYC.cellIdentifierInternationalCell)
        
        tableViewSingup.register(UINib(nibName: AuthorisedPersionKYCTVC.cellIdentifierAuthorisedPersionCell, bundle: nil), forCellReuseIdentifier: AuthorisedPersionKYCTVC.cellIdentifierAuthorisedPersionCell)
        
        
        // define supplier tableview cell
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.supplier_BankInfoCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.supplier_BankInfoCell)
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.supplier_AuthoriseInfoCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.supplier_AuthoriseInfoCell)
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.supplier_CompanyDetailCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.supplier_CompanyDetailCell)
        
        tableViewSingup.register(UINib(nibName: SupplierKYCTableViewCell.cellIdentifierSuppComKYC, bundle: nil), forCellReuseIdentifier: SupplierKYCTableViewCell.cellIdentifierSuppComKYC)
        
        tableViewSingup.register(UINib(nibName: SupplierINT_KYCTableViewCell.cellIdentifierSuppINT_KYC, bundle: nil), forCellReuseIdentifier: SupplierINT_KYCTableViewCell.cellIdentifierSuppINT_KYC)
        
        // footer cell
        tableViewSingup.register(UINib(nibName: TVCellIdentifire.fotterCell, bundle: nil), forCellReuseIdentifier: TVCellIdentifire.fotterCell)
        
    }
    
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldPlaceholderProertySet(){
//        self.txtNewPassword.placeholderColor = .themeClr
//        self.txtNewPassword.floatPlaceholderActiveColor = .themeClr
    }
    
    func openDropDown(dataArr:[String], anchorView:UIView, titleLabel:UITextField, refr:String){
        let dropDown = DropDown()
        dropDown.anchorView = anchorView
        dropDown.dataSource = dataArr
        dropDown.backgroundColor = .whitClr
        dropDown.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        dropDown.shadowColor = UIColor(white: 0.6, alpha: 1)
        dropDown.shadowOpacity = 0.7
        dropDown.shadowRadius = 15
        dropDown.cellHeight = 40
        
        if refr != "FCIntencity"{
            dropDown.height = 250
        }
       
       
//        dropDown.bottomOffset = CGPoint(x: 0, y: anchorView.bounds.height)
        if dropDown.dataSource.count > 10 {
                   dropDown.dismissMode = .onTap
                   dropDown.reloadAllComponents()
               }

        
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            titleLabel.text = dataArr[index]
            dropDown.hide()
            
        }
        dropDown.show()
    }
    
    
    @IBAction func btnActionEmialORMobile(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("buyer")
            btnBuyer.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnDealer.clearGradient()
            btnSupplier.clearGradient()
            userType = 0
            lblHeading.text = "Registering as a buyer, you can search for\nand buy any diamonds."
            self.btnBuyer.backgroundColor = .themeClr
            self.btnBuyer.setTitleColor(.whitClr, for: .normal)
            self.btnDealer.backgroundColor = .whitClr
            self.btnDealer.setTitleColor(.themeClr, for: .normal)
            self.btnSupplier.backgroundColor = .whitClr
            self.btnSupplier.setTitleColor(.themeClr, for: .normal)
            self.tableViewSingup.reloadData()
            
        case 1:
            print("dealer")
         

            
            btnDealer.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnBuyer.clearGradient()
            btnSupplier.clearGradient()
            userType = 1
            lblHeading.text = "Registering as a dealer enables you to receive\nadditional discounts on prices within the same trade."
            self.btnBuyer.backgroundColor = .whitClr
            self.btnBuyer.setTitleColor(.themeClr, for: .normal)
            self.btnDealer.backgroundColor = .themeClr
            self.btnDealer.setTitleColor(.whitClr, for: .normal)
            self.btnSupplier.backgroundColor = .whitClr
            self.btnSupplier.setTitleColor(.themeClr, for: .normal)
            self.tableViewSingup.reloadData()
            
            
           
            
        default:
            print("supplier")
            btnSupplier.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnDealer.clearGradient()
            btnBuyer.clearGradient()
            lblHeading.text = "Upload your stock and sell on the platform"
            userType = 2
            self.btnBuyer.backgroundColor = .whitClr
            self.btnBuyer.setTitleColor(.themeClr, for: .normal)
            self.btnDealer.backgroundColor = .whitClr
            self.btnDealer.setTitleColor(.themeClr, for: .normal)
            self.btnSupplier.backgroundColor = .themeClr
            self.btnSupplier.setTitleColor(.whitClr, for: .normal)
            self.tableViewSingup.reloadData()
        }
    }
    
    
    //
    
    
  
    
    func manageTagFooterCell(tag:Int){
        self.defineXIBUItableView()
        switch self.userType {
        case 0:
            switch tag {
            case 1:
                let indexPathBuyer = IndexPath(row: 0, section: 0)
                if let cell = self.tableViewSingup.cellForRow(at: indexPathBuyer) as? BuyerCell1 {
                    if self.isEmailVerified == 1{
                        if let result = cell.dataCollect().firstName {
                            self.buyerDataParam = cell.dataCollect()
                            let indexPathFooter = IndexPath(row: 0, section: 1)
                            if let cell = self.tableViewSingup.cellForRow(at: indexPathFooter) as? FooterCell {
                                self.buyerDataParam?.referralCode = cell.getRefralCode()
                            }
                            self.signupUserParam()
                        } else {
                            self.toastMessage("Please fill all the data")
                        }
                    }
                    else{
                        self.toastMessage("Please verify your email.")
                    }
                   
                }
                
           
            default:
                self.navigationController?.popViewController(animated: true)
            }
           
        case 1:
          
//                if self.isAdharVerify{
//                    
//                    if let adharFront = self.adharFront{
//                        self.dealerDataStruct.aadhaarNoDocFront = adharFront
//                    }
//                    else{
//                        toastMessage("Please add adhar front image")
//                    }
//                    
//                    if let adharBack = self.adharBack{
//                        self.dealerDataStruct.aadhaarNoDocBack = adharBack
//                    }
//                    else{
//                        toastMessage("Please add adhar back image")
//                    }
//                }
//                if self.isPanVerify{
//                    
//                    if let pan = self.panFront{
//                        self.dealerDataStruct.panNoDoc = pan
//                    }
//                    else{
//                        toastMessage("Please add PAN front image")
//                    }
//                    
//                }
//
//            if !self.isBasicInfoEmailVerified{
//                toastMessage("Verify your mail")
//            }
//            
//            
//            guard (self.stateID != 0) else{
//                toastMessage("Select State")
//                return
//            }
//            
//            guard (self.cityID != 0) else{
//                toastMessage("Select City")
//                return
//            }
//            
            self.dealerDataStruct.country = "\(self.countryId)"
            self.dealerDataStruct.state = "\(self.stateID ?? 0)"
            self.dealerDataStruct.city = "\(self.cityID ?? 0)"
         
            
//            let indexPathDealerBasicDetails = IndexPath(row: 0, section: 2)
//            if let cell = self.tableViewSingup.cellForRow(at: indexPathDealerBasicDetails) as? Dealer_BasicCell {
//                let dataStr = cell.dataCollect()
//                self.dealerDataStruct.firstName = dataStr.firstName
//                self.dealerDataStruct.lastName = dataStr.lastName
//                self.dealerDataStruct.mobileNo = dataStr.mobileNo
//                self.dealerDataStruct.email = dataStr.email
//                
//                if self.isBasicInfoEmailVerified{
//                    self.dealerDataStruct.email = dataStr.email
//                }
//                else{
//                    self.toastMessage("Email is not verified")
//                   cell.txtEmail.showError(message: "Email verify requred")
//                    
//                }
//                
//                //
//                self.dealerDataStruct.password = dataStr.password
//                self.dealerDataStruct.confirmPassword = dataStr.confirmPassword
//              
//            }
//            else {
//              // Handle the case where the cell is not found or not of the expected type
//              print("Cell not found or not a Dealer_BasicCell")
//            }
            
            
            
            let indexPathDealerOtherDetails = IndexPath(row: 0, section: 4)
            if let cell = self.tableViewSingup.cellForRow(at: indexPathDealerOtherDetails) as? Dealer_OtherDocCell {
                
                //let dataStr = cell.basicDataParam
                let dob  = cell.returnDOB()
                self.dealerDataStruct.dob = dob
                self.dealerDataStruct.passportNo = cell.returnPassportNum()
                self.dealerDataStruct.passportFrontDoc = self.passportFront
                self.dealerDataStruct.passportBackDoc = self.passportBack
                
                self.dealerDataStruct.drivingLicenseNo = cell.returnDrivLinceNum()
                self.dealerDataStruct.drivingLicenseDoc = self.drivLicence
                self.dealerDataStruct.otherDocs = cell.returnDocArr()
                
            }
            
//            let indexPathDealerCompanyDetais = IndexPath(row: 0, section: 0)
//            if let cell = self.tableViewSingup.cellForRow(at: indexPathDealerCompanyDetais) as? Dealer_CompanyDetailsCell {
//                let dataStr = cell.dataCollectCompanyDetail()
//                self.dealerDataStruct.companyName = dataStr.companyName
//                self.dealerDataStruct.mobileNo = dataStr.mobileNo
//                self.dealerDataStruct.email = dataStr.email
//                self.dealerDataStruct.country = dataStr.country
//                self.dealerDataStruct.state = dataStr.state
//                self.dealerDataStruct.city = dataStr.city
//                self.dealerDataStruct.pinCode = dataStr.pinCode
//                self.dealerDataStruct.address = dataStr.address
//                self.dealerDataStruct.address2 = dataStr.address2
//                self.dealerDataStruct.typeOfCompany = dataStr.companyType
//                self.dealerDataStruct.natureOfBusiness = dataStr.businessNature
                
//
//
//                
//                let companyGSTNumber = dataStr.gstNumber
//                let companyPANNumber = dataStr.panNumber
//                let companyEmail = dataStr.email
//                
//                if self .isCompanyDetailsGSTVerified{
//                    self.dealerDataStruct.companyGSTNo = companyGSTNumber
//                }
//                
//                if self .isCompanyDetailsPANVerified{
//                    self.dealerDataStruct.companyPANNo = companyPANNumber
//                }
//                
//                if self .isCompanyDetailsEmailVerified{
//                    self.dealerDataStruct.companyEmail = companyEmail
//                }
//                
//                self.dealerDataStruct.companyGSTNoDoc = self.companyGST
//                self.dealerDataStruct.companyPANNoDoc = self.companyPAN
//                self.dealerDataStruct.companyContact = dataStr.mobileNo
//                
//                self.dealerDataStruct.typeOfCompany = dataStr.companyType
//                self.dealerDataStruct.natureOfBusiness = dataStr.businessNature
//                self.dealerDataStruct.iecNo = dataStr.iecNumber
//                self.dealerDataStruct.tradeMembershipNo = dataStr.trademembership
//                self.dealerDataStruct.tradeMembershipNoDoc = self.companyTrade
//                self.dealerDataStruct.country = dataStr.country
//                self.dealerDataStruct.state = dataStr.state
                
//            }
            
           
            
            
            guard (self.dealerDataStruct.mobileNo != nil) else{
                toastMessage("Mobile number requried")
                return
            }
            guard (self.dealerDataStruct.email != nil) else{
                toastMessage("Email requried")
                return
            }
            guard (self.dealerDataStruct.mobileNo != nil) else{
                toastMessage("Mobile number requried")
                return
            }
            guard (self.dealerDataStruct.email != nil) else{
                toastMessage("Email requried")
                return
            }
            
            guard (self.dealerDataStruct.country != nil) else{
                toastMessage("Country requried")
                return
            }
            
            guard (self.dealerDataStruct.state != nil) else{
                toastMessage("State requried")
                return
            }
            
            guard (self.dealerDataStruct.city != nil) else{
                toastMessage("City requried")
                return
            }
            
            guard (self.dealerDataStruct.pinCode != nil) else{
                toastMessage("Pincode requried")
                return
            }
            
            guard (self.dealerDataStruct.address != nil) else{
                toastMessage("Address requried")
                return
            }
            
            self.signupUserParam()
            
            
//            if self.isGSTVerify && isPanVerify && isAdharVerify && isBasicInfoEmailVerified && isCompanyDetailsGSTVerified && isCompanyDetailsPANVerified && isCompanyDetailsEmailVerified {
//                self.signupUserParam()
//            }
//            else{
//                toastMessage("Check all field* mendatory data and verify the official document is requried.")
//            }
//            
            print("Button pressed with tag: \(tag)")
        default:
            print("Button")
            self.suplierDataStruct.country = "\(self.countryId)"
            self.suplierDataStruct.state = "\(self.stateID ?? 0)"
            self.suplierDataStruct.city = "\(self.cityID ?? 0)"
            self.suplierDataStruct.companyGSTNoDoc = self.companyGST
            self.suplierDataStruct.companyPANNoDoc = self.companyPAN
           
            guard (self.suplierDataStruct.companyName != nil) else{
                toastMessage("Name requried")
                return
            }
   
            guard (self.suplierDataStruct.email != nil) else{
                toastMessage("Email requried")
                return
            }
            guard (self.suplierDataStruct.password != nil) else{
                toastMessage("Password requried")
                return
            }
   
            guard (self.suplierDataStruct.confirmPassword != nil) else{
                toastMessage("Confirm password requried")
                return
            }
            guard (self.suplierDataStruct.mobileNo != nil) else{
                toastMessage("Mobile number requried")
                return
            }
            guard (self.suplierDataStruct.inventoryType != nil) else{
                toastMessage("Inventory type requried")
                return
            }
            guard (self.suplierDataStruct.country != nil) else{
                toastMessage("Country requried")
                return
            }
            guard (self.suplierDataStruct.state != nil) else{
                toastMessage("State requried")
                return
            }
            guard (self.suplierDataStruct.city != nil) else{
                toastMessage("City requried")
                return
            }
            guard (self.suplierDataStruct.address != nil) else{
                toastMessage("Address requried")
                return
            }
            guard (self.suplierDataStruct.authPersonName != nil) else{
                toastMessage("Auth Person Name requried")
                return
            }
            guard (self.suplierDataStruct.authPersonContact != nil) else{
                toastMessage("Auth Person contact requried")
                return
            }
            guard (self.suplierDataStruct.authPersonEmail != nil) else{
                toastMessage("Auth Person email requried")
                return
            }
           
            
            
           

            
//            let indexPathDealerOtherDetails = IndexPath(row: 0, section: 2)
//            if let cell = self.tableViewSingup.cellForRow(at: indexPathDealerOtherDetails) as? Dealer_OtherDocCell {
//                //let dataStr = cell.basicDataParam
//                let dob  = cell.returnDOB()
//                self.suplierDataStruct.dob = dob
//                self.suplierDataStruct.otherDocs = cell.returnDocArr()
//                
//            }
            
//            let indexPathDealerCompanyDetais = IndexPath(row: 0, section: 3)
//            if let cell = self.tableViewSingup.cellForRow(at: indexPathDealerCompanyDetais) as? Supplier_AuthorisedPersonCell {
//                self.suplierDataStruct.authPersonName = cell.txtSupervisorName.text ?? ""
//                self.suplierDataStruct.authPersonContact = cell.txtSupervisorMobile.text ?? ""
//                self.suplierDataStruct.authPersonEmail = cell.txtSupervisorEmail.text ?? ""
//            }
            
            let indexPathDealerFoter = IndexPath(row: 0, section: 4)
            if let cell = self.tableViewSingup.cellForRow(at: indexPathDealerFoter) as? FooterCell {
                self.suplierDataStruct.referralCode = cell.txtRefralCode.text ?? ""
               
            }
            
            self.signupUserParam()
            
            //self.signupUserParam()
//            if self.isSupllierGSTVerified &&  isSupllierPANVerified && isSupllierEmailVerified && isSupllierGSTDoc && isSupllierPANDoc {
//                self.signupUserParam()
//            }
//            else{
//                toastMessage("Check all field* mendatory data and verify the official document is requried.")
//            }
        }
    }
    
    
    func signupUserParam(){
        switch self.userType {
        case 0:
            
            let parameters : [String: Any] = [
                    "firstName": self.buyerDataParam?.firstName ?? "",
                    "lastName": self.buyerDataParam?.lastName ?? "",
                    "mobileNo": self.buyerDataParam?.mobileNo ?? "",
                    "email": self.buyerDataParam?.email ?? "",
                    "password": self.buyerDataParam?.password ?? "",
                    "confirmPassword": self.buyerDataParam?.confirmPassword ?? "",
                    "country": self.countryId,
                    "state": self.stateID ?? 0,
                    "city": self.cityID ?? 0,
                    "pinCode": self.buyerDataParam?.pinCode ?? "",
                    "address": self.buyerDataParam?.address ?? "",
                    "address2": self.buyerDataParam?.address2 ?? "",
                    "referralCode":self.buyerDataParam?.referralCode ?? ""
                    
                ]
          
            self.signupUser(param: parameters)
            
            
        case 1:
            print("Dealer")
            let parameters : [String: Any] = [
                "firstName": self.dealerDataStruct.firstName ?? "",
                    "lastName": self.dealerDataStruct.lastName ?? "",
                    "mobileNo": self.dealerDataStruct.mobileNo ?? "",
                    "email": self.dealerDataStruct.email ?? "",
                    "password": self.dealerDataStruct.password ?? "",
                    "confirmPassword": self.dealerDataStruct.confirmPassword ?? "",
                    "country": self.countryId,
                    "state": self.stateID ?? 0,
                    "city": self.cityID ?? 0,
                    "pinCode": self.dealerDataStruct.pinCode ?? "",
                    "address": self.dealerDataStruct.address ?? "",
                    "address2": self.dealerDataStruct.address2 ?? "",
                    "referralCode":self.dealerDataStruct.referralCode ?? "",
                    
                    "companyName": self.dealerDataStruct.companyName ?? "",
                    "companyEmail": self.dealerDataStruct.companyEmail ?? "",
                    "companyContact": self.dealerDataStruct.companyContact ?? "",
                    "typeOfCompany": self.dealerDataStruct.typeOfCompany ?? "",
                    "natureOfBusiness": self.dealerDataStruct.natureOfBusiness ?? "",
                    "aadhaarNo": self.dealerDataStruct.aadhaarNo ?? "",
                    "PANNo": self.dealerDataStruct.panNo ?? "",
                    "companyPANNo": self.dealerDataStruct.companyPANNo ?? "",
                    "companyGSTNo": self.dealerDataStruct.companyGSTNo ?? "",
                    "tradeMembershipNo": self.dealerDataStruct.tradeMembershipNo ?? "",
                    "IECNo": self.dealerDataStruct.iecNo ?? "",
                    "dob": self.dealerDataStruct.dob ?? "",
                   // "inventoryType": "",
                    //"emiratesId": "",
                    "aadhaarNoDocFront" : self.dealerDataStruct.aadhaarNoDocFront ?? "",
                    "aadhaarNoDocBack" : self.dealerDataStruct.aadhaarNoDocBack ?? "",
                    "PANNoDoc" : self.dealerDataStruct.panNoDoc ?? "",
                    "companyPANNoDoc" : self.dealerDataStruct.companyPANNoDoc ?? "",
                    "companyGSTNoDoc" : self.dealerDataStruct.companyGSTNoDoc ?? "",
                    "tradeMembershipNoDoc" : self.dealerDataStruct.tradeMembershipNoDoc ?? "",
                    "IECDoc" : self.dealerDataStruct.iecDoc ?? "",
                    //"emiratesIdDoc" : "AAAAAAAAAA",
                    "otherDocs" : self.dealerDataStruct.otherDocs ?? []
                    
                ]
            
//            print(parameters)
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().userSignup(url: APIs().signup_Dealer_API, requestParam: parameters, completion: { result , msg in
                if result.status == 1{
                    self.toastMessage(result.msg ?? "")
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    self.toastMessage(result.msg ?? "")
                }
                CustomActivityIndicator2.shared.hide()
            })
            
        default:
            print("Suppler")
            
            let parameters : [String: Any] = [
                
                    "firstName": self.suplierDataStruct.firstName ?? "",
                    "lastName": self.suplierDataStruct.lastName ?? "",
                    "email": self.suplierDataStruct.email ?? "",
                    "mobileNo": self.suplierDataStruct.mobileNo ?? "",
                    "country":self.suplierDataStruct.country ?? "",
                    "state": self.suplierDataStruct.state ?? "",
                    "city": self.suplierDataStruct.city ?? "",
                    "password": self.suplierDataStruct.password ?? "",
                    "confirmPassword": self.suplierDataStruct.confirmPassword ?? "",
                    "pinCode": self.suplierDataStruct.pinCode ?? "",
                    "address": self.suplierDataStruct.address ?? "",
                    "address2":self.suplierDataStruct.address2 ?? "",
                    "referralCode": self.suplierDataStruct.referralCode ?? "",
                    "companyName": self.suplierDataStruct.companyName ?? "",
                    "companyEmail": self.suplierDataStruct.companyEmail ?? "",
                    "companyContact": self.suplierDataStruct.companyContact ?? "",
                    "typeOfCompany": self.suplierDataStruct.typeOfCompany ?? "",
                    "natureOfBusiness": self.suplierDataStruct.natureOfBusiness ?? "",
                   // "aadhaarNo": "451562516545",
                   // "PANNo": "CDUYT6554E",
                   // "GSTNo": "DDCDUYT6554EEE4",
                    "companyPANNo": self.suplierDataStruct.companyPANNo ?? "",
                    "companyGSTNo": self.suplierDataStruct.companyGSTNo ?? "",
                    "tradeMembershipNo": self.suplierDataStruct.tradeMembershipNo ?? "",
                    "IECNo": self.suplierDataStruct.iecNo ?? "",
                    "authPersonName": self.suplierDataStruct.authPersonName ?? "",
                    "authPersonContact": self.suplierDataStruct.authPersonContact ?? "",
                    "authPersonEmail": self.suplierDataStruct.authPersonEmail ?? "",
                     "bankName": self.suplierDataStruct.bankName ?? "",
                     "branchName": self.suplierDataStruct.branchName ?? "",
                     "accountNo": self.suplierDataStruct.accountNo ?? "",
                     "accountType": self.suplierDataStruct.accountType ?? "",
                     "IFSCCode": self.suplierDataStruct.ifscCode ?? "",
                     "swiftCode": self.suplierDataStruct.swiftCode ?? "",
                    "dob": self.suplierDataStruct.dob ?? "",
                    "inventoryType": self.suplierDataStruct.inventoryType ?? "",
                    //"emiratesId": "",
                   // "requestOtp": "0",
                   // "emailOtp": "1234",
                    // "mobileOtp": "Test@123",
                  //  "aadhaarNoDocFront": "AA",
                   // "aadhaarNoDocBack": "AAA",
                  //  "PANNoDoc": "AAAA",
                    "companyPANNoDoc":self.companyPAN ?? "",
                   // "GSTNoDoc": self.companyGST,
                    "companyGSTNoDoc":  self.companyGST ?? "",
                    "tradeMembershipNoDoc": self.companyTrade ?? "",
                    "IECDoc":  self.companyIEC ?? "",
                    //"emiratesIdDoc": "AAAAAAAAAA",
                    
                ]
            
            print(parameters)
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().userSignup(url: APIs().signup_Supplier_API, requestParam: parameters, completion: { result , msg in
                if result.status == 1{
                    self.navigationController?.popViewController(animated: true)
                    self.toastMessage(result.msg ?? "")
                }
                else{
                    self.toastMessage(result.msg ?? "")
                }
                CustomActivityIndicator2.shared.hide()
            })
            
        }
    }
    
    func signupUser(param:[String:Any]){
        switch self.userType {
        case 0:
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().userSignup(url: APIs().signup_Buyer_API, requestParam: param, completion: { buyerData , message in
                print(buyerData)
                if buyerData.status == 1{
                    self.toastMessage(buyerData.msg ?? "")
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    self.toastMessage(buyerData.msg ?? "")
                }
                CustomActivityIndicator2.shared.hide()
                
            })
            
        case 1:
            print("Dealer")
        default:
            print("Suppler")
        }
    }
    
    
    // verificationDoc
    func verifyDoc(docType:String, docNumber:String) -> Int{
        view.endEditing(true)
        
        var returnStatus = Int()
        var param :[String:Any] = [:]
        param = ["documentType":docType, docType:docNumber]
        CustomActivityIndicator.shared.show(in: view)
        // APIs().document_verification_API
        SignupDataModel().verifyDoc(url: "https://admin.diamondxe.com/app/v1/validate-document", requestParam: param, completion: { result , msg in
            self.toastMessage(result.msg ?? "")
            CustomActivityIndicator.shared.hide()
            returnStatus =  result.status ?? 0
        })
        return returnStatus
    }
    
    func verifyDoc(otherDocType:String, otherDoc:String, docNumber:String, dob:String) -> Int{
        var returnStatus = Int()
        var param :[String:Any] = [:]
        param = ["documentType" : otherDoc, "otherDocumentType": otherDocType, "otherDocumentNumber":docNumber, "dob": dob]
        CustomActivityIndicator.shared.show(in: view)
        SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
            self.toastMessage(result.msg ?? "")
            CustomActivityIndicator.shared.hide()
            returnStatus =  result.status ?? 0
        })
        return returnStatus
    }
    
   
    

}

extension SignupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return UserTypeManager.getSignupDataCellSections(userType: self.userType, isIndiaCode: self.isIndiaPin)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return UserTypeManager.getSignupDataCellrow(userType: self.userType)
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.userType {
        case 0:
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.buyerCell1, for: indexPath) as? BuyerCell1 else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.btnFlag?.sd_setImage(with: URL(string: APIs().indianFlag), for: .normal, completed: nil)
                cell.btnCode.setTitle("+91", for: .normal)
                cell.buttonPressed = { tag in
                    if tag == 11 {
                        let emailStr = cell.getEmailCode()
                        if EmailValidation.isValidEmail(emailStr){
                            self.openPopup(email: emailStr)
                        }
                        else{
                            cell.txtEmail.showError(message: emailStr)
                        }
                    }
                    else{
                        self.manageTagBuyperCell(tag: tag)
                    }
                   }
                
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.fotterCell, for: indexPath) as? FooterCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.buttonPressed = { tag in
                    // Handle button action with tag
                    self.manageTagFooterCell(tag: tag)
                   }
                
                return cell
            }
        case 1:
            
            if self.isIndiaPin{
            switch indexPath.section {
            case 1:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.dealer_KycCell, for: indexPath) as? Dealer_KYCCell else {
                        return UITableViewCell()
                    }
                    cell.selectionStyle = .none
                    cell.cellDataDelegate = self
                    cell.indexPath = indexPath
                    
                    cell.buttonPressed = { tag in
                        self.isCellExpandedKYC.toggle()
                        cell.setupData(isExpand: self.isCellExpandedKYC)
                        self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)
                        
                    } //27AAJCD6164A1ZT
                    cell.buttonPressedVerify = { tag in
                        if tag == 0 {
                            let gstNo = cell.getAdharnum()
                            self.view.endEditing(true)
                            var param :[String:Any] = [:]
                            param = ["documentType":"GSTNo", "GSTNo":gstNo]
                            CustomActivityIndicator.shared.show(in: self.view)
                            // APIs().document_verification_API
                            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                
                                if result.status == 1{
                                    self.aadharVerify = result
                                    
                                    cell.btnverifyGST.isHidden = true
                                    cell.btnverifiedAdhar.isHidden = false
                                    self.isAdharVerify = true
                                }
                                else{
                                    self.isAdharVerify = false
                                    cell.txtAdhar.showError(message: "GST number verify requried")
                                }
                                
                                self.toastMessage(result.msg ?? "")
                                CustomActivityIndicator.shared.hide()
                            })
                            
                        }
                        else{
                            let panNo = cell.getPANnum()
                            self.view.endEditing(true)
                            var param :[String:Any] = [:]
                            param = ["documentType":"PANNo", "PANNo":panNo]
                            CustomActivityIndicator.shared.show(in: self.view)
                            // APIs().document_verification_API
                            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                
                                if result.status == 1{
                                    self.panVerify = result
                                    
                                    cell.btnverifyPAN.isHidden = true
                                    cell.btnverifiedPAN.isHidden = false
                                    self.isPanVerify = true
                                }
                                else{
                                    self.isPanVerify = false
                                    cell.txtPAN.showError(message: "PAN number verify requried")
                                }
                                
                                self.toastMessage(result.msg ?? "")
                                CustomActivityIndicator.shared.hide()
                            })
                            
                        }
                    }
                    
                    cell.buttonPressedPicDoc = { tag in
                        switch tag {
                        case 0:// pic adhar front
                            ImagePickerManager().pickImage(self){ image in
                                //here is the image
                                
                                cell.btnSelectGST.isHidden = false
                                cell.btnGSTFront.isHidden = true
//                                    .setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnGSTFront.setTitle("", for: .normal)
//                                cell.btnGSTFront.backgroundColor = .clear
                                self.adharFront = image
                                // print(image)
                            }
                            
                        case 1:// pic adhar front
                            ImagePickerManager().pickImage(self){ image in
                                //here is the image
                                cell.btnSelectPAN.isHidden = false
                                cell.btnPANFront.isHidden = true
//                                    .setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnPANFront.setTitle("", for: .normal)
//                                cell.btnPANFront.backgroundColor = .clear
                                
                                self.panFront = image
                                // print(image)
                            }
                        
                        default: // pic adhar
                            ImagePickerManager().pickImage(self){ image in
                                //here is the image
                               // cell.btnPANFrontIcon.setImage(UIImage(named: "done"), for: .normal)
                                cell.btnSelectIEC.isHidden = false
                                cell.btnIECDoc.isHidden = true
//                                cell.btnIECDoc.setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnIECDoc.setTitle("", for: .normal)
//                                cell.btnIECDoc.backgroundColor = .clear
                                
                                self.companyIEC = image
                                //print(image)
                            }
                        }
                    }
                    
                    
                    return cell
               
                
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.dealer_BasicCell, for: indexPath) as? Dealer_BasicCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.cellDataDelegate = self
                cell.indexPath = indexPath
                
                if let panInfo = self.panVerify.details{
                    cell.txtFirstName.text = panInfo.firstName
                    cell.txtLastName.text = panInfo.lastName
                    cell.txtEmail.text = panInfo.email
                    cell.txtContry.text = panInfo.country
                }
               
                cell.btnFlag?.sd_setImage(with: URL(string: APIs().indianFlag), for: .normal, completed: nil)
                cell.btnCode.setTitle("+91", for: .normal)
                
                
                
                cell.buttonDropDown = { tag in
                    self.isCellExpandedBasic.toggle()
                    cell.setupData(isExpand: self.isCellExpandedBasic)
                    self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                   }
                
                cell.buttonPressed = { tag in
                    if tag == 11 {
                        let emailStr = cell.getEmailCode()
                        if EmailValidation.isValidEmail(emailStr){
                            self.view.endEditing(true)
                            let param  = ["email" : emailStr, "requestOtp": 1]
                            CustomActivityIndicator.shared.show(in: self.view)
                             SignupDataModel().emialVerification(url: APIs().email_verification_API, requestParam: param, completion: { emailVerify , message in
                                 print(emailVerify)
                                 if emailVerify.status == 2{
                                     self.toastMessage(emailVerify.msg ?? "")
                                     self.openPopup(email: emailStr)
                                 }
                                 else{
                                     self.toastMessage(emailVerify.msg ?? "")
                                 }
                                 CustomActivityIndicator.shared.hide()
                                 
                             })

                        }
                        else{
                            cell.txtEmail.showError(message: emailStr)
                        }
                    }
                    else{
                        self.dealerSection = 1
                        
                        
                        
                        
                        self.manageTagBuyperCell(tag: tag)
                    }
                    
                }
                
                return cell
                
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthorisedPersionKYCTVC.cellIdentifierAuthorisedPersionCell, for: indexPath) as? AuthorisedPersionKYCTVC else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.cellDataDelegate = self
                cell.indexPath = indexPath
              
                
                cell.buttonPressed = { tag in
                    self.isCellExpandedAuthPersion.toggle()
                    cell.setupData(isExpand: self.isCellExpandedAuthPersion)
                    self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                   }
                cell.buttonPressedVerify = { tag in
                    if tag == 0 {
                        let adhar = cell.getAadharnum()
                        self.view.endEditing(true)
                        var param :[String:Any] = [:]
                        param = ["documentType":"aadhaarNo", "aadhaarNo":adhar]
                        CustomActivityIndicator.shared.show(in: self.view)
                        // APIs().document_verification_API
                        SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                            
                            if result.status == 1{
                                self.aadharVerify = result
                                
                                cell.btnverifyAdhar.isHidden = true
                                cell.btnverifiedAdhar.isHidden = false
                                self.isAdharVerify = true
                            }
                            else{
                                self.isAdharVerify = false
                                cell.txtAadharNum.showError(message: "Aadhaar number verify requried")
                            }
                            
                            self.toastMessage(result.msg ?? "")
                            CustomActivityIndicator.shared.hide()
                        })
                        
                    }
                    else{
                        let panNo = cell.getPANnum()
                        self.view.endEditing(true)
                        var param :[String:Any] = [:]
                        param = ["documentType":"PANNo", "PANNo":panNo]
                        CustomActivityIndicator.shared.show(in: self.view)
                        // APIs().document_verification_API
                        SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                            
                            if result.status == 1{
                                self.panVerify = result
                                
                                cell.btnverifyPAN.isHidden = true
                                cell.btnverifiedPAN.isHidden = false
                                self.isPanVerify = true
                            }
                            else{
                                self.isPanVerify = false
                                cell.txtPANnum.showError(message: "PAN number verify requried")
                            }
                            
                            self.toastMessage(result.msg ?? "")
                            CustomActivityIndicator.shared.hide()
                        })
                        
                    }
                }
                
                cell.buttonPressedPicDoc = { tag in
                    switch tag {
                    case 0:// pic adhar front
                        ImagePickerManager().pickImage(self){ image in
                            //here is the image
                            cell.btnSelectAdharFront.isHidden = false
                            cell.btnAdharFront.isHidden = true
//                            cell.btnAdharFront.setImage(UIImage(named: "Verify"), for: .normal)
//                            cell.btnAdharFront.setTitle("", for: .normal)
//                            cell.btnAdharFront.backgroundColor = .clear
                            self.adharFront = image
                            // print(image)
                        }
                        
                    case 1:// pic adhar front
                        ImagePickerManager().pickImage(self){ image in
                            //here is the image
                            cell.btnSelectAdharBack.isHidden = false
                            cell.btnAdharBack.isHidden = true
//                            cell.btnAdharBack.setImage(UIImage(named: "Verify"), for: .normal)
//                            cell.btnAdharBack.setTitle("", for: .normal)
//                            cell.btnAdharBack.backgroundColor = .clear
                            
                            self.adharBack = image
                            // print(image)
                        }
                    
                    default: // pic adhar
                        ImagePickerManager().pickImage(self){ image in
                            //here is the image
                           // cell.btnPANFrontIcon.setImage(UIImage(named: "done"), for: .normal)
                            cell.btnSelectPANFront.isHidden = false
                            cell.btnPANFront.isHidden = true
                            cell.btnPANFront.setImage(UIImage(named: "Verify"), for: .normal)
                            cell.btnPANFront.setTitle("", for: .normal)
                            cell.btnPANFront.backgroundColor = .clear
                            
                            self.panFront = image
                            //print(image)
                        }
                    }
                }
                
                return cell
                
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.dealer_OtherDocCell, for: indexPath) as? Dealer_OtherDocCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                
                
                cell.btnDOB = { tag in
                    self.customDatePicker.delegate = self
                    self.customDatePicker.showDatePicker(in: self)

                }
                
                cell.buttonPressed = { tag in
                    self.isCellExpandedOtherD.toggle()
                    self.isDataCellHide = true
                    cell.setupData(isExpand: self.isCellExpandedOtherD)
                    self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                   }
                
//                cell.buttonPressedAddView = { tag in
////                    cell.viewBGData1.isHidden = false
////                    cell.viewBGData2.isHidden = false
//                    self.isDataCellHide = false
//                    self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)
//                }
                
//                cell.buttonActionPopup = { tag in
//                    self.dealerSection = 1
//                    if tag == 0{
//                        self.dropDown.anchorView = cell.btnDropDown1c
//                        self.dropDown.dataSource = self.otheraDocList
//                        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                          print("Selected item: \(item) at index: \(index)")
//                            if item == "Passport"{
//                                cell.lblSelect1.text = item
//                                cell.viewAddDoc2.isHidden = false
//                            }
//                            else{
//                                cell.lblSelect1.text = item
//                                cell.viewAddDoc2.isHidden = true
//                            }
//                            self.dropDown.hide()
//
//                        }
//                        self.dropDown.show()
//                       
//                    }
//                    else{
//                        self.dropDown.anchorView = cell.btnDropDown2c
//                        self.dropDown.dataSource = self.otheraDocList
//                        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                          print("Selected item: \(item) at index: \(index)")
//                            if item == "Passport"{
//                                cell.lblSelect2.text = item
//                                cell.viewAddDoc4.isHidden = false
//                            }
//                            else{
//                                cell.lblSelect2.text = item
//                                cell.viewAddDoc4.isHidden = true
//                            }
//                            self.dropDown.hide()
//
//                        }
//                        self.dropDown.show()
//                    }
//                }
                
//                cell.buttonRemoveDocView = { tag in
//                  
////                        if tag == 0 {
////                            cell.viewBGData2.isHidden = false
////                            cell.viewBGData1.isHidden = true
////                        }
////                        else{
////                            cell.viewBGData1.isHidden = false
////                            cell.viewBGData2.isHidden = true
////                        }
//                        self.isDataCellHide = true
//                        self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)
//                    }
                
                
                cell.buttonDocBase64 = { tag in
                    switch tag {
                    case 0:
                        ImagePickerManager().pickImage(self){ image in

                            cell.btnSelectPassportFront.isHidden = false
                            cell.btnPassportFront.isHidden = true
//                            cell.btnPassportFront.setImage(UIImage(named: "Verify"), for: .normal)
//                            cell.btnPassportFront.setTitle("", for: .normal)
//                            cell.btnPassportFront.backgroundColor = .clear
                            self.passportFront = image
                            
                           // print(image)
                           }
                    case 1:
                        ImagePickerManager().pickImage(self){ image in
                               //here is the image
                            cell.btnSelectPassportBack.isHidden = false
                            cell.btnPassportBack.isHidden = true
//                            cell.btnPassportBack.setImage(UIImage(named: "Verify"), for: .normal)
//                            cell.btnPassportBack.setTitle("", for: .normal)
//                            cell.btnPassportBack.backgroundColor = .clear
                            self.passportBack = image
                           }
//                    case 2:
//                        ImagePickerManager().pickImage(self){ image in
//                               //here is the image
//                            cell.btnDoc2FrontIcon.setImage(UIImage(named: "done"), for: .normal)
//                            cell.doc2Front = image
//                           // print(image)
//                           }
                    default:
                        ImagePickerManager().pickImage(self){ image in
                               //here is the image
                            cell.btnSelectDrivingLic.isHidden = false
                            cell.btnLicenceFront.isHidden = true
//                            cell.btnLicenceFront.setImage(UIImage(named: "Verify"), for: .normal)
//                            cell.btnLicenceFront.setTitle("", for: .normal)
//                            cell.btnLicenceFront.backgroundColor = .clear
                            self.drivLicence = image
                           }
                    }
                   
                }
                
                cell.btnVerifyDoc = { tag in
                    //                    let dob = cell.txtSelect1.text ?? ""
                    if tag == 0{
                        let passportNum = cell.txtSelect1.text ?? ""
                        let passportDoc = ""
                        if passportDoc != "" && !passportNum.isEmpty {
                            
                            var param :[String:Any] = [:]
                            param = ["documentType" : "otherDocs", "otherDocumentType": passportDoc, "otherDocumentNumber":passportNum, "dob": ""]
                            CustomActivityIndicator.shared.show(in: self.view)
                            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                
                                if result.status ?? 0 == 1{
                                    cell.btnDoc1Verify.isHidden = true
                                    cell.btnDoc1Verified.isHidden = false
                                    //                                    self.dealerDataStruct.dob = dob
                                    self.dealerDataStruct.otherDocs = cell.returnDocArr()
                                }
                                
                                self.toastMessage(result.msg ?? "")
                                CustomActivityIndicator.shared.hide()
                            })
                            
                        }
                        else  {
                            self.toastMessage( "Enter Passort number and select doc")
                        }
                    }
                    else if tag == 1{
                        let passportNum = cell.txtSelect1.text ?? ""
                        let passportDoc = ""
                        
                        if passportDoc != "" && !passportNum.isEmpty {
                            
                            var param :[String:Any] = [:]
                            param = ["documentType" : "otherDocs", "otherDocumentType": passportDoc, "otherDocumentNumber":passportNum, "dob": ""]
                            CustomActivityIndicator.shared.show(in: self.view)
                            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                
                                if result.status ?? 0 == 1{
                                    cell.btnDoc1Verify.isHidden = true
                                    cell.btnDoc1Verified.isHidden = false
                                    //                                    self.dealerDataStruct.dob = dob
                                    self.dealerDataStruct.otherDocs = cell.returnDocArr()
                                }
                                
                                self.toastMessage(result.msg ?? "")
                                CustomActivityIndicator.shared.hide()
                            })
                        }
                    
                    else  {
                        self.toastMessage( "Enter Driving Licence number and select doc")
                    }
                }
                    
                }
                
                
                return cell
                
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.dealer_CompanyDetailCell, for: indexPath) as? Dealer_CompanyDetailsCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.cellDataDelegate = self
                cell.indexPath = indexPath
                
                cell.buttonPressed = { tag in
                    
                    self.isCellExpandedCompanyD.toggle()
                    cell.setupData(isExpand: self.isCellExpandedCompanyD)
                    self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                   }
                
                cell.btnFlag?.sd_setImage(with: URL(string: APIs().indianFlag), for: .normal, completed: nil)
                cell.btnCode.setTitle("+91", for: .normal)
                
                cell.buttonVerify = { tag in
                    if tag == 0{
                        let gstNo = cell.txtGST.text ?? ""
//                        let isVerify = self.verifyDoc(docType: "GSTNo", docNumber: gstNo)
                        
                        let panNo = cell.txtGST.text ?? ""
                        self.view.endEditing(true)
                        var param :[String:Any] = [:]
                        param = ["documentType":"GSTNo", "GSTNo":panNo]
                        CustomActivityIndicator.shared.show(in: self.view)
                        // APIs().document_verification_API
                        SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                            
                            if result.status == 1{
                                self.companyGSTVerify = result
                                self.dealerDataStruct.companyGSTNo = gstNo
                                cell.btnVerifyGst.isHidden = true
                                cell.btnVerifyDonegGst.isHidden = false
                                 
                                cell.txtCompanyName.text = self.companyGSTVerify.details?.companyName
                                cell.txtEmail.text = self.companyGSTVerify.details?.email
//                                cell.txtCountry.text = self.companyGSTVerify.details?.country
//                                cell.txtState.text = self.companyGSTVerify.details?.state
//                                cell.txtCity.text = self.companyGSTVerify.details?.city
                                cell.txtIPinNum.text = self.companyGSTVerify.details?.pincode
                                cell.txtAddress1.text = self.companyGSTVerify.details?.address
                                cell.txtCompanyType.text = self.companyGSTVerify.details?.companyType
                                cell.txtBusinessVal.text = self.companyGSTVerify.details?.natureOfBusiness
                                
                                if let panDocInfo = self.companyPANVerify.details {
                                    
                                    if self.companyGSTVerify.details?.companyType != "Proprietorship"{
                                        if self.companyGSTVerify.details?.companyName == panDocInfo.panCompanyName && cell.txtCompanyType.text != "Proprietorship"{
                                            self.isCompanyDetailsGSTVerified = true

                                        }
                                        else{
                                            self.toastMessage("Kindly enter the pan card associated with gst number")
                                        }
                                    }
                                    
                                }
                                
                            }
                            else{
                                self.isCompanyDetailsGSTVerified = false
                                cell.txtGST.showError(message: "Enter Valid GST number")
                            }
                            
                            self.toastMessage(result.msg ?? "")
                            CustomActivityIndicator.shared.hide()
                        })
       
                    }
                    if tag == 1{
                        let panNo = cell.txtPAN.text ?? ""

                        self.view.endEditing(true)
                        var param :[String:Any] = [:]
                        param = ["documentType":"PANNo", "PANNo":panNo]
                        CustomActivityIndicator.shared.show(in: self.view)
                        // APIs().document_verification_API
                        SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                            
                            if result.status == 1{
                                self.companyPANVerify = result
                               // self.isCompanyDetailsPANVerified = true
                                self.dealerDataStruct.companyPANNo = panNo
                                cell.btnVerifyPan.isHidden = true
                                cell.btnVerifyDonegPan.isHidden = false
                                
                                
                                if let gstDocInfo = self.companyGSTVerify.details {
                                    
                                    if gstDocInfo.companyType != "Proprietorship"{
                                        if gstDocInfo.companyName == self.companyPANVerify.details?.panCompanyName{
                                            self.isCompanyDetailsPANVerified = true

                                        }
                                        else{
                                            self.toastMessage("Kindly enter the pan card associated with gst number")
                                        }
                                    }
                                    
                                }
                                
                            }
                            else{
                                self.isCompanyDetailsPANVerified = false
                                cell.txtPAN.showError(message: "Enter Valid PAN number")
                            }
                            
                            self.toastMessage(result.msg ?? "")
                            CustomActivityIndicator.shared.hide()
                        })
  
                    }
                    else  if tag == 2{
                        
                        let emailStr = cell.txtEmail.text ?? ""
                        if EmailValidation.isValidEmail(emailStr){
                            self.view.endEditing(true)
                            var param  = ["email" : emailStr, "requestOtp": 1]
                            CustomActivityIndicator.shared.show(in: self.view)
                             SignupDataModel().emialVerification(url: APIs().email_verification_API, requestParam: param, completion: { emailVerify , message in
                                 print(emailVerify)
                                 if emailVerify.status == 2{
                                     self.toastMessage(emailVerify.msg ?? "")
                                     self.openPopup(email: emailStr)
                                 }
                                 else{
                                     self.toastMessage(emailVerify.msg ?? "")
                                 }
                                 CustomActivityIndicator.shared.hide()
                                 
                             })
                            
                            
                            
                            self.isCompanyDetailsEmailVerified = true
//                            self.openPopup(email: emailStr)
                        }
                        else{
                            cell.txtEmail.showError(message: emailStr)
                        }
                    }
                }
                
                cell.buttonDocBase64 = { tag in
                    switch tag {
                    case 0:
                        ImagePickerManager().pickImage(self){ image in
                               //here is the image
                            cell.btnGSTDocIcon.setImage(UIImage(named: "done"), for: .normal)
                            self.companyGST = image
                           // print(image)
                           }
                    case 1:
                        ImagePickerManager().pickImage(self){ image in
                               //here is the image
                            cell.btnPANDocIcon.setImage(UIImage(named: "done"), for: .normal)
                            self.companyPAN = image
                           // print(image)
                           }
                    case 2:
                        ImagePickerManager().pickImage(self){ image in
                               //here is the image
                            cell.btnTradeDocIcon.setImage(UIImage(named: "done"), for: .normal)
                            self.companyTrade = image
                           // print(image)
                           }
                    default:
                        ImagePickerManager().pickImage(self){ image in
                               //here is the image
                            cell.btnIECDocIcon.setImage(UIImage(named: "done"), for: .normal)
                            self.companyIEC = image
                           // print(image)
                           }
                    }
                }
                
                cell.buttonBottomSheet = { tag in
                    self.dealerSection = 3
                    self.manageTagBuyperCell(tag: tag)
                }
                
                cell.buttonDropDownCB = { tag in
                    if tag == 0{
                        
                        self.openDropDown(dataArr: self.compaanyTypes, anchorView: cell.txtCompanyType, titleLabel: cell.txtCompanyType, refr: "")
                        
//                        self.dropDown.anchorView = cell.txtCompanyType
//                        self.dropDown.dataSource = self.compaanyTypes
//                        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                          print("Selected item: \(item) at index: \(index)")
//                            cell.txtCompanyType.text = item
//                            self.dropDown.hide()
//
//                        }
//                        self.dropDown.show()
                       
                    }
                    else{
                        
                        self.openDropDown(dataArr: self.businessNature, anchorView: cell.txtBusinessVal, titleLabel: cell.txtBusinessVal, refr: "")
                        
//                        self.dropDown.anchorView = cell.txtBusinessVal
//                        self.dropDown.dataSource = self.businessNature
//                        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                          print("Selected item: \(item) at index: \(index)")
//                            cell.txtBusinessVal.text = item
//                            self.dropDown.hide()
//
//                        }
//                        self.dropDown.show()
                    }
                }
                
                
                return cell
                
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.fotterCell, for: indexPath) as? FooterCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.buttonPressed = { tag in
                    // Handle button action with tag
                    
                    let indexPathDealerCompanyDetais = IndexPath(row: 0, section: 0)
                    if let cellDetails = self.tableViewSingup.cellForRow(at: indexPathDealerCompanyDetais) as? Dealer_CompanyDetailsCell {
                        let data = cellDetails.dataCollectCompanyDetail()
                        print(data)
                    }
                    
//                    let indexPathDealerCompanyBasicInfo = IndexPath(row: 0, section: 2)
//                    if let cellDetails = self.tableViewSingup.cellForRow(at: indexPathDealerCompanyDetais) as? Dealer_BasicCell {
//                        let data = cellDetails.dataCollect()
//                        print(data)
//                    }
                    
                    
                    self.manageTagFooterCell(tag: tag)
                   }
                
                return cell
            }
                
            }
            else{
                switch indexPath.section {
                case 1:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: OutherCountryKYC.cellIdentifierInternationalCell, for: indexPath) as? OutherCountryKYC else {
                            return UITableViewCell()
                        }
                        cell.selectionStyle = .none
                        cell.cellDataDelegate = self
                        cell.indexPath = indexPath
                        
                        cell.buttonPressed = { tag in
                            self.isCellExpandedKYC.toggle()
                            cell.setupData(isExpand: self.isCellExpandedKYC)
                            self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)
                            
                        }
                    
                    cell.buttonPressedPicDoc = { tag in
                        switch tag {
                        case 0:
                            ImagePickerManager().pickImage(self){ image in
                                
                                cell.btnSelectBusinessLic.isHidden = false
                                cell.btnBusinessLicenceNum.isHidden = true
                                
//                                cell.btnBusinessLicenceNum.setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnBusinessLicenceNum.setTitle("", for: .normal)
//                                cell.btnBusinessLicenceNum.backgroundColor = .clear
                                self.businessLicenNum = image
                                
                               // print(image)
                               }
                       
                        default:
                            ImagePickerManager().pickImage(self){ image in
                                   //here is the image
                                cell.btnSelectIEC.isHidden = false
                                cell.btnIECDoc.isHidden = true
                                cell.btnIECDoc.setImage(UIImage(named: "Verify"), for: .normal)
                                cell.btnIECDoc.setTitle("", for: .normal)
                                cell.btnIECDoc.backgroundColor = .clear
                                self.iECDoc = image
                               }
                        }
                       
                    }
                    
                    
                    
                        return cell
                    
                    
                case 2:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.dealer_BasicCell, for: indexPath) as? Dealer_BasicCell else {
                        return UITableViewCell()
                    }
                    cell.selectionStyle = .none
                    cell.cellDataDelegate = self
                    cell.indexPath = indexPath
                    
                    if let panInfo = self.panVerify.details{
                        cell.txtFirstName.text = panInfo.firstName
                        cell.txtLastName.text = panInfo.lastName
                        cell.txtEmail.text = panInfo.email
                        cell.txtContry.text = panInfo.country
                    }
                   
                    cell.btnFlag?.sd_setImage(with: URL(string: APIs().indianFlag), for: .normal, completed: nil)
                    cell.btnCode.setTitle("+91", for: .normal)
                    
                    
                    
                    cell.buttonDropDown = { tag in
                        self.isCellExpandedBasic.toggle()
                        cell.setupData(isExpand: self.isCellExpandedBasic)
                        self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                       }
                    
                    cell.buttonPressed = { tag in
                        if tag == 11 {
                            let emailStr = cell.getEmailCode()
                            if EmailValidation.isValidEmail(emailStr){
                                self.view.endEditing(true)
                                let param  = ["email" : emailStr, "requestOtp": 1]
                                CustomActivityIndicator.shared.show(in: self.view)
                                 SignupDataModel().emialVerification(url: APIs().email_verification_API, requestParam: param, completion: { emailVerify , message in
                                     print(emailVerify)
                                     if emailVerify.status == 2{
                                         self.toastMessage(emailVerify.msg ?? "")
                                         self.openPopup(email: emailStr)
                                     }
                                     else{
                                         self.toastMessage(emailVerify.msg ?? "")
                                     }
                                     CustomActivityIndicator.shared.hide()
                                     
                                 })

                            }
                            else{
                                cell.txtEmail.showError(message: emailStr)
                            }
                        }
                        else{
                            self.dealerSection = 1
                            self.manageTagBuyperCell(tag: tag)
                        }
                        
                    }
                    
                    return cell
                    
                case 3:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.dealer_OtherDocCell, for: indexPath) as? Dealer_OtherDocCell else {
                        return UITableViewCell()
                    }
                    cell.selectionStyle = .none
                    
                    cell.btnDOB = { tag in
                        self.customDatePicker.delegate = self
                        self.customDatePicker.showDatePicker(in: self)

                    }
                    
                    cell.buttonPressed = { tag in
                        self.isCellExpandedOtherD.toggle()
                        self.isDataCellHide = true
                        cell.setupData(isExpand: self.isCellExpandedOtherD)
                        self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                       }
                    
                    cell.buttonPressedAddView = { tag in
    //                    cell.viewBGData1.isHidden = false
    //                    cell.viewBGData2.isHidden = false
                        self.isDataCellHide = false
                        self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)
                    }
                    
                    cell.buttonDocBase64 = { tag in
                        switch tag {
                        case 0:
                            ImagePickerManager().pickImage(self){ image in

                                cell.btnSelectPassportFront.isHidden = false
                                cell.btnPassportFront.isHidden = true
    //                            cell.btnPassportFront.setImage(UIImage(named: "Verify"), for: .normal)
    //                            cell.btnPassportFront.setTitle("", for: .normal)
    //                            cell.btnPassportFront.backgroundColor = .clear
                                self.passportFront = image
                                
                               // print(image)
                               }
                        case 1:
                            ImagePickerManager().pickImage(self){ image in
                                   //here is the image
                                cell.btnSelectPassportBack.isHidden = false
                                cell.btnPassportBack.isHidden = true
    //                            cell.btnPassportBack.setImage(UIImage(named: "Verify"), for: .normal)
    //                            cell.btnPassportBack.setTitle("", for: .normal)
    //                            cell.btnPassportBack.backgroundColor = .clear
                                self.passportBack = image
                               }
    //                    case 2:
    //                        ImagePickerManager().pickImage(self){ image in
    //                               //here is the image
    //                            cell.btnDoc2FrontIcon.setImage(UIImage(named: "done"), for: .normal)
    //                            cell.doc2Front = image
    //                           // print(image)
    //                           }
                        default:
                            ImagePickerManager().pickImage(self){ image in
                                   //here is the image
                                cell.btnSelectDrivingLic.isHidden = false
                                cell.btnLicenceFront.isHidden = true
    //                            cell.btnLicenceFront.setImage(UIImage(named: "Verify"), for: .normal)
    //                            cell.btnLicenceFront.setTitle("", for: .normal)
    //                            cell.btnLicenceFront.backgroundColor = .clear
                                self.drivLicence = image
                               }
                        }
                       
                    }
                    
                    cell.btnVerifyDoc = { tag in
    //                    let dob = cell.txtSelect1.text ?? ""
                        if tag == 0{
                            let passportNum = cell.txtSelect1.text ?? ""
                            let passportDoc = ""
                            if passportDoc != "" && passportDoc == "Passport"{

                                var param :[String:Any] = [:]
                                param = ["documentType" : "otherDocs", "otherDocumentType": passportDoc, "otherDocumentNumber":passportNum, "dob": ""]
                                CustomActivityIndicator.shared.show(in: self.view)
                                SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                    
                                    if result.status ?? 0 == 1{
                                        cell.btnDoc1Verify.isHidden = true
                                        cell.btnDoc1Verified.isHidden = false
    //                                    self.dealerDataStruct.dob = dob
                                        self.dealerDataStruct.otherDocs = cell.returnDocArr()
                                    }
                                    
                                    self.toastMessage(result.msg ?? "")
                                    CustomActivityIndicator.shared.hide()
                                })
                                
                            }
                            else if passportDoc != "" && passportDoc == "Driving License"{
    //                            var isVerify =  self.verifyDoc(otherDocType: "otherDocs", otherDoc: "Driving License", docNumber: passportNum ?? "", dob: dob)
                                
                                var param :[String:Any] = [:]
                                param = ["documentType" : "otherDocs", "otherDocumentType": passportDoc, "otherDocumentNumber":passportNum, "dob": ""]
                                CustomActivityIndicator.shared.show(in: self.view)
                                SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                    
                                    if result.status ?? 0 == 1{
                                        cell.btnDoc1Verify.isHidden = true
                                        cell.btnDoc1Verified.isHidden = false
    //                                    self.dealerDataStruct.dob = dob
                                        self.dealerDataStruct.otherDocs = cell.returnDocArr()
                                    }
                                    
                                    self.toastMessage(result.msg ?? "")
                                    CustomActivityIndicator.shared.hide()
                                })
                            }
                        }
    //                    else if tag == 1{
    //                        let doc2Num = cell.txtSelect2.text ?? ""
    //                        let doc2Doc = cell.lblSelect2.text ?? ""
    //                        if doc2Doc != "" && doc2Doc == "Passport"{
    //                            let isVerify =  self.verifyDoc(otherDocType: "otherDocs", otherDoc: "Passport", docNumber: doc2Num, dob: dob)
    //                            if isVerify == 1{
    //                                cell.btnDoc2Verify.isHidden = true
    //                                cell.btnDoc2Verified.isHidden = false
    //                                self.dealerDataStruct.dob = dob
    //                                self.dealerDataStruct.otherDocs = cell.returnDocArr()
    //                            }
    //                        }
    //                        else if doc2Doc != "" && doc2Doc == "Driving License"{
    //                            let isVerify =  self.verifyDoc(otherDocType: "otherDocs", otherDoc: "Driving License", docNumber: doc2Num, dob: dob)
    //                            if isVerify == 1{
    //                                cell.btnDoc2Verify.isHidden = true
    //                                cell.btnDoc2Verified.isHidden = false
    //                                self.dealerDataStruct.dob = dob
    //                                self.dealerDataStruct.otherDocs = cell.returnDocArr()
    //                            }
    //                        }
    //                    }
                    }
                    
 
                    
                    return cell
                    
                case 0:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.dealer_CompanyDetailCell, for: indexPath) as? Dealer_CompanyDetailsCell else {
                        return UITableViewCell()
                    }
                    cell.selectionStyle = .none
                   
                    
                    cell.buttonPressed = { tag in
                        
                        self.isCellExpandedCompanyD.toggle()
                        cell.setupData(isExpand: self.isCellExpandedCompanyD)
                        self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                       }
                    
//                    cell.btnFlag?.sd_setImage(with: URL(string: APIs().indianFlag), for: .normal, completed: nil)
//                    cell.btnCode.setTitle("+91", for: .normal)
                    
                    cell.buttonVerify = { tag in
                        if tag == 0{
                            let gstNo = cell.txtGST.text ?? ""
    //                        let isVerify = self.verifyDoc(docType: "GSTNo", docNumber: gstNo)
                            
                            let panNo = cell.txtGST.text ?? ""
                            self.view.endEditing(true)
                            var param :[String:Any] = [:]
                            param = ["documentType":"GSTNo", "GSTNo":panNo]
                            CustomActivityIndicator.shared.show(in: self.view)
                            // APIs().document_verification_API
                            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                
                                if result.status == 1{
                                    self.companyGSTVerify = result
                                    self.dealerDataStruct.companyGSTNo = gstNo
                                    cell.btnVerifyGst.isHidden = true
                                    cell.btnVerifyDonegGst.isHidden = false
                                     
                                    cell.txtCompanyName.text = self.companyGSTVerify.details?.companyName
                                    cell.txtEmail.text = self.companyGSTVerify.details?.email
    //                                cell.txtCountry.text = self.companyGSTVerify.details?.country
    //                                cell.txtState.text = self.companyGSTVerify.details?.state
    //                                cell.txtCity.text = self.companyGSTVerify.details?.city
                                    cell.txtIPinNum.text = self.companyGSTVerify.details?.pincode
                                    cell.txtAddress1.text = self.companyGSTVerify.details?.address
                                    cell.txtCompanyType.text = self.companyGSTVerify.details?.companyType
                                    cell.txtBusinessVal.text = self.companyGSTVerify.details?.natureOfBusiness
                                    
                                    if let panDocInfo = self.companyPANVerify.details {
                                        
                                        if self.companyGSTVerify.details?.companyType != "Proprietorship"{
                                            if self.companyGSTVerify.details?.companyName == panDocInfo.panCompanyName && cell.txtCompanyType.text != "Proprietorship"{
                                                self.isCompanyDetailsGSTVerified = true

                                            }
                                            else{
                                                self.toastMessage("Kindly enter the pan card associated with gst number")
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                else{
                                    self.isCompanyDetailsGSTVerified = false
                                    cell.txtGST.showError(message: "Enter Valid GST number")
                                }
                                
                                self.toastMessage(result.msg ?? "")
                                CustomActivityIndicator.shared.hide()
                            })
           
                        }
                        if tag == 1{
                            let panNo = cell.txtPAN.text ?? ""

                            self.view.endEditing(true)
                            var param :[String:Any] = [:]
                            param = ["documentType":"PANNo", "PANNo":panNo]
                            CustomActivityIndicator.shared.show(in: self.view)
                            // APIs().document_verification_API
                            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                
                                if result.status == 1{
                                    self.companyPANVerify = result
                                   // self.isCompanyDetailsPANVerified = true
                                    self.dealerDataStruct.companyPANNo = panNo
                                    cell.btnVerifyPan.isHidden = true
                                    cell.btnVerifyDonegPan.isHidden = false
                                    
                                    
                                    if let gstDocInfo = self.companyGSTVerify.details {
                                        
                                        if gstDocInfo.companyType != "Proprietorship"{
                                            if gstDocInfo.companyName == self.companyPANVerify.details?.panCompanyName{
                                                self.isCompanyDetailsPANVerified = true

                                            }
                                            else{
                                                self.toastMessage("Kindly enter the pan card associated with gst number")
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                else{
                                    self.isCompanyDetailsPANVerified = false
                                    cell.txtPAN.showError(message: "Enter Valid PAN number")
                                }
                                
                                self.toastMessage(result.msg ?? "")
                                CustomActivityIndicator.shared.hide()
                            })
      
                        }
                        else  if tag == 2{
                            
                            let emailStr = cell.txtEmail.text ?? ""
                            if EmailValidation.isValidEmail(emailStr){
                                self.view.endEditing(true)
                                var param  = ["email" : emailStr, "requestOtp": 1]
                                CustomActivityIndicator.shared.show(in: self.view)
                                 SignupDataModel().emialVerification(url: APIs().email_verification_API, requestParam: param, completion: { emailVerify , message in
                                     print(emailVerify)
                                     if emailVerify.status == 2{
                                         self.toastMessage(emailVerify.msg ?? "")
                                         self.openPopup(email: emailStr)
                                     }
                                     else{
                                         self.toastMessage(emailVerify.msg ?? "")
                                     }
                                     CustomActivityIndicator.shared.hide()
                                     
                                 })
                                
                                
                                
                                self.isCompanyDetailsEmailVerified = true
    //                            self.openPopup(email: emailStr)
                            }
                            else{
                                cell.txtEmail.showError(message: emailStr)
                            }
                        }
                    }
                    
                    cell.buttonDocBase64 = { tag in
                        switch tag {
                        case 0:
                            ImagePickerManager().pickImage(self){ image in
                                   //here is the image
                                cell.btnGSTDocIcon.setImage(UIImage(named: "done"), for: .normal)
                                self.companyGST = image
                               // print(image)
                               }
                        case 1:
                            ImagePickerManager().pickImage(self){ image in
                                   //here is the image
                                cell.btnPANDocIcon.setImage(UIImage(named: "done"), for: .normal)
                                self.companyPAN = image
                               // print(image)
                               }
                        case 2:
                            ImagePickerManager().pickImage(self){ image in
                                   //here is the image
                                cell.btnTradeDocIcon.setImage(UIImage(named: "done"), for: .normal)
                                self.companyTrade = image
                               // print(image)
                               }
                        default:
                            ImagePickerManager().pickImage(self){ image in
                                   //here is the image
                                cell.btnIECDocIcon.setImage(UIImage(named: "done"), for: .normal)
                                self.companyIEC = image
                               // print(image)
                               }
                        }
                    }
                    
                    cell.buttonBottomSheet = { tag in
                        self.dealerSection = 3
                        self.manageTagBuyperCell(tag: tag)
                    }
                    
                    cell.buttonDropDownCB = { tag in
                        if tag == 0{
                            
                            self.openDropDown(dataArr: self.compaanyTypes, anchorView: cell.txtCompanyType, titleLabel: cell.txtCompanyType, refr: "")
                            
    //                        self.dropDown.anchorView = cell.txtCompanyType
    //                        self.dropDown.dataSource = self.compaanyTypes
    //                        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
    //                          print("Selected item: \(item) at index: \(index)")
    //                            cell.txtCompanyType.text = item
    //                            self.dropDown.hide()
    //
    //                        }
    //                        self.dropDown.show()
                           
                        }
                        else{
                            
                            self.openDropDown(dataArr: self.businessNature, anchorView: cell.txtBusinessVal, titleLabel: cell.txtBusinessVal, refr: "")
                            
    //                        self.dropDown.anchorView = cell.txtBusinessVal
    //                        self.dropDown.dataSource = self.businessNature
    //                        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
    //                          print("Selected item: \(item) at index: \(index)")
    //                            cell.txtBusinessVal.text = item
    //                            self.dropDown.hide()
    //
    //                        }
    //                        self.dropDown.show()
                        }
                    }
                    
                    
                    return cell
                    
                default:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.fotterCell, for: indexPath) as? FooterCell else {
                        return UITableViewCell()
                    }
                    cell.selectionStyle = .none
                    cell.buttonPressed = { tag in
                        // Handle button action with tag
                        self.manageTagFooterCell(tag: tag)
                       }
                    
                    return cell
                }
            }
            
        default:
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.supplier_CompanyDetailCell, for: indexPath) as? Supplier_CompanyDetails else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
               
                cell.cellDataDelegate = self
                cell.indexPath = indexPath
                
                cell.buttonPressed = { tag in
                    
                    self.isCellExpandedSuppCompanyD.toggle()
                    cell.setupData(isExpand: self.isCellExpandedSuppCompanyD)
                    self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                   }
                
                if let cntryFlg = self.supplierCODetailContryFlag{
                    cell.btnFlag.setTitle(cntryFlg, for: .normal)
                }
                else{
                    cell.btnFlag.setTitle(APIs().indianFlag, for: .normal)
                }
                
                if let cntryCD = self.supplierCODetailContryCode{
                    cell.btnCode.setTitle(cntryCD, for: .normal)
                }
                else{
                    cell.btnCode.setTitle("+91", for: .normal)
                }
                
//                cell.btnFlag?.sd_setImage(with: URL(string: APIs().indianFlag), for: .normal, completed: nil)
//                cell.btnCode.setTitle("+91", for: .normal)
                

                
                cell.buttonBottomSheet = { tag in
                    self.supplierSection = 0
                    self.manageTagBuyperCell(tag: tag)
                }
                
                cell.buttonDropDownCB = { tag in
                    if tag == 2{
                        
                        self.openDropDown(dataArr: self.inventoryTypes, anchorView: cell.txtInventoryType, titleLabel: cell.txtInventoryType, refr: "")
   
                       
                    }

                }
                
                return cell
                
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.supplier_BankInfoCell, for: indexPath) as? Supplier_BankInfoCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
               
                cell.cellDataDelegate = self
                cell.indexPath = indexPath
                
                cell.buttonPressed = { tag in
                    
                    self.isCellExpandedBankInfo.toggle()
                    cell.setupData(isExpand: self.isCellExpandedBankInfo)
                    self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                   }
                
                
                return cell
                
            case 1:
                
                if isIndiaPinForSupplir{
                    
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: SupplierKYCTableViewCell.cellIdentifierSuppComKYC, for: indexPath) as? SupplierKYCTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.selectionStyle = .none
                    cell.cellDataDelegate = self
                    cell.indexPath = indexPath
                    
                    cell.buttonPressed = { tag in
                        self.isCellExpandedSuppIntKYC.toggle()
//                        self.isDataCellHide = true
                        cell.setupData(isExpand: self.isCellExpandedSuppIntKYC)
                        self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)
                        
                    }
                    
                    cell.buttonDropDownCB = { tag in
                         if tag == 0{
                             self.openDropDown(dataArr: self.compaanyTypes, anchorView: cell.txtCompanyType, titleLabel: cell.txtCompanyType, refr: "")
                           

                        }
                        else{
                            
                            self.openDropDown(dataArr: self.businessNature, anchorView: cell.txtNatureOfBusiness, titleLabel: cell.txtNatureOfBusiness, refr: "")
                            
                        }
                    }
                    
                    cell.buttonVerify = { tag in
                        if tag == 0{
//                            let gstNo = cell.txtGST.text ?? ""
//                            let isVerify = self.verifyDoc(docType: "GSTNo", docNumber: gstNo)
                            
                            let gstNo = cell.txtGSTNum.text ?? ""
                            self.view.endEditing(true)
                            var param :[String:Any] = [:]
                            param = ["documentType":"GSTNo", "GSTNo":gstNo]
                            CustomActivityIndicator.shared.show(in: self.view)
                            // APIs().document_verification_API
                            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                
                                if result.status == 1{
                                    self.companyGSTVerify = result
                                    self.dealerDataStruct.companyGSTNo = gstNo
                                    cell.btnVerify.isHidden = true
                                    cell.btnVeriyed.isHidden = false
                                   
                                }
                                else{
                                    cell.txtGSTNum.borderColor = .red
                                    cell.txtGSTNum.showError(message: "Enter Valid GST number")
                                }
                                self.toastMessage(result.msg ?? "")
                                CustomActivityIndicator.shared.hide()
                            })
                            
                        }
                        if tag == 1{
                            let panNo = cell.txtComPAN.text ?? ""
                            
                            self.view.endEditing(true)
                            var param :[String:Any] = [:]
                            param = ["documentType":"PANNo", "PANNo":panNo]
                            CustomActivityIndicator.shared.show(in: self.view)
                            // APIs().document_verification_API
                            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                                
                                if result.status == 1{
                                    self.companyPANVerify = result
                                    // self.isCompanyDetailsPANVerified = true
                                    self.dealerDataStruct.companyPANNo = panNo
                                    cell.btnVerifyPAN.isHidden = true
                                    cell.btnVeriyedPAN.isHidden = false
                            
                                    
                                }
                                else{
                                    cell.txtComPAN.borderColor = .red

                                    cell.txtComPAN.showError(message: "Enter Valid PAN number")
                                }
                                
                                self.toastMessage(result.msg ?? "")
                                CustomActivityIndicator.shared.hide()
                            })
                            
                        }
                    }
                    
                    cell.buttonDocBase64 = { tag in
                        switch tag {
                        case 0:
                            ImagePickerManager().pickImage(self){ image in
                                //here is the image
                                cell.btnSelectedGST.isHidden = false
                                cell.btnGSTDoc.isHidden = true
//                                cell.btnGSTDoc.setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnGSTDoc.titleLabel?.isHidden = true
//                                cell.btnGSTDoc.backgroundColor = .clear
                                self.companyGST = image
                                self.isSupllierPANDoc = true
                                // print(image)
                            }
                        case 1:
                            ImagePickerManager().pickImage(self){ image in
                                //here is the image
                                cell.btnSelectedPAN.isHidden = false
                                cell.btnPANDoc.isHidden = true
//                                cell.btnPANDoc.setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnPANDoc.titleLabel?.isHidden = true
//                                cell.btnPANDoc.backgroundColor = .clear
                                self.companyPAN = image
//                                self.isSupllierPANDoc = true
                                // print(image)
                            }
                        default:
                            ImagePickerManager().pickImage(self){ image in
                                //here is the image
                                cell.btnSelectedIEC.isHidden = false
                                cell.btnIECDoc.isHidden = true
                                
//                                cell.btnIECDoc.setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnIECDoc.titleLabel?.isHidden = true
//                                cell.btnIECDoc.backgroundColor = .clear
                                self.companyIEC = image
                                // print(image)
                            }
                        }
                    }
                    
                    
                    return cell
                }
                else{
                    
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: SupplierINT_KYCTableViewCell.cellIdentifierSuppINT_KYC, for: indexPath) as? SupplierINT_KYCTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.selectionStyle = .none
                    cell.cellDataDelegate = self
                    cell.indexPath = indexPath
                    
                    cell.buttonPressed = { tag in
                        self.isCellExpandedSuppIntKYC.toggle()
//                        self.isDataCellHide = true
                        cell.setupData(isExpand: self.isCellExpandedSuppIntKYC)
                        self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)
                        
                    }
                    
                    cell.buttonDropDownCB = { tag in
                         if tag == 0{
                             self.openDropDown(dataArr: self.compaanyTypes, anchorView: cell.txtCompanyType, titleLabel: cell.txtCompanyType, refr: "")
                           

                        }
                        else{
                            
                            self.openDropDown(dataArr: self.businessNature, anchorView: cell.txtNatureOfBusiness, titleLabel: cell.txtNatureOfBusiness, refr: "")
                            
                        }
                    }
                    
                    cell.buttonGetDocBase64 = { tag in
                        switch tag {
                        case 0:
                            ImagePickerManager().pickImage(self){ image in
                                //here is the image
                                cell.btnSelectedBusinessLic.isHidden = false
                                cell.btnBusinessLincDoc.isHidden = true
//                                cell.btnBusinessLincDoc.setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnBusinessLincDoc.titleLabel?.isHidden = true
//                                cell.btnBusinessLincDoc.backgroundColor = .clear
                                self.businessLicenceDoc = image
//                                self.isSupllierPANDoc = true
                                // print(image)
                            }
                      
                        default:
                            ImagePickerManager().pickImage(self){ image in
                                //here is the image
                                
                                cell.btnSelectedIEC.isHidden = false
                                cell.btnIECDoc.isHidden = true
                                
//                                cell.btnIECDoc.setImage(UIImage(named: "Verify"), for: .normal)
//                                cell.btnIECDoc.titleLabel?.isHidden = true
//                                cell.btnIECDoc.backgroundColor = .clear
                                self.companyIEC = image
                                // print(image)
                            }
                        }
                    }
                    
                    
                    return cell
                }
                
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.supplier_AuthoriseInfoCell, for: indexPath) as? Supplier_AuthorisedPersonCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.cellDataDelegate = self
                cell.indexPath = indexPath
                
                if let cntryFlg = self.supervisorContryFlag{
                    cell.btnFlag.setTitle(cntryFlg, for: .normal)
                }
                else{
                    cell.btnFlag.setTitle(APIs().indianFlag, for: .normal)
                }
                
                if let cntryCD = self.supervisorContryCode{
                    cell.btnCode.setTitle(cntryCD, for: .normal)
                }
                else{
                    cell.btnCode.setTitle("+91", for: .normal)
                }
                
                cell.buttonPressed = { tag in
                    
                    self.isCellExpandedAuthoriseInfo.toggle()
                    cell.setupData(isExpand: self.isCellExpandedAuthoriseInfo)
                    self.tableViewSingup.reloadRows(at: [indexPath], with: .automatic)

                   }
                
                cell.buttonBottomSheet = { tag in
                    self.supplierSection = 1
                    self.manageTagBuyperCell(tag: tag)
                }
                
                return cell
                
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCellIdentifire.fotterCell, for: indexPath) as? FooterCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.buttonPressed = { tag in
                    // Handle button action with tag
                    self.manageTagFooterCell(tag: tag)
                   }
                
                return cell
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            switch self.userType {
            case 0:
                switch indexPath.section {
                case 0:
                    return UITableView.automaticDimension
                default:
                    return UITableView.automaticDimension
                }
            case 1:
                if !self.isIndiaPin{
                    switch indexPath.section {
                    case 1:
                        
                        return isCellExpandedKYC ? 285 : 70
                    
                        
                    case 2:
                        
                        return isCellExpandedBasic ? 360 : 70
                        
                    case 3:
                        
                        if isDataCellHide{
                            return isCellExpandedOtherD ? 400 : 70
                        }
                        else{
                            return  580
                        }
                        
                    case 0:
                        
                        return isCellExpandedCompanyD ? 520 : 70
                        
                    default:
                        return UITableView.automaticDimension
                    }
                }else{
                    switch indexPath.section {
                    case 1:
                        
                        return isCellExpandedKYC ? 412 : 70
                        
                    case 2:
                        
                        return isCellExpandedBasic ? 360 : 70
                        
                    case 3:
                        
                        return isCellExpandedAuthPersion ? 365 : 70
                        
                    case 4:
                        
                        if isDataCellHide{
                            return isCellExpandedOtherD ? 400 : 70
                        }
                        else{
                            return  580
                        }
                        
                    case 0:
                        
                        return isCellExpandedCompanyD ? 520 : 70
                        
                    default:
                        return UITableView.automaticDimension
                    }
                }
            default:
                
               
                switch indexPath.section {
                case 0:
                 
                    return isCellExpandedSuppCompanyD ? 565 : 70
                    
                case 2:
    
                    return isCellExpandedBankInfo ? 410 : 70
                    
                case 1:
    
                    if isIndiaPinForSupplir {
                        return isCellExpandedSuppIntKYC ? 525 : 70
                    }
                    else{
                        return isCellExpandedSuppIntKYC ? 415 : 70
                    }
                    
                    
                case 3:
    
                    return isCellExpandedAuthoriseInfo ? 230 : 70
                    
                default:
                    return UITableView.automaticDimension
                }
            }
        
       }
    
    
    func openPopup(email:String){
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
                let alertSheet = storyboard.instantiateViewController(withIdentifier: "VerifyEmailPopupVC") as? VerifyEmailPopupVC
        alertSheet?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertSheet?.email = email
        alertSheet?.emailVerifyDelegate = self
        alertSheet?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertSheet!, animated: true, completion: nil)
    }
    
    
    func manageTagBuyperCell(tag:Int){
        
            self.btnTag = tag
            print("Button pressed with tag: \(tag)")
            if let bottomSheet = UIStoryboard.init(name: TVCellIdentifire.customAlertStoryboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: TVCellIdentifire.customAlertController) as? CountryListVC{
                if #available(iOS 15.0, *) {
                    if let sheet = bottomSheet.sheetPresentationController{
                        sheet.detents = [.large()]
                        sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                        
                    }
                } else {
                }
                bottomSheet.modalPresentationStyle = .pageSheet
                bottomSheet.countryInfoDelegate = self
                bottomSheet.stateInfoDelegate = self
                bottomSheet.cityInfoDelegate = self
                bottomSheet.isGetStateList = tag
                
                if tag == 2{
                    if self.countryId != Int() {
                        bottomSheet.countryID = self.countryId
                        self.present(bottomSheet, animated: true)
                    }
                    else{
                        self.toastMessage("Please select Country first.")
                    }
                }
                
                else  if tag == 3{
                    if let integer = self.stateID {
                        bottomSheet.stateID = self.stateID ?? 0
                        self.present(bottomSheet, animated: true)
                    }
                    else{
                        self.toastMessage("Please select State first.")
                    }
                }
                else{
                    // bottomSheet.countryID = self.countryId
                    self.present(bottomSheet, animated: true)
                }
                
        }
        
    }
  
    
    
    func getOtherDoc(){
        SignupDataModel().getOtherDocList(url: APIs().otherDoc_list_API, requestParam: [:], completion: { otherDoc, msg in
            if otherDoc.status == 1{
                self.otheraDocList = otherDoc.details ?? ["Driving License", "Passport"]
            }
            else{
                self.otheraDocList = ["Driving License", "Passport"]
            }
            
        })
    }
    
    
}

extension SignupVC : CustomDatePickerDelegate{
    func didSelectDate(date: String) {
        if self.isIndiaPin{
            let indexPath = IndexPath(row: 0, section: 4)
            if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_OtherDocCell {
                cell.txtDOB.text = date
            }
        }
        else{
            let indexPath = IndexPath(row: 0, section: 3)
            if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_OtherDocCell {
                cell.txtDOB.text = date
            }
        }
    }
    
    
}

extension SignupVC : CellDataDelegate{
    func didUpdateText(textKey: String, text: String?, indexPath: IndexPath) {
        switch textKey {
        case "DealerComName":
            self.dealerDataStruct.companyName = text
        case "DealerMobileN":
            self.dealerDataStruct.mobileNo = text
        case "DealerEmail":
            self.dealerDataStruct.email = text
        case "DealerCity":
            self.dealerDataStruct.city = text
        case "DealerState":
            self.dealerDataStruct.state = text
        case "DealerContry":
            self.dealerDataStruct.country = text
        case "DealerPin":
            self.dealerDataStruct.pinCode = text
        case "DealerAddress1":
            self.dealerDataStruct.address = text
        case "DealerAddress2":
            self.dealerDataStruct.address2 = text
        case "DealerComType":
            self.dealerDataStruct.typeOfCompany = text
        case "DealerBusinessNa":
            self.dealerDataStruct.natureOfBusiness = text
            
        case "FName":
            self.dealerDataStruct.firstName = text
        case "LName":
            self.dealerDataStruct.lastName = text
        case "Mobile":
            self.dealerDataStruct.mobileNo = text
        case "Email":
            self.dealerDataStruct.email = text
        case "Password":
            self.dealerDataStruct.password = text
        case "CNPassword":
            self.dealerDataStruct.confirmPassword = text
            
        // supllier Data
        case "CO.GST":
            self.suplierDataStruct.companyGSTNo = text
        case "CO.PAN":
            self.suplierDataStruct.companyPANNo = text
        case "CO.Name":
            self.suplierDataStruct.companyName = text
        case "CO.Mobile":
            self.suplierDataStruct.mobileNo = text
        case "CO.Email":
            self.suplierDataStruct.email = text
        case "CO.Pass":
            self.suplierDataStruct.password = text
        case "CO.CnfPass":
            self.suplierDataStruct.confirmPassword = text
        case "CO.Inventory":
            self.suplierDataStruct.inventoryType = text
            
        case "CO.Country":
            self.suplierDataStruct.country = "\(self.countryId)"
        case "CO.State":
            self.suplierDataStruct.state = "\(self.stateID ?? 0)"
        case "CO.City":
            self.suplierDataStruct.city = "\(self.cityID ?? 0)"
        case "CO.PinC":
            self.suplierDataStruct.pinCode = text
        case "CO.Add1":
            self.suplierDataStruct.address = text
        case "CO.Add2":
            self.suplierDataStruct.address2 = text
        case "CO.TradeN":
            self.suplierDataStruct.tradeMembershipNo = text
        case "CO.IECN":
            self.suplierDataStruct.iecNo = text
            
        case "BusinessLicence":
            self.suplierDataStruct.businessLicenceNumber = text
            
        case "CO.SupervisorName":
            self.suplierDataStruct.authPersonName = text
        case "CO.SupervisorEmail":
            self.suplierDataStruct.authPersonEmail = text
        case "CO.SupervisorMobile":
            self.suplierDataStruct.authPersonContact = text
            
        case "CO.ComType":
            self.suplierDataStruct.typeOfCompany = text
        case "CO.BusinessNature":
            self.suplierDataStruct.natureOfBusiness = text
        case "BNKName":
            self.suplierDataStruct.bankName = text
        case "BNKBranchName":
            self.suplierDataStruct.branchName = text
            
        case "BNKACCNumber":
            self.suplierDataStruct.accountNo = text
        case "BNKACCType":
            self.suplierDataStruct.accountType = text
        case "BNKIFSC":
            self.suplierDataStruct.ifscCode = text
        case "BNKSwiftCode":
            self.suplierDataStruct.swiftCode = text
            
        default:
            print(indexPath)
        }
        
    }
    
    
}



extension SignupVC: CountryInfoDelegate, StateInfoDelegate , CityInfoDelegate, EmialVerifyDelegate {
    func didEmailVerify(status: Int, msg: String) {
        switch self.userType {
        case 0:
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? BuyerCell1 {
            cell.btnVerify.isHidden = true
            cell.btnVerifyDone.isHidden = false
            self.isEmailVerified = status
        }
        case 1:
            if dealerSection == 0{
                let indexPath = IndexPath(row: 0, section: 1)
                if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_BasicCell {
                    cell.btnVerify.isHidden = true
                    cell.btnVerifyDone.isHidden = false
                    self.isBasicInfoEmailVerified = true
                }
            }
            else  if dealerSection == 3{
                let indexPath = IndexPath(row: 0, section: 0)
                if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_CompanyDetailsCell {
                    cell.btnVerifyEmail.isHidden = true
                    cell.btnVerifyDonegEmail.isHidden = false
                    self.isCompanyDetailsEmailVerified = true
                }
            }
        default:
//            if supplierSection == 0{
                let indexPath = IndexPath(row: 0, section: 0)
                if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Supplier_CompanyDetails {
                   // cell.btnVerifyEmail.isHidden = true
                   // cell.btnVerifyDonegEmail.isHidden = false
                    self.isSupllierEmailVerified = true
                }
//            }
//            else  if supplierSection == 3{
//                let indexPath = IndexPath(row: 0, section: 3)
//                if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_CompanyDetailsCell {
//                    cell.btnVerifyEmail.isHidden = true
//                    cell.btnVerifyDonegEmail.isHidden = false
//                    self.isBasicInfoEmailVerified = true
//                }
//            }
        }
    }
    
    func didGetStateName(stateID: Int, stateName: String) {
        switch self.userType {
        case 0:
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? BuyerCell1 {
            cell.txtState.text = stateName
            cell.txtState.borderColor = UIColor.borderClr
        }
        self.stateID = stateID
        self.stateName = stateName
        case 1:
            
            switch self.dealerSection {
            case 1:
            let indexPath = IndexPath(row: 0, section: 1)
            if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_BasicCell {
                cell.txtState.text = stateName
                cell.txtState.borderColor = UIColor.borderClr
            }
            self.stateID = stateID
            self.stateName = stateName
            case 3:
                let indexPath = IndexPath(row: 0, section: 0)
                if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_CompanyDetailsCell {
                    cell.txtState.text = stateName
                    cell.txtState.borderColor = UIColor.borderClr
                }
                self.stateID = stateID
                self.stateName = stateName
            
            default:
                print("")
            }
           
            
        default:
            print("")
//            switch self.supplierSection {
//            case 0:
            let indexPath = IndexPath(row: 0, section: 0)
            if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Supplier_CompanyDetails {
                cell.txtState.text = stateName
                cell.txtState.borderColor = UIColor.borderClr
            }
            self.stateID = stateID
            self.stateName = stateName
//            case 3:
//                let indexPath = IndexPath(row: 0, section: 3)
//                if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_CompanyDetailsCell {
//                    cell.txtState.text = stateName
//                }
//                self.stateID = stateID
//                self.stateName = stateName
            
//            default:
//                print("")
//            }
            
        }
        
    }
    
    func didGetCityName(cityID: Int, cityName: String) {
        switch self.userType {
        case 0:
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? BuyerCell1 {
            cell.txtCity.text = cityName
            cell.txtCity.borderColor = UIColor.borderClr
        }
        self.cityID = cityID
        self.cityName = cityName
        case 1 :
            let indexPath = IndexPath(row: 0, section: 0)
            if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_CompanyDetailsCell {
                cell.txtCity.text = cityName
                cell.txtCity.borderColor = UIColor.borderClr
            }
            self.cityID = cityID
            self.cityName = cityName
        default:
            print("")
            let indexPath = IndexPath(row: 0, section: 0)
            if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Supplier_CompanyDetails {
                cell.txtCity.text = cityName
                cell.txtCity.borderColor = UIColor.borderClr
            }
            self.cityID = cityID
            self.cityName = cityName
        }
    }
    
   
    func didcountryCodeAndName(countryID: Int,countryCode: String, countryName: String, countryFlag: String) {
        print(countryCode)
        self.countryId = countryID
        
        switch self.userType {
        case 0:
            let indexPath = IndexPath(row: 0, section: 0) // Assuming section 0
            if self.btnTag == 0{
                if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? BuyerCell1 {
                    cell.txtCountry.text = countryName
                    cell.btnFlag?.sd_setImage(with: URL(string: countryFlag), for: .normal, completed: nil)
                    cell.btnCode.setTitle(countryCode, for: .normal)
                    
                }
            }
            
            else if self.btnTag == 1 {
                if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? BuyerCell1 {
                    cell.txtCountry.text = countryName
                    
                    cell.txtCity.text = "Select city*"
                    cell.txtState.text = "Select state*"
                    self.cityID = Int()
                    self.cityName = String()
                    self.stateID = Int()
                    self.stateName = String()
                }
            }
        case 1:
            switch self.dealerSection {
            case 1:
                let indexPath = IndexPath(row: 0, section: 1)
                if self.btnTag == 0{
                    if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_BasicCell {
                        cell.txtContry.text = countryName
                        cell.txtContry.borderColor = UIColor.borderClr
                        cell.btnFlag?.sd_setImage(with: URL(string: countryFlag), for: .normal, completed: nil)
                        cell.btnCode.setTitle(countryCode, for: .normal)
                        
                    }
                }
                
                else if self.btnTag == 1 {
                    if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_BasicCell {
                        cell.txtContry.text = countryName
                        cell.txtContry.borderColor = UIColor.borderClr
                        cell.txtState.text = "Select state*"
                        self.stateID = Int()
                        self.stateName = String()
                    }
                }
                
            case 3:
                
                let indexPath = IndexPath(row: 0, section: 0)
                if self.btnTag == 0{
                    if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_CompanyDetailsCell{
                        cell.txtCountry.text = countryName
                        if countryCode == "+91"{
                            self.isIndiaPin = true
                        }
                        else{
                            self.isIndiaPin = false
                            
                        }
                        cell.txtCity.text = "Select city*"
                        cell.txtState.text = "Select state*"
                        cell.txtCountry.borderColor = UIColor.borderClr
                        cell.btnFlag?.sd_setImage(with: URL(string: countryFlag), for: .normal, completed: nil)
                        cell.btnCode.setTitle(countryCode, for: .normal)
                        
                        self.tableViewSingup.reloadData()
                        
                    }
                }
                
                else if self.btnTag == 1 {
                    if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Dealer_CompanyDetailsCell {
                        cell.txtCountry.text = countryName
                        cell.txtCountry.borderColor = UIColor.borderClr
                        cell.txtState.text = "Select state*"
                        self.stateID = Int()
                        self.stateName = String()
                    }
                }
                
            default:
                print("")
            }
            
        default:
            print("")
            if supplierSection == 0{
                let indexPath = IndexPath(row: 0, section: 0)
                if self.btnTag == 0{
                    if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Supplier_CompanyDetails{
                        
                        if countryCode == "+91"{
                            self.isIndiaPinForSupplir = true
                        }
                        else{
                            self.isIndiaPinForSupplir = false
                            
                        }
                        cell.txtCountry.borderColor = UIColor.borderClr
                        cell.txtCountry.text = countryName
                        self.supplierCODetailContryCode = countryCode
                        self.supplierCODetailContryFlag = countryFlag
                        cell.btnFlag?.sd_setImage(with: URL(string: countryFlag), for: .normal, completed: nil)
                        cell.btnCode.setTitle(countryCode, for: .normal)
                        
                        
                        let indexPosition = IndexPath(row: 0, section: 1)
                        tableViewSingup.reloadRows(at: [indexPosition], with: .none)
                    }
                }
                
                else if self.btnTag == 1 {
                    if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Supplier_CompanyDetails {
                        cell.txtCountry.text = countryName
                        cell.txtCountry.borderColor = UIColor.borderClr
                        cell.txtState.text = "Select state*"
                        cell.txtCountry.borderColor = UIColor.borderClr
                        self.stateID = Int()
                        self.stateName = String()
                    }
                }
            }
            else{
                let indexPath = IndexPath(row: 0, section: 3)
                if self.btnTag == 0{
                    if let cell = self.tableViewSingup.cellForRow(at: indexPath) as? Supplier_AuthorisedPersonCell{
                        self.supervisorContryCode = countryCode
                        self.supervisorContryFlag = countryFlag
                        cell.btnFlag?.sd_setImage(with: URL(string: countryFlag), for: .normal, completed: nil)
                        cell.btnCode.setTitle(countryCode, for: .normal)
                        
                    }
                }
            }
        
        }
        
    }
    
}


