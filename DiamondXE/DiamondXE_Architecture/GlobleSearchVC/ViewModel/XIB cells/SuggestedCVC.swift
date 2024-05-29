//
//  SuggestedCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/05/24.
//

import UIKit

class SuggestedCVC: UICollectionViewCell {

    static let cellIdentifierSuggestedCVC = String(describing: SuggestedCVC.self)
    
    
    @IBOutlet var lblName:UILabel!
    @IBOutlet var imgSuggested:UIImageView!
    @IBOutlet var bgView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        //-Initialization code
        bgView.layer.shadowColor = UIColor.shadowViewclr.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        bgView.layer.shadowRadius = 2.0
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.masksToBounds = false
        
        imgSuggested.layer.cornerRadius = 7
        imgSuggested.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
