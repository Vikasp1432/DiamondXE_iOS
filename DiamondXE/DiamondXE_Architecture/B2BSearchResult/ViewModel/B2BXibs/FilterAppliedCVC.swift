//
//  FilterAppliedCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/06/24.
//

import UIKit

class FilterAppliedCVC: UICollectionViewCell {
    
    
    static let cellIdentifierFilterApplied = String(describing: FilterAppliedCVC.self)
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var btnRemove:UIButton!
    
    var btnAction : (() -> Void) = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    @IBAction func btnActionremoveIndex(_ sender : UIButton){
        btnAction()
    }

}
