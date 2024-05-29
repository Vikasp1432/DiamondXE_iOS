//
//  CustomerViewCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/05/24.
//

import UIKit

class CustomerViewCVC: UICollectionViewCell {
    
    static let cellIdentifierCustomerViewCVC = String(describing: CustomerViewCVC.self)
    
    @IBOutlet var imgCustomer:UIImageView!
    
    @IBOutlet var bgView:UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
//        bgView.layer.shadowColor = UIColor.blackClr.cgColor
//        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        bgView.layer.shadowRadius = 2.0
//        bgView.layer.shadowOpacity = 0.3
//        bgView.layer.masksToBounds = false
        
        
        
    }
}
