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
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
           
            let sessnID = getSessionUniqID()
            var url =  APIs().updatePassword_API
           
            
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
            
          }
    }
    

    
    func validateAllTxtField() -> Bool {
        
        guard !txtPass.text!.isEmptyStr else {
            txtPass.showError(message: ConstentString.address)
            return false
        }
        guard !txNewPass.text!.isEmptyStr else {
            txNewPass.showError(message: ConstentString.countryErr)
            return false
        }
        guard !txtConfrimPass.text!.isEmptyStr else {
            txtConfrimPass.showError(message: ConstentString.stateErr)
            return false
        }
       
        return true
    }
    

}
