//
//  WalletHistoryTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 08/11/24.
//

import UIKit
import UIView_Shimmer

class WalletHistoryTVC: UITableViewCell, ShimmeringViewProtocol {
    
    static let cellIdentifierWalletHistoryTVC = String(describing: WalletHistoryTVC.self)
    
    @IBOutlet var viewBG:UIView!
    @IBOutlet var lblDateTime : UILabel!
    @IBOutlet var lblTransactionID : UILabel!
    @IBOutlet var lblStatus : UILabel!
   // @IBOutlet var lblAmount : UILabel!
    @IBOutlet var lblMode : UILabel!
    @IBOutlet var lblNarration : UILabel!
    
    
    @IBOutlet var lblTransactionIDHeading : UILabel!
    @IBOutlet var lblStatusHeading  : UILabel!
   // @IBOutlet var lblAmount : UILabel!
    @IBOutlet var lblModeHeading  : UILabel!
    @IBOutlet var lblNarrationHeading  : UILabel!
    
    @IBOutlet var viewBGDateTime:UIView!
    @IBOutlet var dataview:UIStackView!
    @IBOutlet var remarkView:UIView!
    
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.viewBG,
//            viewBGDateTime,
//            dataview,
//            remarkView,
            self.lblDateTime ,
            self.lblTransactionID ,
            self.lblStatus,
            self.lblMode,
            self.lblNarration,
            self.lblTransactionIDHeading ,
            self.lblStatusHeading,
            self.lblModeHeading,
            self.lblNarrationHeading,
           
        ]
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBG.applyShadow()
        viewBGDateTime.roundTopCorners(radius: 8)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
