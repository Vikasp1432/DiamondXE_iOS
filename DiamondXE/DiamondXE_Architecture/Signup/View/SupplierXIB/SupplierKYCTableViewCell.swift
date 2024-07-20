//
//  SupplierKYCTableViewCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 15/07/24.
//

import UIKit
import DTTextField

class SupplierKYCTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let cellIdentifierSuppComKYC = String(describing: SupplierKYCTableViewCell.self)
    
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet var btnDropDown:UIButton!
    
    @IBOutlet var btnVerify: UIButton!
    @IBOutlet var btnVeriyed: UIButton!
    
    @IBOutlet var btnVerifyPAN: UIButton!
    @IBOutlet var btnVeriyedPAN: UIButton!
    
    @IBOutlet var btnGSTDoc: UIButton!
    @IBOutlet var btnPANDoc: UIButton!
    @IBOutlet var btnIECDoc: UIButton!
    
    
    @IBOutlet var btnSelectedGST: UIButton!
    @IBOutlet var btnSelectedPAN: UIButton!
    @IBOutlet var btnSelectedIEC: UIButton!
    
    
    @IBOutlet var txtNatureOfBusiness:DTTextField!
    @IBOutlet var txtCompanyType:DTTextField!
    
    @IBOutlet var txtGSTNum:DTTextField!
    @IBOutlet var txtComPAN:DTTextField!
 
    @IBOutlet var txtBusinessLicenNum:DTTextField!
    @IBOutlet var txtCompanyIEC:DTTextField!
    
    var buttonDropDownCB : ((Int) -> Void) = {_ in }
    var cellDataDelegate : CellDataDelegate?
    
    @IBOutlet var viewBG:UIView!
    var indexPath = IndexPath()

    var buttonVerify  : ((Int) -> Void) = {_ in }
    var buttonDocBase64  : ((Int) -> Void) = {_ in }
    var buttonPressed : ((Int) -> Void) = {_ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        
        txtNatureOfBusiness.delegate = self
        txtCompanyType.delegate = self
        txtGSTNum.delegate = self
        txtComPAN.delegate = self
        txtCompanyIEC.delegate = self
        
        // Initialization code
//        self.btnFlag.setTitle(APIs().indianFlag, for: .normal)
        BaseViewController.setClrUItextField2(textFields: [txtNatureOfBusiness, txtCompanyType])
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
        
        
        
        if let text = txtGSTNum.text {
         
            cellDataDelegate?.didUpdateText(textKey: "CO.GST", text: text, indexPath: indexPath)
            
        }
          if let text = txtComPAN.text {
              cellDataDelegate?.didUpdateText(textKey: "CO.PAN", text: text, indexPath: indexPath)
          }
          
          if let text = txtCompanyIEC.text {
              cellDataDelegate?.didUpdateText(textKey: "CO.IECN", text: text, indexPath: indexPath)
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
//        self.isExpanded.toggle()
        buttonPressed(sender.tag)
    }
    
    
    @IBAction func buttonActionDropDown(_ sender: UIButton) {
       
        buttonDropDownCB(sender.tag)
    }
    
    @IBAction func buttonActionVerify(_ sender: UIButton) {
       
        buttonVerify(sender.tag)
    }
    
    @IBAction func buttonActionDocBase64(_ sender: UIButton) {
       
        buttonDocBase64(sender.tag)
    }
    
}
