//
//  ForgotPasswordVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 19/04/24.
//

import UIKit
import DTTextField


class ForgotPasswordVC: BaseViewController {
   
    @IBOutlet weak var viewEnterEmail: UIView!
    @IBOutlet weak var viewEnterOTP: UIView!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var txtEmail: DTTextField!
    @IBOutlet weak var txtOTP: DTTextField!
    
    @IBOutlet var txtNewPassword: DTTextField!
    @IBOutlet var txtConfirmPassword: DTTextField!
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var viewConfirmPass: UIView!
    
    @IBOutlet weak var btnContinue: UIButton!

    
    var forgotPassParamStruct = ForgotPassParamStruct()
    var resetPassParam = ResetPasswordStruct()


    
    var isReset = true
    let emailMessage  = NSLocalizedString("Email is required.", comment: "")
    let OTPMessage  = NSLocalizedString("OTP is required.", comment: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.delegate = self
        txtOTP.delegate = self
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.viewEnterOTP.isHidden = true
        self.viewPass.isHidden = true
        self.viewConfirmPass.isHidden = true
        self.timerLabel.isHidden  = true
        self.btnResendOTP.isHidden  = true
        
        btnContinue.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        self.txtEmail.placeholderColor = .themeClr
        self.txtEmail.floatPlaceholderActiveColor = .themeClr
        self.txtOTP.placeholderColor = .themeClr
        self.txtOTP.floatPlaceholderActiveColor = .themeClr
        self.txtEmail.floatPlaceholderColor = .themeClr
        self.txtOTP.floatPlaceholderColor = .themeClr
        
        
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
    
    @IBAction func btnActionResendOTP(_ sender: UIButton){
        print("Resent")
    }
    
    @IBAction func btnActionContinue(_ sender: UIButton){
      
        if isReset {
            guard validateDataEmail() else { return }
            self.forgotPassParamStruct.userType = "Buyer"
            self.forgotPassParamStruct.email = self.txtEmail.text ?? ""
            
            var parameters : [String:Any]?
            parameters =  [
                "userType": self.forgotPassParamStruct.userType ?? "",
                "email": self.forgotPassParamStruct.email ?? ""
            ]
            
            if let param = parameters{
                self.getOTPONMail(param: param)
            }
        }
        else{
            guard validateDataOTP() else { return }
            
            let pass = self.txtNewPassword.text ?? ""
            let CNpass = self.txtConfirmPassword.text ?? ""
             
            if pass == CNpass{
                
                self.resetPassParam.email = self.txtEmail.text ?? ""
                self.resetPassParam.otp =  Int(self.txtOTP.text ?? "")
                self.resetPassParam.resetPassword = 0
                
                var parameters : [String:Any]?
                parameters =  [
                    "email": self.resetPassParam.email ?? "",
                    "otp": self.resetPassParam.otp ?? 0,
                    "password": pass,
                    "confirmPassword" : CNpass
                ]
                
                
                if let param = parameters{
                    self.resetPass(param: param)
                }
            }else{
                self.toastMessage("Password and confirm password not same")
            }
           
        }
            
            
        }
        
        func validateDataEmail() -> Bool {
            
            guard !txtEmail.text!.isEmptyStr else {
                txtEmail.showError(message: ConstentString.emailErr)
                txtEmail.borderColor = .red
                return false
            }
            
          
            
            return true
        }
        
        func validateDataOTP() -> Bool {
            
            guard !txtOTP.text!.isEmptyStr else {
                txtOTP.showError(message: ConstentString.emailErr)
                return false
            }
            
            guard !txtNewPassword.text!.isEmptyStr else {
                txtNewPassword.showError(message: ConstentString.passErr)
                return false
            }
            
            guard !txtConfirmPassword.text!.isEmptyStr else {
                txtConfirmPassword.showError(message: ConstentString.cnPassErr)
                return false
            }
            
            
            return true
        }
        
        
        
    func getOTPONMail(param : [String:Any]) {
            // callAPI_Login
            view.endEditing(true)
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            LoginDataModel().forgotPassword(url: APIs().forgot_passwordAPI, requestParam: param, completion: { response , message in
                print(response)
                if response.status == 1{
                    //print(message)
                    self.viewEnterOTP.isHidden = false
                    self.viewPass.isHidden = false
                    self.viewConfirmPass.isHidden = false
                    self.timerLabel.isHidden  = false
                    self.btnResendOTP.isHidden  = false
                    self.isReset = false
                    self.btnContinue.setTitle("Save", for: .normal)
                    self.btnResendOTP.isEnabled = false
                    TimerManager.shared.startTimer(withLabel: self.timerLabel) {
                        self.btnResendOTP.isEnabled = true
                    }
                }
                else{
                    self.toastMessage(message ?? "")
                }
                
                CustomActivityIndicator2.shared.hide()
                
            })
            
           
        }
    
    func resetPass(param : [String:Any]) {
            // callAPI_Login
            view.endEditing(true)
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            LoginDataModel().resetPassword(url: APIs().reset_passwordAPI, requestParam: param, completion: { response , message in
               
                if response.status == 1{
                    self.toastMessage(message ?? "")
                    let data = self.resetPassParam
                    self.navigationController?.popViewController(animated: true)
                    
//                    self.navigationManager(ResetPasswordVC.self, storyboardName: "Login", storyboardID: "ResetPasswordVC", data: data)
                    
                    print(self.resetPassParam)
                }
                else{
                    self.toastMessage(message ?? "")
                }
                
                CustomActivityIndicator2.shared.hide()
                
            })
            
           
        }
    
    
    
}
