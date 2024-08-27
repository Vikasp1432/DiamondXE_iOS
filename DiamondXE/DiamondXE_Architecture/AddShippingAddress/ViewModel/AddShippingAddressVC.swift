//
//  AddShippingAddressVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 06/07/24.
//

import UIKit
import DTTextField

class AddShippingAddressVC: BaseViewController, DataReceiver {
    
    func receiveData(_ data: AddressDetail) {
        // Use the received data here
        dataObj = data
    }
    
    var dataObj = AddressDetail()
    
    @IBOutlet var btnHomeTime:UIButton!
    @IBOutlet var btnOfficeTime:UIButton!
    @IBOutlet var btnVerify:UIButton!
    @IBOutlet var btnVerifyDone:UIButton!

    
    @IBOutlet var btnflag:UIButton!
    @IBOutlet var btnCountryCode:UIButton!
    @IBOutlet var btnDropDown:UIButton!
    
    
    @IBOutlet var btnSetDefault:UIButton!
    
    @IBOutlet var btnAddressTime1:UIButton!
    @IBOutlet var btnAddressTime2:UIButton!
    
    @IBOutlet var txtMobile:DTTextField!
    @IBOutlet var txEmail:DTTextField!
    
    @IBOutlet var txtAddress2:DTTextField!
    @IBOutlet var txAddress1:DTTextField!
    @IBOutlet var txtCity:DTTextField!
    @IBOutlet var txPincode:DTTextField!
    
    @IBOutlet var txtState:DTTextField!
    @IBOutlet var txtCountry:DTTextField!
//    @IBOutlet var txtGST:DTTextField!
//    @IBOutlet var txBusinessName:DTTextField!
    
    
    var countryId = 101
    var btnTag = 0
    var stateID : Int?
    var stateName : String?
    
    var cityID : Int?
    var cityName : String?
    
    var isSetDefault = false
    
    var isEmailVerified = 1
    var addressID = Int()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwipeGestureUtility.addSwipeGesture(to: self.view, navigationController: self.navigationController)

        // Do any additional setup after loading the view.
        self.btnVerify.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnHomeTime.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        txEmail.delegate = self
        txtMobile.delegate = self
        txtMobile.paddingX = 100
        txEmail.paddingX = 70
        self.setupData()
    }
    
    
    func setupData(){
        if let addID = self.dataObj.addressID{
            txtMobile.text = self.dataObj.mobileNo
            txEmail.text = self.dataObj.emailID
            txtAddress2.text = self.dataObj.address2
            txAddress1.text = self.dataObj.address1
            txtCity.text = self.dataObj.cityNameS
            txPincode.text = self.dataObj.pinCode
            txtState.text = self.dataObj.stateNameS
            txtCountry.text = self.dataObj.countryNameS
           // txtGST.text = self.dataObj.gstNo
          //  txBusinessName.text = self.dataObj.businessName
            self.cityID = self.dataObj.cityName
            self.countryId = self.dataObj.countryName ?? 0
            self.stateID = self.dataObj.stateName
            self.addressID = addID
            
        }
    }
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let dtTextField = textField as? DTTextField {
            dtTextField.borderColor = UIColor.tabSelectClr
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // Change border color or perform any other actions
           if let customTextField = textField as? DTTextField {
               customTextField.borderColor = UIColor.tabSelectClr
           }
       }
       
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
    }
    

    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnActionTime(_ sender: UIButton){
        if sender.tag == 0{
            btnHomeTime.setTitleColor(.whitClr, for: .normal)
            btnOfficeTime.backgroundColor = .clear
            btnOfficeTime.setTitleColor(.tabSelectClr, for: .normal)
            btnOfficeTime.clearGradient()
            self.btnHomeTime.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        }
        else{
            
            btnHomeTime.backgroundColor = .clear
            btnHomeTime.setTitleColor(.tabSelectClr, for: .normal)
            btnOfficeTime.setTitleColor(.whitClr, for: .normal)
            btnHomeTime.clearGradient()
            self.btnOfficeTime.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            
        }
    }
    
    @IBAction func btnActionApply(_ sender: UIButton){
        self.navigationManager(storybordName: "ShippingModule", storyboardID: "ShippingModuleVC", controller: ShippingModuleVC())
    }
    
    @IBAction func btnActionCountryCode(_ sender: UIButton){
        manageTagBuyperCell(tag: sender.tag)
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
    
    
    
    func callingAPISaveAddress(){
        if validateAllTxtField(){
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
           // let url = APIs().get_AddAddress_API
            let sessnID = getSessionUniqID()
            var url = String()
            if let addID = self.dataObj.addressID{
                 url = APIs().get_UpdateAddress_API
            }
            else{
                 url = APIs().get_AddAddress_API
            }
            
            
            let param :[String:Any] = ["addressId" : "\(addressID)",
                "emailId" :          self.txEmail.text ?? "",
                                       "mobileNo" : "\(self.countryId) \(self.txtMobile.text ?? "")",
                                       "addressType" : "SHIPPING ADDRESS",
                                       "address1" : self.txAddress1.text ?? "",
                                       "address2" : self.txtAddress2.text ?? "",
                                       "pinCode" : self.txPincode.text ?? "",
                                       "isDefault" : self.isEmailVerified,
                                       "GSTNo" : "",
                                       "businessName" : "",
                                       "country" : "\(self.countryId)",
                                       "state" : "\(self.stateID ?? 0)",
                                       "city" : "\(self.cityID ?? 0)"]
          
            ShippingAddressModel().addShippingAddress(url: url, requestParam: param, completion: { data, msg in
                if data.status == 1{
                    self.navigationController?.popViewController(animated: true)
                    self.toastMessage(msg ?? "")
                }
                else{
                    self.toastMessage(msg ?? "")
    //                self.isLoading = false
                }
                CustomActivityIndicator2.shared.hide()

            })
            
          }
    }
    
    @IBAction func btnactionSave(_ sender : UIButton){
        self.callingAPISaveAddress()
    }
    
    
    @IBAction func btnActionVerify(_ sender: UIButton){
        
//        if self.validateEmail() {
//            var email = self.txEmail.text ?? ""
//            
//            var param  = ["email" : email, "requestOtp": 1] as [String : Any]
//            CustomActivityIndicator.shared.show(in: self.view)
//            SignupDataModel().emialVerification(url: APIs().email_verification_API, requestParam: param, completion: { emailVerify , message in
//                print(emailVerify)
//                if emailVerify.status == 2{
//                    self.toastMessage(emailVerify.msg ?? "")
//                    self.openPopup(email: email)
//                }
//                else{
//                    self.toastMessage(emailVerify.msg ?? "")
//                }
//                CustomActivityIndicator.shared.hide()
//                
//            })
//        }
    }
    
//    
//    func validateEmail() -> Bool {
//        
//        guard !txEmail.text!.isEmptyStr else {
//            txEmail.showError(message: ConstentString.firestNErr)
//            return false
//        }
//        return true
//    }
    
    func validateAllTxtField() -> Bool {
        
        guard !txAddress1.text!.isEmptyStr else {
            txAddress1.showError(message: ConstentString.address)
            return false
        }
        guard !txtCountry.text!.isEmptyStr else {
            txtCountry.showError(message: ConstentString.countryErr)
            return false
        }
        guard !txtState.text!.isEmptyStr else {
            txtState.showError(message: ConstentString.stateErr)
            return false
        }
        guard !txtCity.text!.isEmptyStr else {
            txtCity.showError(message: ConstentString.cityErr)
            return false
        }
        
        guard !txPincode.text!.isEmptyStr else {
            txPincode.showError(message: ConstentString.cityPin)
            return false
        }
        
        guard !txtMobile.text!.isEmptyStr else {
            txtMobile.showError(message: ConstentString.mobileErr)
            return false
        }
        
        guard !txEmail.text!.isEmptyStr else {
            txEmail.showError(message: ConstentString.emailErr)
            return false
        }
        return true
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
    
    
    
    
    @IBAction func btnActionSelectChekBox(_ sender: UIButton){
        isSetDefault.toggle()
        if isSetDefault {
            btnSetDefault.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            btnSetDefault.setImage(UIImage(named: "uncheck"), for: .normal)
        }
        
        
    }
    
    
    
}


extension AddShippingAddressVC: CountryInfoDelegate, StateInfoDelegate , CityInfoDelegate, EmialVerifyDelegate {
    func didcountryCodeAndName(countryID: Int, countryCode: String, countryName: String, countryFlag: String) {
        self.txtCountry.text = countryName
        self.countryId = countryID
        self.btnflag?.sd_setImage(with: URL(string: countryFlag), for: .normal, completed: nil)
        self.btnCountryCode.setTitle(countryCode, for: .normal)
    }
    
    func didGetStateName(stateID: Int, stateName: String) {
        self.txtState.text = stateName
        self.stateID = stateID
    }
    
    func didGetCityName(cityID: Int, cityName: String) {
        self.txtCity.text = cityName
        self.cityID = cityID
    }
    
    func didEmailVerify(status: Int, msg: String) {
        self.btnVerify.isHidden = true
        self.btnVerifyDone.isHidden = false
        self.isEmailVerified = status
    }
    
}
