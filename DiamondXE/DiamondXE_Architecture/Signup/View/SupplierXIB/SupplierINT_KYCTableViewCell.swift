//
//  SupplierINT_KYCTableViewCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 15/07/24.
//

import UIKit
import DTTextField

class SupplierINT_KYCTableViewCell: UITableViewCell {
    
    static let cellIdentifierSuppINT_KYC = String(describing: SupplierINT_KYCTableViewCell.self)

    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet var btnDropDown:UIButton!
    
    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var btnCode: UIButton!
    
    @IBOutlet var txtSupervisorName:DTTextField!
    @IBOutlet var txtNatureOfBusiness:DTTextField!
    @IBOutlet var txtCompanyType:DTTextField!
    
    @IBOutlet var viewBG:UIView!

    var buttonDropDownCB : ((Int) -> Void) = {_ in }
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
       // BaseViewController.setClrUItextField2(textFields: [txtSupervisorName, txtSupervisorEmail,txtSupervisorMobile])
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
    
}
