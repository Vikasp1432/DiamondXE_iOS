//
//  ItemsSummaryAllInfoTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/09/24.
//

import UIKit
import UIView_Shimmer

class ItemsSummaryAllInfoTVC: UITableViewCell , ShimmeringViewProtocol{

    static let cellIdentifierItemsSummaryAllInfoTVC = String(describing: ItemsSummaryAllInfoTVC.self)
    
    
    @IBOutlet var viewDataBG : UIView!
    
    @IBOutlet var lblDiamondPrice : UILabel!
    @IBOutlet var lblCouponDiscount : UILabel!
    @IBOutlet var lblShippingHandling : UILabel!
    @IBOutlet var lblPlatformFee : UILabel!
    @IBOutlet var lblTotalCharges : UILabel!
    @IBOutlet var lblOtherTaxes : UILabel!
    @IBOutlet var lblDiamondsTAX: UILabel!
    @IBOutlet var lblTotalTaxes : UILabel!
    @IBOutlet var lblSubTotal : UILabel!
    @IBOutlet var lblWalletPoints : UILabel!
    @IBOutlet var lblBNKCharges : UILabel!
    @IBOutlet var lblFinalAmount : UILabel!
    
    
    @IBOutlet var stackViewDiaPrice : UIStackView!
    @IBOutlet var stackViewCouponDis : UIStackView!
    @IBOutlet var stackViewShippingHandling : UIStackView!
    @IBOutlet var stackViewPlatFormFee : UIStackView!
    @IBOutlet var stackViewTotalCharges : UIView!
    @IBOutlet var stackViewOtherChrges: UIStackView!
    @IBOutlet var stackViewDiamTax: UIStackView!
    @IBOutlet var stackViewTotalTaxes: UIStackView!
    @IBOutlet var stackViewSubtotal: UIStackView!
    @IBOutlet var stackViewWalletPont: UIStackView!
    @IBOutlet var stackViewBankChrg: UIStackView!
    @IBOutlet var stackViewFinallAmt : UIView!
    
    var shimmeringAnimatedItems: [UIView] {
           [
//            self.lblDiamondPrice ,
//            self.lblCouponDiscount ,
//            self.lblShippingHandling ,
//            self.lblPlatformFee ,
//            self.lblTotalCharges ,
//            self.lblOtherTaxes ,
//            self.lblDiamondsTAX,
//            self.lblTotalTaxes ,
//            self.lblSubTotal ,
//            self.lblWalletPoints ,
//            self.lblBNKCharges ,
//            self.lblFinalAmount
            
            self.stackViewDiaPrice ,
            self.stackViewCouponDis ,
            self.stackViewShippingHandling ,
            self.stackViewPlatFormFee ,
            self.stackViewTotalCharges ,
            self.stackViewOtherChrges,
            self.stackViewTotalTaxes,
            self.stackViewSubtotal,
            self.stackViewWalletPont,
            self.stackViewBankChrg,
            self.stackViewFinallAmt,
            self.stackViewDiamTax
            
            
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
