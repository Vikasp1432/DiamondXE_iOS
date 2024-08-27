//
//  PopularBanksCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/08/24.
//

import UIKit

class PopularBanksCVC: UICollectionViewCell {
    
    static let cellIdentifierPopularBanksCVC = String(describing: PopularBanksCVC.self)
    
    
    @IBOutlet var imgView:UIImageView!

    var tapAction : (() -> Void) = { }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
          // Call the closure when the view is tapped
        tapAction()
      }


}
