//
//  SimillarProductCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/06/24.
//

import UIKit
import UIView_Shimmer


class SimillarProductCVC: UICollectionViewCell {
    static let cellIdentifiersameProduct = String(describing: SimillarProductCVC.self)
    
    @IBOutlet var bgView :UIView!
    @IBOutlet var btnWhshlist :UIButton!
    @IBOutlet var btnCard :UIButton!
    @IBOutlet var viewCart :UIView!
    @IBOutlet var btnRefendable :UIButton!
    @IBOutlet var btnAvailable :UIButton!
    @IBOutlet var refundViewToast :UIView!
    
    @IBOutlet var imgDiamond :UIImageView!
    @IBOutlet var lblCirtificateNum :UILabel!
    @IBOutlet var lblLotID :UILabel!
    @IBOutlet var btnShape :UILabel!
    @IBOutlet var lblClor :UILabel!
    @IBOutlet var lblCarat :UILabel!
    @IBOutlet var lblClarity :UILabel!
    @IBOutlet var lblPrice :UILabel!
    @IBOutlet var lblCut :UILabel!
    @IBOutlet var lblPolish :UILabel!
    @IBOutlet var lblSymmetry :UILabel!
    @IBOutlet var lblFlouro :UILabel!
    @IBOutlet var lblCertificate :UILabel!
    @IBOutlet var lblDiscount :UILabel!
    @IBOutlet var lblTablePer :UILabel!
    @IBOutlet var lblDepPer :UILabel!
    @IBOutlet var lblMasurments :UILabel!
    
    @IBOutlet var viewCut :UIView!
    @IBOutlet var viewPolish :UIView!
    @IBOutlet var viewSymmetry :UIView!
    @IBOutlet var viewFlouro :UIView!
    @IBOutlet var viewCertificate :UIView!
    @IBOutlet var viewDiscount :UIView!

    var actionReturnable : (() -> Void) = { }
    
    var diamondSelect : (() -> Void) = { }
    
    var addToCart : (() -> Void) = { }
    var addToWish : (() -> Void) = { }
    
    
    var shimmeringAnimatedItems: [UIView] {
           [
            imgDiamond,
            lblCirtificateNum,
            lblLotID,
            btnShape,
            lblClor,
            lblCarat,
            lblClarity,
            lblPrice,
            lblCut ,
            lblPolish,
            lblSymmetry,
            lblFlouro ,
            lblCertificate,
            lblDiscount ,
            lblTablePer ,
            lblDepPer ,
            lblMasurments
           ]
       }


    
    override func awakeFromNib() {
        super.awakeFromNib()
  
        bgView.layer.shadowColor = UIColor.darkGray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 3.6)
        bgView.layer.shadowRadius = 2.0
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.masksToBounds = false
        
        // apply shadow uibtn
        btnWhshlist.layer.shadowColor = UIColor.shadowViewclr.cgColor
        btnWhshlist.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnWhshlist.layer.shadowRadius = 2.0
        btnWhshlist.layer.shadowOpacity = 0.3
        btnWhshlist.layer.masksToBounds = false
        
        viewCart.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewCart.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewCart.layer.shadowRadius = 2.0
        viewCart.layer.shadowOpacity = 0.3
        viewCart.layer.masksToBounds = false
        
        refundViewToast.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
            contentView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func cellTapped() {
        diamondSelect()
    }
    
    
    @IBAction func btnActionWishCart(_ sender : UIButton){
        if sender.tag == 0{
            addToCart()
        }
        else{
            addToWish()
        }
    }


//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
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
