//
//  Dealer_CompanyDetailsCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/04/24.
//

import UIKit

class Dealer_CompanyDetailsCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet  var btnDropDown:UIButton!
    
    
    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var btnCode: UIButton!
    @IBOutlet var btnVerifyGst: UIButton!
    @IBOutlet var btnVerifyDonegGst: UIButton!
    
    @IBOutlet var btnGSTDocIcon: UIButton!
    @IBOutlet var btnPANDocIcon: UIButton!
    @IBOutlet var btnTradeDocIcon: UIButton!
    @IBOutlet var btnIECDocIcon: UIButton!
    
    @IBOutlet var btnVerifyPan: UIButton!
    @IBOutlet var btnVerifyDonegPan: UIButton!
    
    @IBOutlet var btnVerifyEmail: UIButton!
    @IBOutlet var btnVerifyDonegEmail: UIButton!
    
    @IBOutlet var txtCity:FloatingTextField!
    @IBOutlet var txtState:FloatingTextField!
    @IBOutlet var txtCountry:FloatingTextField!
    @IBOutlet var txtGST:FloatingTextField!
    @IBOutlet var txtPAN:FloatingTextField!
  
    @IBOutlet var txtMobile:FloatingTextField!
    @IBOutlet var txtEmail:FloatingTextField!
    @IBOutlet var txtCompanyName:FloatingTextField!
    @IBOutlet var txtAddress1:FloatingTextField!
    @IBOutlet var txtAddress2:FloatingTextField!
    @IBOutlet var txtCompanyType:FloatingTextField!
    @IBOutlet var txtBusinessVal:FloatingTextField!
    @IBOutlet var txtTradeNumber:FloatingTextField!
    @IBOutlet var txtIEXNumber:FloatingTextField!
    @IBOutlet var txtIPinNum:FloatingTextField!
    @IBOutlet var btnCompanyType:UIButton!
    @IBOutlet var btnBusinessNature:UIButton!

    
    var buttonPressed : ((Int) -> Void) = {_ in }
    
    var buttonDocBase64 : ((Int) -> Void) = {_ in }
    var buttonVerify : ((Int) -> Void) = {_ in }
    var buttonBottomSheet : ((Int) -> Void) = {_ in }
    var buttonDropDownCB : ((Int) -> Void) = {_ in }
    
    var companyDetailsStruct = CompanyDetailsDataStruct()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        txtGST.delegate = self
        txtPAN.delegate = self
        txtEmail.delegate = self
        
        BaseViewController.setClrUItextField(textFields: [txtCity, txtState, txtCountry, txtMobile, txtEmail, txtAddress1, txtAddress2, txtCompanyType, txtBusinessVal, txtIEXNumber, txtTradeNumber, txtGST, txtPAN, txtCompanyName, txtIPinNum])

        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Check which text field triggered the method
           if textField == txtGST {
               self.btnVerifyGst.isHidden = false
               self.btnVerifyDonegGst.isHidden = true
           } else if textField == txtPAN {
               self.btnVerifyPan.isHidden = false
               self.btnVerifyDonegPan.isHidden = true
           }
        else  if textField == txtEmail {
            self.btnVerifyEmail.isHidden = false
            self.btnVerifyDonegEmail.isHidden = true
        }
        
           return true
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
    
    
    func dataCollectCompanyDetail() -> CompanyDetailsDataStruct{
        
        if self.validateData() {
            companyDetailsStruct.gstNumber = self.txtGST.text ?? ""
            companyDetailsStruct.panNumber = self.txtPAN.text ?? ""
            
            if let title = btnCode.title(for: .normal) {
                companyDetailsStruct.mobileNo = "\(title)\(self.txtMobile.text ?? "")"
            }
            companyDetailsStruct.email = self.txtEmail.text ?? ""
            companyDetailsStruct.companyName = self.txtCompanyName.text ?? ""
            companyDetailsStruct.companyType = self.txtCompanyType.text ?? ""
            
            companyDetailsStruct.country = self.txtCountry.text ?? "India"
            companyDetailsStruct.state = self.txtState.text ?? ""
            companyDetailsStruct.city = self.txtCity.text ?? ""
            companyDetailsStruct.pinCode = self.txtIPinNum.text ?? ""
            companyDetailsStruct.address = self.txtAddress1.text ?? ""
            companyDetailsStruct.address2 = self.txtAddress2.text ?? ""
            
            companyDetailsStruct.businessNature = self.txtBusinessVal.text ?? ""
            companyDetailsStruct.trademembership = self.txtTradeNumber.text ?? ""
            companyDetailsStruct.iecNumber = self.txtIEXNumber.text ?? ""
            
            
        }
        else{
            
        }
        return companyDetailsStruct
            
    }
    
    
    func validateData() -> Bool {
    
       
        
//        guard !txtGST.text!.isEmptyStr else {
//                txtGST.showError(message: ConstentString.gstErr)
//                return false
//            }
        guard !txtPAN.text!.isEmptyStr else {
            txtPAN.showError(message: ConstentString.panErr)
            return false
        }
        guard !txtCompanyName.text!.isEmptyStr else {
            txtCompanyName.showError(message: ConstentString.copnayNameError)
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
        
        guard !txtIPinNum.text!.isEmptyStr else {
            
            txtIPinNum.showError(message: ConstentString.cityPin)
            return false
        }
        
        guard !txtAddress1.text!.isEmptyStr else {
            
            txtAddress1.showError(message: ConstentString.address)
            return false
        }
        
        guard !txtCompanyType.text!.isEmptyStr else {
            txtCompanyType.showError(message: ConstentString.copnayTypeError)
            return false
        }
        
      
        return true
       
    }
    
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
//        self.isExpanded.toggle()
       
        buttonPressed(sender.tag)
    }
    
    @IBAction func buttonActionVerifyDoc(_ sender: UIButton) {

        buttonVerify(sender.tag)
    }
    
    @IBAction func buttonActionDocBase64(_ sender: UIButton) {

        buttonDocBase64(sender.tag)
    }
    
    
    @IBAction func buttonActionBottomsheetList(_ sender: UIButton) {

        buttonBottomSheet(sender.tag)
    }
    
    @IBAction func buttonActionDropdown(_ sender: UIButton) {

        buttonDropDownCB(sender.tag)
    }
    
}
