//
//  DXELUXEViewController.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/10/24.
//

import UIKit
import DTTextField
import SDWebImage

class DXELUXEViewController: BaseViewController {
    
    @IBOutlet var txtFirstName:DTTextField!
    @IBOutlet var txtLastName:DTTextField!
    @IBOutlet var txtMobile:DTTextField!
    @IBOutlet var txtEmail:DTTextField!
    @IBOutlet var dataView:UIView!
    @IBOutlet var btnVerify:UIButton!
    @IBOutlet var btnVerified:UIButton!
    
    @IBOutlet var btnContryCode:UIButton!
    @IBOutlet var btnDropDown:UIButton!
    @IBOutlet var btnFlag:UIButton!

    
    @IBOutlet var btnVerifyMo:UIButton!
    @IBOutlet var btnVerifiedMo:UIButton!
    private let gradientLayer = CAGradientLayer()
    var userEmail = String()
    var isEmailVerify = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        btnVerify.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        btnVerifyMo.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        gradientLayer.colors = [UIColor.themeClr.cgColor, UIColor.goldenClr.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        dataView.layer.insertSublayer(gradientLayer, at: 0)
        
        txtMobile.paddingX = 110
        txtFirstName.dtLayer.backgroundColor = UIColor.themeFadeClr.cgColor
        txtLastName.dtLayer.backgroundColor = UIColor.themeFadeClr.cgColor
        txtMobile.dtLayer.backgroundColor = UIColor.themeFadeClr.cgColor
        txtEmail.dtLayer.backgroundColor = UIColor.themeFadeClr.cgColor
        txtEmail.delegate = self

        let loginData = UserDefaultManager().retrieveLoginData()
        if let userType = loginData?.details{
            self.txtFirstName.text = userType.firstName
            self.txtLastName.text = userType.lastName
            userEmail = userType.email ?? ""
            self.txtEmail.text = userType.email
           // self.btnContryCode.setTitle(userType., for: .normal)
            let companyContact = userType.mobileNo
            let numStr = companyContact?.split(separator: " ")
            if  numStr?.count ?? 0 > 1{
                self.txtMobile.text = "\(numStr?[1] ?? "")"
                self.btnContryCode.setTitle("\(numStr?[0] ?? "")", for: .normal)
            }
            isEmailVerify = 1
            self.btnVerifyMo.isHidden = true
            self.btnVerifiedMo.isHidden = true
            self.btnVerify.isHidden = true
            self.btnVerified.isHidden = false
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if let currentText = textField.text as NSString? {
               let updatedText = currentText.replacingCharacters(in: range, with: string)
               
               let textWithoutSpaces = updatedText.replacingOccurrences(of: " ", with: "")

               
               if userEmail == textWithoutSpaces{
                   isEmailVerify = 1
                   self.btnVerify.isHidden = true
                   self.btnVerified.isHidden = false
               }
               else{
                   isEmailVerify = 0
                   self.btnVerify.isHidden = false
                   self.btnVerified.isHidden = true
               }
               
           }
           
           return true // Returning true allows the text change
       }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = dataView.bounds
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionCountryCode(_ sender: UIButton) {
        manageTagBuyperCell()
    }
    
    @IBAction func btnActionSubmit(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        
        guard !txtFirstName.text!.isEmptyStr else {
            txtFirstName.showError(message: "Enter first name")
           return
        }
        
        guard !txtLastName.text!.isEmptyStr else {
            txtLastName.showError(message: "Enter last name")
           return
        }
        
        guard !txtEmail.text!.isEmptyStr else {
            txtEmail.showError(message: "Enter email")
           return
        }
        if isEmailVerify == 1{
            submittedRequestDXELUX()
        }
        else{
            txtEmail.showError(message: "Verify your email")
        }
        
       // submittedRequestDXELUX()
        
    }
    
    @IBAction func btnActionVerified(_ sender: UIButton) {

        verifyEmail()
    }
    
    func submittedRequestDXELUX() {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        let url = APIs().getDXELUXRequest_API
        let tstMobl = txtMobile.text?.replacingOccurrences(of: " ", with: "")
        let mobileNo = "\(self.btnContryCode.currentTitle ?? "")\(" ")\(tstMobl ?? "")"
        let param :[String:Any] = ["firstName": txtFirstName.text?.replacingOccurrences(of: " ", with: "") ?? "",
                                   "lastName": txtLastName.text?.replacingOccurrences(of: " ", with: "") ?? "",
                                   "mobileNo": mobileNo,
                                   "emailId": txtEmail.text?.replacingOccurrences(of: " ", with: "") ?? ""]
      
        HomeDataModel().getUpdateDealerMarkup(param: param, url: url, completion: { data, msg in
            CustomActivityIndicator2.shared.hide()
            if data.status == 1{
                self.navigationController?.popViewController(animated: true)
            }
            self.toastMessage(data.msg ?? "")
            
        })
        
      }
    
    
    func manageTagBuyperCell(){
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
                self.present(bottomSheet, animated: true)
              
                
        }
        
    }
    
    func verifyEmail(){
        guard !txtEmail.text!.isEmptyStr else {
           return
        }
        let emailStr = txtEmail.text?.replacingOccurrences(of: " ", with: "")
        if EmailValidation.isValidEmail(emailStr ?? ""){
            self.view.endEditing(true)
            let param  = ["email" : emailStr, "requestOtp": 1] as [String : Any]
            CustomActivityIndicator.shared.show(in: self.view)
             SignupDataModel().emialVerification(url: APIs().email_verification_API, requestParam: param, completion: { emailVerify , message in
                 CustomActivityIndicator.shared.hide()
                 print(emailVerify)
                 if emailVerify.status == 2{
                     self.toastMessage(emailVerify.msg ?? "")
                     self.openPopup(email: emailStr ?? "")
                 }
                 else{
                     self.toastMessage(emailVerify.msg ?? "")
                 }
                 
             })

        }
        else{
            txtEmail.showError(message: emailStr)
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
  
}

extension DXELUXEViewController : CountryInfoDelegate, EmialVerifyDelegate{
    func didEmailVerify(status: Int, msg: String) {
        isEmailVerify = status
        btnVerify.isHidden = true
        btnVerified.isHidden = false
    }
    
    func didcountryCodeAndName(countryID: Int, countryCode: String, countryName: String, countryFlag: String) {
       // self.txtMobile
        self.btnContryCode.setTitle(countryCode, for: .normal)
        btnFlag.sd_setImage(with: URL(string: countryFlag), for: .normal)
    }

    
}
