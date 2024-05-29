//
//  TopDealsCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/05/24.
//

import UIKit

class TopDealsCVC: UICollectionViewCell {
    static let cellIdentifierTopDealsCVC = String(describing: TopDealsCVC.self)
    @IBOutlet var lblDiaName:UILabel!
    @IBOutlet var lblDiaPrice:UILabel!
    @IBOutlet var imgDiamond:UIImageView!

    @IBOutlet var bgView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.shadowColor = UIColor.shadowViewclr.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        bgView.layer.shadowRadius = 2.0
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.masksToBounds = false
       

        imgDiamond.layer.cornerRadius = 7
        imgDiamond.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
