//
//  OutherCountryKYC.swift
//  DiamondXE
//
//  Created by iOS Developer on 12/07/24.
//

import UIKit
import DTTextField

class OutherCountryKYC: UITableViewCell , UITextFieldDelegate{
    
    static let cellIdentifierInternationalCell = String(describing: OutherCountryKYC.self)

    @IBOutlet  var btnDropDown:UIButton!
    
    @IBOutlet  var btnBusinessLicenceNum:UIButton!
    @IBOutlet  var btnIECDoc:UIButton!

    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet var txtBusinessLicenceNum:DTTextField!
    @IBOutlet var txtIECDoc:DTTextField!
    
    @IBOutlet var viewBG:UIView!
    
   // @IBOutlet var viewBGConstraint:NSLayoutConstraint!

    var buttonPressed : ((Int) -> Void) = {_ in }
    var buttonPressedPicDoc : ((Int) -> Void) = {_ in }
    var buttonPressedVerify : ((Int) -> Void) = {_ in }
    
    
    
    var cellDataDelegate : CellDataDelegate?
    var indexPath = IndexPath()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // setupData(isExpand: true)
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        
        txtBusinessLicenceNum.delegate = self
        txtIECDoc.delegate = self
        BaseViewController.setClrUItextField2(textFields: [txtBusinessLicenceNum, txtIECDoc])
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let dtTextField = textField as? DTTextField {
            dtTextField.borderColor = UIColor.tabSelectClr
        }
        
           return true
       }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
        
      if let text = txtBusinessLicenceNum.text {
       
          cellDataDelegate?.didUpdateText(textKey: "Aadhar", text: text, indexPath: indexPath)
          
      }
        if let text = txtIECDoc.text {
            cellDataDelegate?.didUpdateText(textKey: "PAN", text: text, indexPath: indexPath)
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // Change border color or perform any other actions
           if let customTextField = textField as? DTTextField {
               customTextField.borderColor = UIColor.tabSelectClr
           }
       }
    
    
    
    func getBusinessLicencenum() -> String{
        return self.txtBusinessLicenceNum.text ?? ""
    }
    
    func getIECnum() -> String{
        return self.txtIECDoc.text ?? ""
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
    
    @IBAction func buttonActionPicImg(_ sender: UIButton) {
        buttonPressedPicDoc(sender.tag)
    }
    
   
}
