//
//  Supplier_BankInfoCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 30/04/24.
//

import UIKit

class Supplier_BankInfoCell: UITableViewCell {
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet  var btnDropDown:UIButton!
    
    @IBOutlet var txtBNKName:FloatingTextField!
    @IBOutlet var txtBNKBranchName:FloatingTextField!
    @IBOutlet var txtBNKACCNumber:FloatingTextField!
    @IBOutlet var txtBNKACCType:FloatingTextField!
    @IBOutlet var txtBNKIFSC:FloatingTextField!
    @IBOutlet var txtBNKSwiftCode:FloatingTextField!

    
    var buttonPressed : ((Int) -> Void) = {_ in }
    
    var cellDataDelegate : CellDataDelegate?
    var indexPath = IndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BaseViewController.setClrUItextField(textFields: [txtBNKName, txtBNKBranchName,txtBNKACCNumber, txtBNKACCType, txtBNKIFSC, txtBNKSwiftCode])
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      if let text = txtBNKName.text {
       
          cellDataDelegate?.didUpdateText(textKey: "BNKName", text: text, indexPath: indexPath)
          
      }
        if let text = txtBNKBranchName.text {
            cellDataDelegate?.didUpdateText(textKey: "BNKBranchName", text: text, indexPath: indexPath)
        }
        
        if let text = txtBNKACCNumber.text {
            cellDataDelegate?.didUpdateText(textKey: "BNKACCNumber", text: text, indexPath: indexPath)
        }
        if let text = txtBNKACCType.text {
            cellDataDelegate?.didUpdateText(textKey: "BNKACCType", text: text, indexPath: indexPath)
        }
        
        if let text = txtBNKIFSC.text {
            cellDataDelegate?.didUpdateText(textKey: "BNKIFSC", text: text, indexPath: indexPath)
        }
        if let text = txtBNKSwiftCode.text {
            cellDataDelegate?.didUpdateText(textKey: "BNKSwiftCode", text: text, indexPath: indexPath)
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
}
