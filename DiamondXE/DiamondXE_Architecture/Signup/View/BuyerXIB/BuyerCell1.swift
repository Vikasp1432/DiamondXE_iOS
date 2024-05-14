//
//  BuyerCell1.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/04/24.
//

import UIKit

class BuyerCell1: UITableViewCell, UITextFieldDelegate {

    var buttonPressed : ((Int) -> Void) = {_ in }
    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var btnCode: UIButton!
    @IBOutlet var btnVerify: UIButton!
    @IBOutlet var btnVerifyDone: UIButton!
    
    @IBOutlet var txtCity:FloatingTextField!
    @IBOutlet var txtState:FloatingTextField!
    @IBOutlet var txtCountry:FloatingTextField!
    @IBOutlet var txtCityCode:FloatingTextField!
    @IBOutlet var txtFirstName:FloatingTextField!
    @IBOutlet var txtLastName:FloatingTextField!
    @IBOutlet var txtMobile:FloatingTextField!
    @IBOutlet var txtEmail:FloatingTextField!
    @IBOutlet var txtPassword:FloatingTextField!
    @IBOutlet var txtConfirmPass:FloatingTextField!
    @IBOutlet var txtAddress1:FloatingTextField!
    @IBOutlet var txtAddress2:FloatingTextField!

    var buyerDataParam = BuyerParamDataStruct()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        txtCountry.delegate = self
        txtState.delegate = self
        txtCity.delegate = self
        txtCityCode.delegate = self
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtMobile.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPass.delegate = self
        txtAddress1.delegate = self
        txtAddress2.delegate = self
        btnVerifyDone.isHidden = true
        
     
        BaseViewController.setClrUItextField(textFields: [txtCity, txtState, txtCountry, txtMobile, txtEmail, txtAddress1, txtAddress2, txtFirstName, txtLastName, txtPassword, txtConfirmPass])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        buttonPressed(sender.tag)
    }
    
    
    
    
    func dataCollect() -> BuyerParamDataStruct{
        
        if self.validateData() {
            buyerDataParam.firstName = self.txtFirstName.text ?? ""
            buyerDataParam.lastName = self.txtLastName.text ?? ""
            
            if let title = btnCode.title(for: .normal) {
                buyerDataParam.mobileNo = "\(title)\(self.txtMobile.text ?? "")"
            }
            buyerDataParam.email = self.txtEmail.text ?? ""
            buyerDataParam.password = self.txtPassword.text ?? ""
            buyerDataParam.confirmPassword = self.txtConfirmPass.text ?? ""
            buyerDataParam.country = self.txtCountry.text ?? "India"
            buyerDataParam.state = self.txtState.text ?? ""
            buyerDataParam.city = self.txtCity.text ?? ""
            buyerDataParam.pinCode = self.txtCityCode.text ?? ""
            buyerDataParam.address = self.txtAddress1.text ?? ""
            buyerDataParam.address2 = self.txtAddress2.text ?? ""
            
        }
        else{
            
        }
        return buyerDataParam
            
    }
    
    func getEmailCode() -> String {
       
        guard !txtEmail.text!.isEmptyStr else {
            return "Enter email first"
        }
        
       if EmailValidation.isValidEmail(txtEmail.text ?? ""){
           return txtEmail.text ?? ""
        }
        else{
            return "Enter valid email"
        }
       
    }
    
    
    func validateData() -> Bool {
    
            guard !txtFirstName.text!.isEmptyStr else {
                txtFirstName.showError(message: ConstentString.firestNErr)
                return false
            }
        guard !txtLastName.text!.isEmptyStr else {
            txtLastName.showError(message: ConstentString.lastNErr)
            return false
        }
        guard !txtMobile.text!.isEmptyStr else {
            txtMobile.showError(message: ConstentString.mobileErr)
            return false
        }
        guard !txtEmail.text!.isEmptyStr else {
            txtEmail.showError(message: ConstentString.emailErr)
            return false
        }
            
            guard !txtPassword.text!.isEmptyStr else {
                txtPassword.showError(message: ConstentString.passErr)
                return false
            }
        
        guard !txtConfirmPass.text!.isEmptyStr else {
            txtConfirmPass.showError(message: ConstentString.cnPassErr)
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
        
        guard !txtCityCode.text!.isEmptyStr else {
            txtCityCode.showError(message: ConstentString.cityPin)
            return false
        }
        
        guard !txtAddress1.text!.isEmptyStr else {
            txtAddress1.showError(message: ConstentString.address)
            return false
        }
            return true
       
    }
    
    
}
