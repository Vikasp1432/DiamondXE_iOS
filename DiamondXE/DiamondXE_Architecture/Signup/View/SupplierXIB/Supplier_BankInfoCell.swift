//
//  Supplier_BankInfoCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 30/04/24.
//

import UIKit
import DTTextField

class Supplier_BankInfoCell: UITableViewCell {
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet  var btnDropDown:UIButton!
    
    @IBOutlet var txtBNKName:DTTextField!
    @IBOutlet var txtBNKBranchName:DTTextField!
    @IBOutlet var txtBNKACCNumber:DTTextField!
    @IBOutlet var txtBNKACCType:DTTextField!
    @IBOutlet var txtBNKIFSC:DTTextField!
    @IBOutlet var txtBNKSwiftCode:DTTextField!

    
    var buttonPressed : ((Int) -> Void) = {_ in }
    
    var cellDataDelegate : CellDataDelegate?
    var indexPath = IndexPath()
    
    @IBOutlet var viewBG:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        // Initialization code
        BaseViewController.setClrUItextField2(textFields: [txtBNKName, txtBNKBranchName,txtBNKACCNumber, txtBNKACCType, txtBNKIFSC, txtBNKSwiftCode])
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
