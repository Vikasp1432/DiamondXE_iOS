//
//  CouponInfoTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/09/24.
//

import UIKit
import DTTextField

class CouponInfoTVC: UITableViewCell, UITextFieldDelegate {
    static let cellIdentifierCouponInfoTVC = String(describing: CouponInfoTVC.self)
    
    @IBOutlet var viewData:UIView!
    
    @IBOutlet var btnPointVeryfy:UIButton!
    @IBOutlet var btnPointVeryfied:UIButton!
    
    @IBOutlet var txtCouponCode:DTTextField!
  
    var btnAction : (() -> Void) = { }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewData.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewData.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewData.layer.shadowRadius = 2.0
        viewData.layer.shadowOpacity = 0.5
        viewData.layer.masksToBounds = false
        
        txtCouponCode.delegate = self
        
        self.btnPointVeryfy.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
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
               self.btnPointVeryfy.isHidden = false
               self.btnPointVeryfied.isHidden = true
           }
       }
       
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
    }
    
    @IBAction func btnActionApply(_ sender:UIButton){
        btnAction()
       
    }
    
}
