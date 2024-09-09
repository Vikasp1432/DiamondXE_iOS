//
//  OrderSummeryItemsCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/09/24.
//

import UIKit

class OrderSummeryItemsCVC: UICollectionViewCell {
    
    static let cellIdentifierOrderSummeryItemsCVC = String(describing: OrderSummeryItemsCVC.self)
    
    @IBOutlet var bgDataView:UIView!
    
    @IBOutlet var btnRefendable :UIButton!
   // @IBOutlet var btnAvailable :UIButton!
    @IBOutlet var refundViewToast :UIView!
    
    @IBOutlet var imgDiamond :UIImageView!
    @IBOutlet var lblCirtificateNum :UILabel!
    @IBOutlet var lblLotID :UILabel!
    @IBOutlet var lblShape :UILabel!
    @IBOutlet var lblClor :UILabel!
    @IBOutlet var lblCarat :UILabel!
    @IBOutlet var lblClarity :UILabel!
    @IBOutlet var lblPrice :UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgDataView.layer.shadowColor = UIColor.shadowViewclr.cgColor
        bgDataView.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        bgDataView.layer.shadowRadius = 1.5
        bgDataView.layer.shadowOpacity = 0.3
        bgDataView.layer.masksToBounds = false
        refundViewToast.isHidden = true
    }
    
    @IBAction func btnActionRetunable(_ sender : UIButton){
        
               // Perform animation
               UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
                   self.refundViewToast.isHidden = false
                   self.refundViewToast.alpha = 0.0 // Fade out
               }) { _ in
                   self.refundViewToast.isHidden = true // Hide after animation completes
                   self.refundViewToast.alpha = 1.0 // Reset alpha for next use
               }
    }

}
