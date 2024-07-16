//
//  Dealer_BasicCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/04/24.
//

import UIKit
import DTTextField

class Dealer_BasicCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet var btnDropDown:UIButton!
    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var btnCode: UIButton!
    @IBOutlet var btnVerify: UIButton!
    @IBOutlet var btnVerifyDone: UIButton!
    
    
    //
    @IBOutlet var txtState:DTTextField!
    @IBOutlet var txtContry:DTTextField!
    @IBOutlet var txtFirstName:DTTextField!
    @IBOutlet var txtLastName:DTTextField!
    @IBOutlet var txtMobile:DTTextField!
    @IBOutlet var txtEmail:DTTextField!
    @IBOutlet var txtPassword:DTTextField!
    @IBOutlet var txtConfirmPass:DTTextField!
    @IBOutlet var viewBG:UIView!

    
    var buttonDropDown : ((Int) -> Void) = {_ in }
    var buttonPressed : ((Int) -> Void) = {_ in }
    
    var basicDataParam = BasicCellParamDataStruct()
    
    var cellDataDelegate : CellDataDelegate?
    var indexPath = IndexPath()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        
        txtPassword.isSecureTextEntry = true
        txtConfirmPass.isSecureTextEntry = true
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtMobile.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPass.delegate = self
        txtMobile.paddingX = 110

        btnVerifyDone.isHidden = true
        
      //txtContry, txtState, txtContry,
        BaseViewController.setClrUItextField2(textFields: [ txtMobile, txtEmail, txtFirstName, txtLastName, txtPassword, txtConfirmPass])
        
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
        
      if let text = txtFirstName.text {
       
          cellDataDelegate?.didUpdateText(textKey: "FName", text: text, indexPath: indexPath)
          
      }
        if let text = txtLastName.text {
            cellDataDelegate?.didUpdateText(textKey: "LName", text: text, indexPath: indexPath)
        }
        
        if let text = txtMobile.text {
            if let title = btnCode.title(for: .normal) {
                cellDataDelegate?.didUpdateText(textKey: "Mobile", text: "\(title)\(text)", indexPath: indexPath)
            }            
        }
          if let text = txtEmail.text {
              cellDataDelegate?.didUpdateText(textKey: "Email", text: text, indexPath: indexPath)
          }
        
        if let text = txtPassword.text {
         
            cellDataDelegate?.didUpdateText(textKey: "Password", text: text, indexPath: indexPath)
            
        }
          if let text = txtConfirmPass.text {
              cellDataDelegate?.didUpdateText(textKey: "CNPassword", text: text, indexPath: indexPath)
          }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // Change border color or perform any other actions
           if let customTextField = textField as? DTTextField {
               customTextField.borderColor = UIColor.tabSelectClr
           }
       }
       
 
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check which text field triggered the method
        if textField == txtEmail {
            self.btnVerify.isHidden = false
            self.btnVerifyDone.isHidden = true
        }
        if let dtTextField = textField as? DTTextField {
            dtTextField.borderColor = UIColor.tabSelectClr
        }
        return true
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
    
    
    func setupData(isExpand:Bool){
        if isExpand{
            viewBGData.isHidden = true
            btnDropDown.setImage( UIImage(named: "d_down"), for: .normal)

        }
        else{
            viewBGData.isHidden = false
            btnDropDown.setImage(UIImage(named: "d_up"), for: .normal)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        buttonPressed(sender.tag)
        
    }
    
    @IBAction func buttonActionDD(_ sender: UIButton) {
        buttonDropDown(sender.tag)
       
    }
    
    func dataCollect() -> BasicCellParamDataStruct{
        
        if self.validateData() {
            basicDataParam.firstName = self.txtFirstName.text ?? ""
            basicDataParam.lastName = self.txtLastName.text ?? ""
            if let title = btnCode.title(for: .normal) {
                basicDataParam.mobileNo = "\(title)\(self.txtMobile.text ?? "")"
            }
            basicDataParam.email = self.txtEmail.text ?? ""
            basicDataParam.password = self.txtPassword.text ?? ""
            basicDataParam.confirmPassword = self.txtConfirmPass.text ?? ""
//            basicDataParam.country = self.txtContry.text ?? "India"
//            basicDataParam.state = self.txtState.text ?? ""
            return basicDataParam
        }
        else{
            return basicDataParam
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
        
//        guard !txtContry.text!.isEmptyStr else {
//            
//            txtContry.showError(message: ConstentString.countryErr)
//            return false
//        }
//        
//        guard !txtState.text!.isEmptyStr else {
//            
//            txtState.showError(message: ConstentString.stateErr)
//            return false
//        }
        
        
        return true
        
    }
}
