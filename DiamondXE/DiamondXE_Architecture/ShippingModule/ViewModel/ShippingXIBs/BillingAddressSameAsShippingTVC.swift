//
//  BillingAddressSameAsShippingTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/08/24.
//

import UIKit

class BillingAddressSameAsShippingTVC: UITableViewCell {
    
    static let cellIdentifierBillingAddressSameAsShippingTVC = String(describing: BillingAddressSameAsShippingTVC.self)
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblDesc:UILabel!
    @IBOutlet var viewData:UIView!
    
    @IBOutlet var btnCheckSelect:UIButton!
    
    var isSelectedCell: Bool = false {
            didSet {
                updateRadioButton()
            }
        }
    var btnActionCell : ((Int) -> Void) = {_ in }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewData.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewData.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewData.layer.shadowRadius = 2.0
        viewData.layer.shadowOpacity = 0.5
        viewData.layer.masksToBounds = false
    }

   

    private func updateRadioButton() {
           let imageName = isSelectedCell ? "checked" : "uncheck"
        btnCheckSelect.setImage(UIImage(named: imageName), for: .normal)
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionS(_ sender : UIButton){
        btnActionCell(sender.tag)
    }
    
}
