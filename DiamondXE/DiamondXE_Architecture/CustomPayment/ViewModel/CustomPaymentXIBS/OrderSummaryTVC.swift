//
//  OrderSummaryTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/06/24.
//

import UIKit

class OrderSummaryTVC: UITableViewCell {
    
    static let cellIdentifierOrderSummary = String(describing: OrderSummaryTVC.self)

    @IBOutlet var viewBG:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBG.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
