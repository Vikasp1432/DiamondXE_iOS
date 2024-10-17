//
//  ChangePasswordVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/07/24.
//

import UIKit
import DTTextField

class ChangePasswordVC: BaseViewController {
    
    
    @IBOutlet var txtPass:DTTextField!
    @IBOutlet var txNewPass:DTTextField!
    @IBOutlet var txtConfrimPass:DTTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPass.delegate = self
        txNewPass.delegate = self
        txtConfrimPass.delegate = self
        txtConfrimPass.isSecureTextEntry = true
        txNewPass.isSecureTextEntry = true
        txtPass.isSecureTextEntry = true
        txtPass.placeholderColor = UIColor.clrGray
        txNewPass.placeholderColor = UIColor.clrGray
        txtConfrimPass.placeholderColor = UIColor.clrGray
        
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func btnActionDone(_ sender: UIButton){
        callingAPIUpdatePass()
    }
    
    func callingAPIUpdatePass(){
        if validateAllTxtField(){
           
           
            let sessnID = getSessionUniqID()
            var url =  APIs().updatePassword_API
            
            
            
            
            if isValidPassword(password: self.txNewPass.text ?? "", confirmPassword: self.txtConfrimPass.text ?? "") {
                print("Password is valid")
                CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
                let param :[String:Any] = ["CurrentPassword" : self.txtPass.text ?? "",
                                           "Password" :          self.txNewPass.text ?? "",
                                           "ConfirmPassword" : self.txtConfrimPass.text ?? ""
                ]
                
                HomeDataModel().changePasswordAPI(url: url, requestParam: param, completion: { data, msg in
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
            } else {
                return
            }
            
          }
    }
    
    func isValidPassword(password: String, confirmPassword: String) -> Bool {
        if password != confirmPassword {
            self.toastMessage("Passwords do not match")
                return false
            }
            
            // Check if the password is at least 6 characters long
            if password.count < 8 {
                self.toastMessage("Password must be at least 8 characters long")
                return false
            }
            
            // Regular expression for at least one uppercase letter
            let uppercaseLetterRegex = ".*[A-Z]+.*"
            let uppercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)
            if !uppercaseLetterTest.evaluate(with: password) {
                self.toastMessage("Password must contain at least one uppercase letter")
                return false
            }
            
            // Regular expression for at least one special character
            let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
            let specialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
            if !specialCharacterTest.evaluate(with: password) {
                self.toastMessage("Password must contain at least one special character")
                return false
            }
            
            // All conditions are satisfied
            return true
    }
    
    func validateAllTxtField() -> Bool {
        
        guard !txtPass.text!.isEmptyStr else {
            txtPass.showError(message: ConstentString.oldpassErr)
            return false
        }
        guard !txNewPass.text!.isEmptyStr else {
            txNewPass.showError(message: ConstentString.newpassErr)
            return false
        }
        guard !txtConfrimPass.text!.isEmptyStr else {
            txtConfrimPass.showError(message: ConstentString.confirmpassErr)
            return false
        }
       
        return true
    }
    

}
