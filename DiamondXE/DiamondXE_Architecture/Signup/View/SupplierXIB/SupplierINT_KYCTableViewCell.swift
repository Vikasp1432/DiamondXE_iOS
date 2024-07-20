//
//  SupplierINT_KYCTableViewCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 15/07/24.
//

import UIKit
import DTTextField

class SupplierINT_KYCTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let cellIdentifierSuppINT_KYC = String(describing: SupplierINT_KYCTableViewCell.self)

    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet var btnDropDown:UIButton!
    
    @IBOutlet var btnBusinessLincDoc: UIButton!
    @IBOutlet var btnIECDoc: UIButton!
    
    @IBOutlet var txtCompanyType:DTTextField!
    @IBOutlet var txtNatureOfBusiness:DTTextField!
    @IBOutlet var txtBusinessLicenNum:DTTextField!
    @IBOutlet var txtCompanyIEC:DTTextField!
    
    @IBOutlet var btnSelectedBusinessLic: UIButton!
    @IBOutlet var btnSelectedIEC: UIButton!
    
    @IBOutlet var viewBG:UIView!
    
    var cellDataDelegate : CellDataDelegate?
    var indexPath = IndexPath()

    var buttonDropDownCB : ((Int) -> Void) = {_ in }
    var buttonGetDocBase64 : ((Int) -> Void) = {_ in }
    var buttonPressed : ((Int) -> Void) = {_ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        
        // Initialization code
//        self.btnFlag.setTitle(APIs().indianFlag, for: .normal)
        txtCompanyType.delegate = self
        txtBusinessLicenNum.delegate = self
        txtCompanyIEC.delegate = self
        BaseViewController.setClrUItextField2(textFields: [txtCompanyType, txtNatureOfBusiness,txtBusinessLicenNum,txtCompanyIEC])
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
        
        if let text = txtBusinessLicenNum.text {
         
            cellDataDelegate?.didUpdateText(textKey: "CO.BusinessLicence", text: text, indexPath: indexPath)
            
        }
          if let text = txtCompanyIEC.text {
              cellDataDelegate?.didUpdateText(textKey: "CO.IECN", text: text, indexPath: indexPath)
          }
          
//          if let text = txtCompanyIEC.text {
//              cellDataDelegate?.didUpdateText(textKey: "CO.IECN", text: text, indexPath: indexPath)
//          }
          
        
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
//        self.isExpanded.toggle()
       
        buttonDropDownCB(sender.tag)
    }
    
    @IBAction func buttonActionGetDoc(_ sender: UIButton) {
//        self.isExpanded.toggle()
       
        buttonGetDocBase64(sender.tag)
    }
    
}
