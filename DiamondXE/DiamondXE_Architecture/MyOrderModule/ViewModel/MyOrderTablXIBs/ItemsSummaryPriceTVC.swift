//
//  ItemsSummaryPriceTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/09/24.
//

import UIKit

class ItemsSummaryPriceTVC: UITableViewCell {
    
    static let cellIdentifierItemsSummaryPriceTVC = String(describing: ItemsSummaryPriceTVC.self)
    
    @IBOutlet var viewDataBG : UIView!
   
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDataBG.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
