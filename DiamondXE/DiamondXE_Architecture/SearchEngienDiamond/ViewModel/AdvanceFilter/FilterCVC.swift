//
//  FilterCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/06/24.
//

import UIKit

protocol AdvanceOptionsCVCellDelegate: AnyObject {
    func titleTappedCell(in cell: FilterCVC, category:String)
}

class FilterCVC: UICollectionViewCell {
    
    static let cellIdentifierAdvanceFilCVC = String(describing: FilterCVC.self)
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var bgView:UIView!
    
    weak var delegate: AdvanceOptionsCVCellDelegate?
    var categoryStr: String?

    var isGradientApplied: Bool = false {
        didSet {
            if isGradientApplied {
                addShadow()
            } else {
                removeShadow()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        lblTitle.addGestureRecognizer(tapGesture)
    }
    
    @objc func labelTapped() {
        self.delegate?.titleTappedCell(in: self, category: categoryStr ?? "")

    }
    
    private func addShadow() {
        bgView.setGradientLayerView(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        lblTitle.textColor = .whitClr
        
    }
    
    private func removeShadow() {
        bgView.clearGradientView()
        lblTitle.textColor = .black
    }
    
}
