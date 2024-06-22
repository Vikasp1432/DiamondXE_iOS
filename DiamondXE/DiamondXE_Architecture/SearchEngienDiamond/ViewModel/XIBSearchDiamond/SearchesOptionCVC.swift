//
//  SearchesOptionCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 04/06/24.
//

import UIKit

protocol OptionsCollectionViewCellDelegate: AnyObject {
    func btnTappedCell(in cell: SearchesOptionCVC)
}

class SearchesOptionCVC: UICollectionViewCell {
    
    static let cellIdentifierSearchOptionCVC = String(describing: SearchesOptionCVC.self)
    
    weak var delegate: OptionsCollectionViewCellDelegate?
    var isGradientApplied: Bool = false {
        didSet {
            if isGradientApplied {
                addShadow()
            } else {
                removeShadow()
            }
        }
    }
    
    @IBOutlet var btnTitle : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnAction(_ sender:UIButton){
        self.delegate?.btnTappedCell(in: self)
    }
    
    
    
    
     func addShadow() {
        btnTitle.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        btnTitle.setTitleColor(.whitClr, for: .normal)
        
    }
    
     func removeShadow() {
        btnTitle.clearGradient()
        btnTitle.setTitleColor(.themeClr, for: .normal)
    }
}
