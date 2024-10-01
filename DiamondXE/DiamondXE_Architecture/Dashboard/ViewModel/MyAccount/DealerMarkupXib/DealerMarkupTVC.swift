//
//  DealerMarkupTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 01/10/24.
//

import UIKit
import DTTextField

protocol MarkupDataDelegate {
    func didUpdateText(natural:String,labGrn: String?, indexPath: IndexPath)
}

class DealerMarkupTVC: UITableViewCell, UITextFieldDelegate {
    
    static let cellIdentifierDealerMarkupTVC = String(describing: DealerMarkupTVC.self)
    
    @IBOutlet var lblTile:UITextField!
    @IBOutlet var lblValNatural:DTTextField!
    @IBOutlet var lblValLabGrown:DTTextField!
    
    var delegate : MarkupDataDelegate?
    var indexPath = IndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblValNatural.delegate = self
        lblValLabGrown.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
        
        self.delegate?.didUpdateText(natural: self.lblValNatural.text ?? "", labGrn: self.lblValLabGrown.text ?? "", indexPath: self.indexPath)
        
        
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
    
}
