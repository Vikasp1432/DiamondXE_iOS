//
//  B2BSearchResultCardListingTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/06/24.
//

import UIKit
import UIView_Shimmer

class B2BSearchResultCardListingTVC: UITableViewCell, ShimmeringViewProtocol {
    static let cellIdentifierCardListingB2B = String(describing: B2BSearchResultCardListingTVC.self)
    
    @IBOutlet var bgView :UIView!
    @IBOutlet var btnWhshlist :UIButton!
    @IBOutlet var btnCard :UIButton!
    @IBOutlet var viewCart :UIView!
    @IBOutlet var btnRefendable :UIButton!
    @IBOutlet var btnAvailable :UIButton!
    @IBOutlet var refundViewToast :UIView!
    @IBOutlet var nameViewToast :UIView!
    @IBOutlet var lblFullNameView :UILabel!
    @IBOutlet var lblDiscountPrice :UILabel!
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
    
    @IBOutlet var stacViewkBTN :UIStackView!
    
    @IBOutlet var viewCut :UIView!
    @IBOutlet var viewPolish :UIView!
    @IBOutlet var viewSymmetry :UIView!
    @IBOutlet var viewFlouro :UIView!
    @IBOutlet var viewCertificate :UIView!
    @IBOutlet var viewDiscount :UIView!
    
    @IBOutlet var tagViewBG :UIView!
    @IBOutlet var lblTAG :UILabel!

    var actionReturnable : (() -> Void) = { }
    
    var diamondSelect : (() -> Void) = { }
    
    var addToCart : (() -> Void) = { }
    var addToWish : (() -> Void) = { }
    var shapeClick : (() -> Void) = { }
    

    
    var shimmeringAnimatedItems: [UIView] {
           [
            tagViewBG,
            lblTAG,
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
            viewCart,
            lblMasurments,
            btnWhshlist,
            stacViewkBTN,
            btnCard,
            lblDiscountPrice
           ]
       }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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
        nameViewToast.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
            contentView.addGestureRecognizer(tapGesture)
        
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(B2BSearchResultCardListingTVC.tapFunction))
        btnShape.isUserInteractionEnabled = true
        btnShape.addGestureRecognizer(tap)
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        shapeClick()
    }
    
    func shapeFullNameshow(name:String){
        self.lblFullNameView.sizeToFit()
//        self.lblFullNameView.text = name
        NSLayoutConstraint.activate([
            lblFullNameView.topAnchor.constraint(equalTo: nameViewToast.safeAreaLayoutGuide.topAnchor, constant: 2),
            lblFullNameView.leadingAnchor.constraint(equalTo: nameViewToast.leadingAnchor, constant: 6),
            lblFullNameView.trailingAnchor.constraint(lessThanOrEqualTo: nameViewToast.trailingAnchor, constant: 6)
               ])
        UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
//            print(name)
            self.lblFullNameView.text = name
            self.nameViewToast.isHidden = false
            self.nameViewToast.alpha = 0.0 // Fade out
        }) { _ in
            self.nameViewToast.isHidden = true // Hide after animation completes
            self.nameViewToast.alpha = 1.0 // Reset alpha for next use
        }
       
    }
    
    @objc func cellTapped() {
        diamondSelect()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionWishCart(_ sender : UIButton){
        if sender.tag == 0{
            addToCart()
        }
        else{
            addToWish()
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
