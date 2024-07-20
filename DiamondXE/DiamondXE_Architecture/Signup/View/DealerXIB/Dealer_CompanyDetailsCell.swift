//
//  Dealer_CompanyDetailsCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/04/24.
//

import UIKit
import DTTextField

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
    
    @IBOutlet var txtCity:DTTextField!
    @IBOutlet var txtState:DTTextField!
    @IBOutlet var txtCountry:DTTextField!
    @IBOutlet var txtGST:DTTextField!
    @IBOutlet var txtPAN:DTTextField!
  
    @IBOutlet var txtMobile:DTTextField!
    @IBOutlet var txtEmail:DTTextField!
    @IBOutlet var txtCompanyName:DTTextField!
    @IBOutlet var txtAddress1:DTTextField!
    @IBOutlet var txtAddress2:DTTextField!
    @IBOutlet var txtCompanyType:DTTextField!
    @IBOutlet var txtBusinessVal:DTTextField!
    @IBOutlet var txtTradeNumber:DTTextField!
    @IBOutlet var txtIEXNumber:DTTextField!
    @IBOutlet var txtIPinNum:DTTextField!
    @IBOutlet var btnCompanyType:UIButton!
    @IBOutlet var btnBusinessNature:UIButton!
    
    @IBOutlet var viewBG:UIView!
    
    @IBOutlet var viewCountry: UIView!
    @IBOutlet var viewState: UIView!
    @IBOutlet var viewCity: UIView!
    
    var cellDataDelegate : CellDataDelegate?
    var indexPath = IndexPath()
    
    var buttonPressed : ((Int) -> Void) = {_ in }
    
    var buttonDocBase64 : ((Int) -> Void) = {_ in }
    var buttonVerify : ((Int) -> Void) = {_ in }
    var buttonBottomSheet : ((Int) -> Void) = {_ in }
    var buttonDropDownCB : ((Int) -> Void) = {_ in }
    
    var companyDetailsStruct = CompanyDetailsDataStruct()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        
        txtCity.delegate = self
        txtState.delegate = self
        txtEmail.delegate = self
        txtCountry.delegate = self
        txtMobile.delegate = self
        txtCompanyName.delegate = self
        
        txtAddress1.delegate = self
        txtAddress2.delegate = self
        txtCompanyType.delegate = self
        txtBusinessVal.delegate = self
        txtIPinNum.delegate = self
        
        txtMobile.paddingX = 110

        
        BaseViewController.setClrUItextField2(textFields: [txtCity, txtState, txtCountry, txtMobile, txtEmail, txtAddress1, txtAddress2, txtCompanyType, txtBusinessVal, txtCompanyName, txtIPinNum])
        
        
        let tapCountry = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        viewCountry.addGestureRecognizer(tapCountry)
        
        let tapState = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        viewState.addGestureRecognizer(tapState)
        
        let tapCity = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        viewCity.addGestureRecognizer(tapCity)
        

        
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        guard let tappedView = sender?.view else { return }
        switch tappedView.tag {
        case 1:
           // buttonPressed(tappedView.tag)
            buttonBottomSheet(tappedView.tag)

        case 2:
//            buttonPressed(tappedView.tag)
            buttonBottomSheet(tappedView.tag)

        case 3:
//            buttonPressed(tappedView.tag)
            buttonBottomSheet(tappedView.tag)

        default:
            break
        }
        
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Check which text field triggered the method
//           if textField == txtGST {
//               self.btnVerifyGst.isHidden = false
//               self.btnVerifyDonegGst.isHidden = true
//           } else if textField == txtPAN {
//               self.btnVerifyPan.isHidden = false
//               self.btnVerifyDonegPan.isHidden = true
//           }
//        else  if textField == txtEmail {
//            self.btnVerifyEmail.isHidden = false
//            self.btnVerifyDonegEmail.isHidden = true
//        }
        
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
        
//    case "Aadhar":
//        self.dealerDataStruct.aadhaarNo = text
//    case "PAN":
//        self.dealerDataStruct.panNo = text
//    case "FName":
//        self.dealerDataStruct.firstName = text
//    case "LName":
//        self.dealerDataStruct.lastName = text
//    case "Mobile":
//        self.dealerDataStruct.mobileNo = text
//    case "Email":
//        self.dealerDataStruct.email = text
//    case "Password":
//        self.dealerDataStruct.password = text
//    case "CNPassword":
//        self.dealerDataStruct.confirmPassword = text
        
        
        if let text = txtCompanyName.text {
         
            cellDataDelegate?.didUpdateText(textKey: "DealerComName", text: text, indexPath: indexPath)
            
        }
          if let text = txtMobile.text {
              cellDataDelegate?.didUpdateText(textKey: "DealerMobileN", text: text, indexPath: indexPath)
          }
        
        if let text = txtEmail.text {
         
            cellDataDelegate?.didUpdateText(textKey: "DealerEmail", text: text, indexPath: indexPath)
            
        }
          if let text = txtCity.text {
              cellDataDelegate?.didUpdateText(textKey: "DealerCity", text: text, indexPath: indexPath)
          }
        
        if let text = txtState.text {
         
            cellDataDelegate?.didUpdateText(textKey: "DealerState", text: text, indexPath: indexPath)
            
        }
          if let text = txtCountry.text {
              cellDataDelegate?.didUpdateText(textKey: "DealerContry", text: text, indexPath: indexPath)
          }
        if let text = txtIPinNum.text {
            cellDataDelegate?.didUpdateText(textKey: "DealerPin", text: text, indexPath: indexPath)
        }
        
        if let text = txtAddress1.text {
            cellDataDelegate?.didUpdateText(textKey: "DealerAddress1", text: text, indexPath: indexPath)
        }
        if let text = txtAddress2.text {
            cellDataDelegate?.didUpdateText(textKey: "DealerAddress2", text: text, indexPath: indexPath)
        }
        if let text = txtCompanyType.text {
            cellDataDelegate?.didUpdateText(textKey: "DealerComType", text: text, indexPath: indexPath)
        }
        if let text = txtBusinessVal.text {
            cellDataDelegate?.didUpdateText(textKey: "DealerBusinessNa", text: text, indexPath: indexPath)
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
    
    
    func dataCollectCompanyDetail() -> CompanyDetailsDataStruct{
        
        if self.validateData() {
//            companyDetailsStruct.gstNumber = self.txtGST.text ?? ""
//            companyDetailsStruct.panNumber = self.txtPAN.text ?? ""
            
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
//            companyDetailsStruct.trademembership = self.txtTradeNumber.text ?? ""
           // companyDetailsStruct.iecNumber = self.txtIEXNumber.text ?? ""
            
            
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
//        guard !txtPAN.text!.isEmptyStr else {
//            txtPAN.showError(message: ConstentString.panErr)
//            return false
//        }
        guard !txtCompanyName.text!.isEmptyStr else {
            txtCompanyName.showError(message: ConstentString.copnayNameError)
            txtCompanyName.borderColor = .red
                return false
            }
        guard !txtMobile.text!.isEmptyStr else {
            txtMobile.showError(message: ConstentString.mobileErr)
            txtMobile.borderColor = .red
            return false
        }
        guard !txtEmail.text!.isEmptyStr else {
            txtEmail.showError(message: ConstentString.emailErr)
            txtEmail.borderColor = .red
            return false
        }
            
            guard !txtCountry.text!.isEmptyStr else {
                txtCountry.showError(message: ConstentString.countryErr)
                txtCountry.borderColor = .red
                return false
            }
        
        guard !txtState.text!.isEmptyStr else {
            txtState.showError(message: ConstentString.stateErr)
            txtState.borderColor = .red
            return false
        }
        
        guard !txtCity.text!.isEmptyStr else {
            
            txtCity.showError(message: ConstentString.cityErr)
            txtCity.borderColor = .red
            return false
        }
        
        guard !txtIPinNum.text!.isEmptyStr else {
            
            txtIPinNum.showError(message: ConstentString.cityPin)
            txtIPinNum.borderColor = .red
            return false
        }
        
        guard !txtAddress1.text!.isEmptyStr else {
            
            txtAddress1.showError(message: ConstentString.address)
            txtAddress1.borderColor = .red
            return false
        }
        
//        guard !txtCompanyType.text!.isEmptyStr else {
//            txtCompanyType.showError(message: ConstentString.copnayTypeError)
//            txtCompanyType.borderColor = .red
//            return false
//        }
        
      
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
