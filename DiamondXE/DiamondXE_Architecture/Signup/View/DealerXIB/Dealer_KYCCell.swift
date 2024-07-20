//
//  Dealer_KYCCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/04/24.
//

import UIKit
import DTTextField

class Dealer_KYCCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet  var btnDropDown:UIButton!
    
    @IBOutlet  var btnGSTFront:UIButton!
    @IBOutlet  var btnIECDoc:UIButton!
    @IBOutlet  var btnPANFront:UIButton!
    
    @IBOutlet  var btnSelectGST:UIButton!
    @IBOutlet  var btnSelectPAN:UIButton!
    @IBOutlet  var btnSelectIEC:UIButton!
    
    @IBOutlet  var btnverifyGST:UIButton!
    @IBOutlet  var btnverifiedAdhar:UIButton!
    
    @IBOutlet  var btnverifyPAN:UIButton!
    @IBOutlet  var btnverifiedPAN:UIButton!
    
    @IBOutlet var viewBG1:UIView!
    @IBOutlet var viewBG2:UIView!
    @IBOutlet var viewBG3:UIView!
    @IBOutlet var viewBG4:UIView!
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet var txtAdhar:DTTextField!
    @IBOutlet var txtPAN:DTTextField!
    
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
        
        txtAdhar.delegate = self
        txtPAN.delegate = self
        BaseViewController.setClrUItextField2(textFields: [txtAdhar, txtPAN])
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Check which text field triggered the method
           if textField == txtAdhar {
               self.btnverifyGST.isHidden = false
               self.btnverifiedAdhar.isHidden = true
           } else if textField == txtPAN {
               self.btnverifyPAN.isHidden = false
               self.btnverifiedPAN.isHidden = true
           }
        if let dtTextField = textField as? DTTextField {
            dtTextField.borderColor = UIColor.tabSelectClr
        }
        
           return true
       }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
        
      if let text = txtAdhar.text {
       
          cellDataDelegate?.didUpdateText(textKey: "Aadhar", text: text, indexPath: indexPath)
          
      }
        if let text = txtPAN.text {
            cellDataDelegate?.didUpdateText(textKey: "PAN", text: text, indexPath: indexPath)
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // Change border color or perform any other actions
           if let customTextField = textField as? DTTextField {
               customTextField.borderColor = UIColor.tabSelectClr
           }
       }
    
    
    
    func getAdharnum() -> String{
        return self.txtAdhar.text ?? ""
    }
    
    func getPANnum() -> String{
        return self.txtPAN.text ?? ""
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
    
    @IBAction func buttonActionVerify(_ sender: UIButton) {
        buttonPressedVerify(sender.tag)
    }
    
}
