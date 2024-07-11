//
//  ResetPasswordVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 19/04/24.
//

import UIKit
import DTTextField

@available(iOS 13.0, *)
class ResetPasswordVC: BaseViewController , DataReceiver{
    var resetPassStruct =  ResetPasswordStruct()
    
    
    func receiveData(_ data: ResetPasswordStruct) {
        // Use the received data here
        resetPassStruct = data
    }
    
    
    
    @IBOutlet var txtNewPassword: DTTextField!
    @IBOutlet var txtConfirmPassword: DTTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNewPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        self.txtNewPassword.placeholderColor = .themeClr
        self.txtNewPassword.floatPlaceholderActiveColor = .themeClr
        self.txtConfirmPassword.placeholderColor = .themeClr
        self.txtConfirmPassword.floatPlaceholderActiveColor = .themeClr
        self.txtNewPassword.floatPlaceholderColor = .themeClr
        self.txtConfirmPassword.floatPlaceholderColor = .themeClr
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
    
    
    func resetPassword(param : [String:Any]) {
        // callAPI_Login
        view.endEditing(true)
        CustomActivityIndicator.shared.show(in: view)
        LoginDataModel().resetPassword(url: APIs().reset_passwordAPI, requestParam: param, completion: { response , message in
            print(response)
            if response.status == 1{
                self.toastMessage(message ?? "")
                self.poptoRoot()
            }
            else{
                self.toastMessage(message ?? "")
            }
            
            CustomActivityIndicator.shared.hide()
            
        })
        
        
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        poptoRoot()
        
        
    }
    
    @IBAction func btnActionUpdate(_ sender: UIButton){
        guard validateDataOTP() else { return }
        
        resetPassStruct.password = "Test@123"
        resetPassStruct.confirmPassword = "Test@123"
        resetPassStruct.resetPassword = 1
        
        
        let param : [String:Any] = [
            "email": resetPassStruct.email ?? "",
            "otp": resetPassStruct.otp ?? 0,
            "resetPassword": resetPassStruct.resetPassword ?? 0, // For update password
            "password": resetPassStruct.password ?? "",
            "confirmPassword": resetPassStruct.confirmPassword ?? ""
        ]
        
        
        self.resetPassword(param: param)
    }
    
    func validateDataOTP() -> Bool {
        
        guard !txtNewPassword.text!.isEmptyStr else {
            txtNewPassword.showError(message: ConstentString.emailErr)
            txtNewPassword.borderColor = .red

            return false
        }
        
        guard !txtConfirmPassword.text!.isEmptyStr else {
            txtConfirmPassword.showError(message: ConstentString.emailErr)
            txtConfirmPassword.borderColor = .red
            return false
        }
        
        
        return true
    }
}
