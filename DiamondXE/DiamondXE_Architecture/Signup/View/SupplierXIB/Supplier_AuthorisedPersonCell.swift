//
//  Supplier_AuthorisedPersonCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 30/04/24.
//

import UIKit
import DTTextField

class Supplier_AuthorisedPersonCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet var btnDropDown:UIButton!
    
    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var btnCode: UIButton!
    
    @IBOutlet var txtSupervisorName:DTTextField!
    @IBOutlet var txtSupervisorEmail:DTTextField!
    @IBOutlet var txtSupervisorMobile:DTTextField!
    
    @IBOutlet var viewBG:UIView!
    
    var cellDataDelegate : CellDataDelegate?
    var indexPath = IndexPath()
    var buttonBottomSheet : ((Int) -> Void) = {_ in }
    var buttonPressed : ((Int) -> Void) = {_ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        txtSupervisorMobile.paddingX = 110
        
         txtSupervisorName.delegate = self
         txtSupervisorEmail.delegate = self
         txtSupervisorMobile.delegate = self

//        self.btnFlag.setTitle(APIs().indianFlag, for: .normal)
        BaseViewController.setClrUItextField2(textFields: [txtSupervisorName, txtSupervisorEmail,txtSupervisorMobile])
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
        
        if let text = txtSupervisorName.text {
         
            cellDataDelegate?.didUpdateText(textKey: "CO.SupervisorName", text: text, indexPath: indexPath)
            
        }
          if let text = txtSupervisorEmail.text {
              cellDataDelegate?.didUpdateText(textKey: "CO.SupervisorEmail", text: text, indexPath: indexPath)
          }
          
          if let text = txtSupervisorMobile.text {
              cellDataDelegate?.didUpdateText(textKey: "CO.SupervisorMobile", text: text, indexPath: indexPath)
          }
        
        
    }
    
    
    
    func validateData() -> Bool {
        
        guard !txtSupervisorName.text!.isEmptyStr else {
            txtSupervisorName.showError(message: "Enter Name")
            return false
        }
        guard !txtSupervisorEmail.text!.isEmptyStr else {
            txtSupervisorEmail.showError(message: ConstentString.emailErr)
            return false
        }
        guard !txtSupervisorMobile.text!.isEmptyStr else {
            txtSupervisorMobile.showError(message: ConstentString.passErr)
            return false
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
    
    @IBAction func buttonAction(_ sender: UIButton) {
//        self.isExpanded.toggle()
       
        buttonPressed(sender.tag)
    }
    
    @IBAction func buttonActionBottomsheetList(_ sender: UIButton) {

        buttonBottomSheet(sender.tag)
    }
}
