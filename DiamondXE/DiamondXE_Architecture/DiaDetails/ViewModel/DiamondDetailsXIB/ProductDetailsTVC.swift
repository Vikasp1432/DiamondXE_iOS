//
//  ProductDetailsTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 20/06/24.
//

import UIKit

class ProductDetailsTVC: UITableViewCell {
    
    static let cellIdentifierProductDetailsTVC = String(describing: ProductDetailsTVC.self)
    
   
    @IBOutlet var viewBG: UIView!
    @IBOutlet var btnBuyNow: UIButton!
    @IBOutlet var btnReserveDia: UIButton!
    @IBOutlet var viewLocationBG: UIView!
    
    @IBOutlet var lblDocNumber: UILabel!
    @IBOutlet var lblLotID: UILabel!
    @IBOutlet var lblShape: UILabel!
    @IBOutlet var lblCarat: UILabel!
    @IBOutlet var lblClr: UILabel!
    @IBOutlet var lblClarity: UILabel!
    @IBOutlet var lblPrice :UILabel!
    @IBOutlet var lblCut :UILabel!
    @IBOutlet var lblPolish :UILabel!
    @IBOutlet var lblSymmetry :UILabel!
    @IBOutlet var lblFlouro :UILabel!
    @IBOutlet var lblCertificate :UILabel!
    @IBOutlet var lblDiscount :UILabel!
    @IBOutlet var lblPincode :UILabel!
    
    @IBOutlet var viewCut :UIView!
    @IBOutlet var viewPolish :UIView!
    @IBOutlet var viewSymmetry :UIView!
    @IBOutlet var viewFlouro :UIView!
    @IBOutlet var viewCertificate :UIView!
    @IBOutlet var viewDiscount :UIView!
    
    
    var alertAction : (() -> Void) = {  }
    var alertBuyResrv : ((Int) -> Void) = { _ in  }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBG.applyShadow()
        viewLocationBG.applyShadow()
        btnBuyNow.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        btnReserveDia.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
      
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        viewLocationBG.addGestureRecognizer(tapGesture)

    }
    
    @objc func cellTapped() {
        alertAction()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionBuyAndReserve(_ sender : UIButton){
        alertBuyResrv(sender.tag)
    }
    
    @IBAction func btnActionChange(_ sender : UIButton){
        alertAction()
    }
    
}


extension UIView {
    func applyShadow(color: UIColor = UIColor.shadowViewclr, offset: CGSize = CGSize(width: 0.0, height: 2.0), radius: CGFloat = 2.0, opacity: Float = 0.5) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
}
