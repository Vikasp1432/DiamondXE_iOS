//
//  RefundAddressPayModeTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/10/24.
//

import UIKit

class RefundAddressPayModeTVC: UITableViewCell {

    static let cellIdentifierRefundAddressPayModeTVC = String(describing: RefundAddressPayModeTVC.self)
    
    @IBOutlet var viewDataBG : UIView!
    
    @IBOutlet var lblHeading : UILabel!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var lblAddress : UILabel!
    @IBOutlet var lblEmail : UILabel!
    @IBOutlet var viewHeading : UIView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDataBG.applyShadow()
        roundTopCorners(of: self.viewHeading, radius: 10.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

    
}
