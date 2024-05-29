//
//  GlobleSearchCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/05/24.
//

import UIKit

class GlobleSearchCVC: UICollectionViewCell {
    
    static let cellIdentifireGloblwSearchCVC = String(describing: GlobleSearchCVC.self)
    @IBOutlet var bgView:UIView!
    @IBOutlet var lblTitles:UILabel!

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
