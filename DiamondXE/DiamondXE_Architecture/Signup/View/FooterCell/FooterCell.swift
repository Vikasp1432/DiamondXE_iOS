//
//  FooterCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/04/24.
//

import UIKit
import DTTextField

class FooterCell: UITableViewCell, UITextFieldDelegate {

    var buttonPressed : ((Int) -> Void) = {_ in }
    @IBOutlet var txtRefralCode:DTTextField!
    @IBOutlet var btnCreateAccount:UIButton!
    @IBOutlet var btnTNC:UIButton!
    @IBOutlet var viewBG: UIView!

    var termAndCondition = false


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        
        self.txtRefralCode.delegate = self
        self.txtRefralCode.floatPlaceholderActiveColor = .themeClr
        self.txtRefralCode.floatPlaceholderColor = .themeClr
        self.btnCreateAccount.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    
    @IBAction func buttonTNC(_ sender: UIButton) {
        self.termAndCondition.toggle()
        if termAndCondition {
            self.btnCreateAccount.isEnabled = true
            self.btnTNC.setImage(UIImage(named: "checked"), for: .normal)
            btnCreateAccount.backgroundColor = UIColor.themeClr
        }
        else{
            self.btnCreateAccount.isEnabled = false
            self.btnTNC.setImage(UIImage(named: "unchekBox"), for: .normal)
            btnCreateAccount.backgroundColor = UIColor.themeFadeClr
        }
    }
    
    func getRefralCode() -> String {
        return txtRefralCode.text ?? ""
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        buttonPressed(sender.tag)
    }
}
