//
//  BuyItemInfoTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 11/09/24.
//

import UIKit
import UIView_Shimmer

class BuyItemInfoTVC: UITableViewCell, ShimmeringViewProtocol {
    
    static let cellIdentifierBuyItemInfoTVC = String(describing: BuyItemInfoTVC.self)
    
    @IBOutlet var viewDataBG : UIView!
    @IBOutlet var viewCerNoTime : UIView!

    @IBOutlet var viewDetails : UIView!
    @IBOutlet var viewSummary : UIView!
    @IBOutlet var viewTrackOrder : UIView!
    @IBOutlet var viewCancelOrder : UIView!
    
    @IBOutlet var btnDetails : UIButton!
    @IBOutlet var btnSummary : UIButton!
    @IBOutlet var btnTrackOrder : UIButton!
    @IBOutlet var btnCancelOrder : UIButton!
    
    @IBOutlet var imgDiamond : UIImageView!
    @IBOutlet var lblOrderID : UILabel!
    @IBOutlet var lblDateTime : UILabel!
    @IBOutlet var lblCertificateNo : UILabel!
    @IBOutlet var lblPrice : UILabel!
    @IBOutlet var lblShape : UILabel!
    @IBOutlet var lblCarat : UILabel!
    @IBOutlet var lblColor : UILabel!
    @IBOutlet var lblClarity : UILabel!
    @IBOutlet var lblOrderStatus : UILabel!
    @IBOutlet var lblOrderCnclTime : UILabel!
    @IBOutlet var lblDiaType : UILabel!
    @IBOutlet var viewOrderStatus : UIView!
    @IBOutlet var viewDiaType : UIView!
    
    
    var btnActionsManage : ((Int) -> Void) = { _ in}
    
    @IBOutlet var lblCnclBy : UILabel!
    
    var shimmeringAnimatedItems: [UIView] {
           [
            self.btnDetails ,
            self.btnSummary ,
            self.btnTrackOrder ,
            self.btnCancelOrder,
            self.imgDiamond,
            self.lblOrderID ,
            self.lblDateTime ,
            self.lblCertificateNo ,
            self.lblPrice ,
            self.lblShape ,
            self.lblCarat ,
            self.lblColor ,
            self.lblClarity ,
            self.lblOrderStatus ,
            self.lblOrderCnclTime ,
            self.lblDiaType ,
            self.viewOrderStatus,
            self.viewDiaType
          
            
           ]
       }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDataBG.applyShadow()
        roundTopCorners(of: self.viewCerNoTime, radius: 10.0)
     
    }
    
    
    func roundTopCorners(of view: UIView, radius: CGFloat) {
       // view.layoutIfNeeded()
        let path = UIBezierPath(roundedRect: view.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnactionsInfo(_ sender : UIButton){
        self.btnActionsManage(sender.tag)
    }
    
}
