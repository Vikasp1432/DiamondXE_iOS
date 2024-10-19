//
//  BannerCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/05/24.
//

import UIKit

class BannerCVC: UICollectionViewCell {
    
    static let cellIdentifierBannerCVC = String(describing: BannerCVC.self)

    
    @IBOutlet var images:UIImageView!
    var tapAction : (() -> Void) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        images.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        images.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped() {
          tapAction()
       }

}
