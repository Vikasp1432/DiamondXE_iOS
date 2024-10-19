//
//  CartItemTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/06/24.
//

import UIKit

class CartItemTVC: UITableViewCell {
    
    static let cellIdentifierCartItem = String(describing: CartItemTVC.self)

    @IBOutlet var viewBG:UIView!
    
    
    @IBOutlet var imgDiamond :UIImageView!
    @IBOutlet var lblCirtificateNum :UILabel!
    @IBOutlet var lblLotID :UILabel!
    @IBOutlet var lblShape :UILabel!
    @IBOutlet var lblClor :UILabel!
    @IBOutlet var lblCarat :UILabel!
    @IBOutlet var lblClarity :UILabel!
    @IBOutlet var lblPrice :UILabel!
    @IBOutlet var btnRefundable :UIButton!
    @IBOutlet var btnAvailable :UIButton!
    @IBOutlet var refundViewToast :UIView!
    @IBOutlet var btnSelectedItem :UIButton!

    @IBOutlet var btnWishList :UIButton!
    @IBOutlet var btnDelete :UIButton!
    
    @IBOutlet var lblDiscount :UILabel!
    
    @IBOutlet var tagViewBG :UIView!
    @IBOutlet var lblTAG :UILabel!
    
    var alertAction : (() -> Void) = {  }
    var isSelectedItem = true
    var isTap = true
    
    var actionWishNRemove : ((Int) -> Void) = { _ in  }
    
    var diamondSelect : (() -> Void) = { }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBG.applyShadow()
        
        btnWishList.layer.shadowColor = UIColor.shadowViewclr.cgColor
        btnWishList.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnWishList.layer.shadowRadius = 2.0
        btnWishList.layer.shadowOpacity = 0.3
        btnWishList.layer.masksToBounds = false
        
        btnDelete.layer.shadowColor = UIColor.shadowViewclr.cgColor
        btnDelete.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnDelete.layer.shadowRadius = 2.0
        btnDelete.layer.shadowOpacity = 0.3
        btnDelete.layer.masksToBounds = false
        
        refundViewToast.isHidden = true
        
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
            contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        diamondSelect()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionWishCart(_ sender : UIButton){
        actionWishNRemove(sender.tag)
      
    }
    
    @IBAction func actionSelect(_ sender: UIButton){
        alertAction()
       
    }
    
    func setupSelectedItem(items:[CardDataDetail]){
        if items.count > 1{
            isSelectedItem.toggle()
            isTap.toggle()
            if isSelectedItem{
                self.btnSelectedItem.setImage(UIImage(named: "check"), for: .normal)
            }
            else{
                
                self.btnSelectedItem.setImage(UIImage(named: "uncheck"), for: .normal)
                
            }
        }
    }
    
    
    
    @IBAction func btnActionRetunable(_ sender : UIButton){
        
        guard refundViewToast.isHidden else {
                return // If the view is visible, do nothing
            }

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
