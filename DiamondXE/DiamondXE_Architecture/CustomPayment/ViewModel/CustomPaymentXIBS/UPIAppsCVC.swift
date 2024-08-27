//
//  UPIAppsCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/08/24.
//

import UIKit

class UPIAppsCVC: UICollectionViewCell {
    static let cellIdentifierUPIAppsCVC = String(describing: UPIAppsCVC.self)
    
    @IBOutlet var iconIMG:UIImageView!
    @IBOutlet var lblName:UILabel!
    
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
