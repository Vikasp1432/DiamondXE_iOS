//
//  CouponListTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/10/24.
//

import UIKit

class CouponListTVC: UITableViewCell {
    
    static let cellIdentifierCouponListTVC = String(describing: CouponListTVC.self)
    
    @IBOutlet var lblCpnCode : UILabel!
    @IBOutlet var lblType : UILabel!
    @IBOutlet var lblDes : UILabel!
    @IBOutlet var lblValid : UILabel!
    @IBOutlet var btnApply : UIButton!
    @IBOutlet var lblType2 : UILabel!
    
    
    @IBOutlet var viewType : UIView!
    @IBOutlet var viewType2 : UIView!
    @IBOutlet var viewBG : UIView!
    
    var btnActionApply : (() -> Void) = { }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBG.applyShadow()
        self.btnApply.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionApply(_ sender : UIButton){
        self.btnActionApply()
    }
    
}
