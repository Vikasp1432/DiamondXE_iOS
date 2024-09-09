//
//  ShippingItemsListCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/07/24.
//

import UIKit

class ShippingItemsListCell: UITableViewCell {
    static let cellIdentifierShippingItemsList = String(describing: ShippingItemsListCell.self)
    
    @IBOutlet var bgDataView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgDataView.layer.shadowColor = UIColor.shadowViewclr.cgColor
        bgDataView.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        bgDataView.layer.shadowRadius = 1.5
        bgDataView.layer.shadowOpacity = 0.3
        bgDataView.layer.masksToBounds = false
//        bgDataView.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
