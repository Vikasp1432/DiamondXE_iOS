//
//  SameAddressCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 25/07/24.
//

import UIKit

class SameAddressCell: UITableViewCell {
    
    static let cellIdentifierSameAddRssCell = String(describing: SameAddressCell.self)
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblDec:UILabel!
    
    @IBOutlet var btnEdit:UIButton!
    @IBOutlet var btnRadioSelect:UIButton!
    
    @IBOutlet var dataView:UIView!
    
    var btnActionCell : ((Int) -> Void) = {_ in }
    
    var isSelectedCell: Bool = false {
            didSet {
                updateRadioButton()
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dataView.layer.shadowColor = UIColor.shadowViewclr.cgColor
        dataView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        dataView.layer.shadowRadius = 2.0
        dataView.layer.shadowOpacity = 0.3
        dataView.layer.masksToBounds = false
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
