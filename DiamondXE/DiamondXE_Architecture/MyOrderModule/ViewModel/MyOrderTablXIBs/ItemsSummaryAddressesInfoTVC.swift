//
//  ItemsSummaryAddressesInfoTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/09/24.
//

import UIKit
import UIView_Shimmer

class ItemsSummaryAddressesInfoTVC: UITableViewCell, ShimmeringViewProtocol {

    
    static let cellIdentifierItemsSummaryAddressesInfoTVC = String(describing: ItemsSummaryAddressesInfoTVC.self)
    
    
    
    @IBOutlet var lblUTRCheckNo : UILabel!
    @IBOutlet var lblOrderStatus : UILabel!
    @IBOutlet var lblAmount : UILabel!
    @IBOutlet var lblOrderPlaced : UILabel!
    @IBOutlet var lblDeliveryDate : UILabel!
    @IBOutlet var lblPaymentMode : UILabel!
    @IBOutlet var lblShippingAddress : UILabel!
    @IBOutlet var lblBillingAddress : UILabel!
    @IBOutlet var lblContactNo : UILabel!
    @IBOutlet var lblEmail : UILabel!
    
    var shimmeringAnimatedItems: [UIView] {
           [
            self.lblUTRCheckNo,
            self.lblOrderStatus,
            self.lblAmount,
            self.lblOrderPlaced,
            self.lblDeliveryDate,
            self.lblPaymentMode,
            self.lblShippingAddress,
            self.lblBillingAddress,
            self.lblContactNo,
            self.lblEmail
            
           ]
       }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
