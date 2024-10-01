//
//  ItemsSummaryPriceTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/09/24.
//

import UIKit
import UIView_Shimmer

class ItemsSummaryPriceTVC: UITableViewCell, ShimmeringViewProtocol {
    
    static let cellIdentifierItemsSummaryPriceTVC = String(describing: ItemsSummaryPriceTVC.self)
    
    @IBOutlet var viewDataBG : UIView!
   
    @IBOutlet var lblDiaPrice : UILabel!
    @IBOutlet var lblSubTotal : UILabel!
    @IBOutlet var lblGrandTotal : UILabel!
    
    @IBOutlet var dataStackView : UIStackView!
    
    var shimmeringAnimatedItems: [UIView] {
        [
            dataStackView
        ]
    }
    
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
