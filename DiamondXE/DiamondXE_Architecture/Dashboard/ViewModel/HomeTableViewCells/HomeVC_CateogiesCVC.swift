//
//  HomeVC_CateogiesCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 20/05/24.
//

import UIKit

class HomeVC_CateogiesCVC: UICollectionViewCell {
    static let cellIdentifierHomeCVC = String(describing: HomeVC_CateogiesCVC.self)
    
    
    @IBOutlet var lblCateName:UILabel!
    @IBOutlet var lblCateIMG:UIImageView!
    @IBOutlet var bgView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.shadowColor = UIColor.shadowViewclr.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        bgView.layer.shadowRadius = 2.0
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.masksToBounds = false
    }

}
