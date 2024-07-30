//
//  ShippingAddressCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 25/07/24.
//

import UIKit

class ShippingAddressCell: UITableViewCell {
    
    static let cellIdentifierShippingAddRss = String(describing: ShippingAddressCell.self)
    
    @IBOutlet var viewNoData:UIView!
    @IBOutlet var viewData:UIView!
    
    @IBOutlet var lblName:UILabel!
    @IBOutlet var lblAddress:UILabel!
    @IBOutlet var lblPhone:UILabel!
    @IBOutlet var lblEmail:UILabel!
    @IBOutlet var lblAddressType:UILabel!
    
    @IBOutlet var btnEdit:UIButton!
    @IBOutlet var btnRadioSelect:UIButton!
    
    var btnActionCell : ((Int) -> Void) = {_ in }
    
    var isSelectedCell: Bool = false {
            didSet {
                updateRadioButton()
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewData.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewData.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewData.layer.shadowRadius = 2.0
        viewData.layer.shadowOpacity = 0.3
        viewData.layer.masksToBounds = false
        
        viewNoData.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewNoData.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewNoData.layer.shadowRadius = 2.0
        viewNoData.layer.shadowOpacity = 0.3
        viewNoData.layer.masksToBounds = false
        
    }
    
    private func updateRadioButton() {
           let imageName = isSelectedCell ? "radioButtonSelected" : "radioButtonDeselected"
           btnRadioSelect.setImage(UIImage(named: imageName), for: .normal)
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionS(_ sender : UIButton){
        btnActionCell(sender.tag)
    }
    
}
