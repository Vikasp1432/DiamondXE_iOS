//
//  SearchDiamondCVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/05/24.
//

import UIKit

protocol CustomCollectionViewCellDelegate: AnyObject {
    func imageViewTapped(in cell: SearchDiamondCVC)
}

class SearchDiamondCVC: UICollectionViewCell {
    
    static let cellIdentifierShapeDiamondCVC = String(describing: SearchDiamondCVC.self)
    
    @IBOutlet var lblCateIMG:UIImageView!
    @IBOutlet var bgView:UIView!
    
    weak var delegate: CustomCollectionViewCellDelegate?



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        lblCateIMG.isUserInteractionEnabled = true
        lblCateIMG.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
           delegate?.imageViewTapped(in: self)
       }
 

    
//    private func applyShadow(select:Bool) {
//        if select{
//            bgView.layer.shadowColor = UIColor.black.cgColor
//            bgView.layer.shadowOffset = CGSize(width: 0, height: 3)
//            bgView.layer.shadowRadius = 5
//            bgView.layer.shadowOpacity = 0.3
//            bgView.layer.masksToBounds = false
//            bgView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: bgView.layer.cornerRadius).cgPath
//        }
//        else{
//            bgView.layer.shadowOpacity = 0
//        }
//    }
    
    
    var isShadowApplied: Bool = false {
           didSet {
               if isShadowApplied {
                   addShadow()
               } else {
                   removeShadow()
               }
           }
       }

       
       private func addShadow() {
           bgView.layer.shadowColor = UIColor.black.cgColor
           bgView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
           let shadowSize: CGFloat = 7
           let contactRect = CGRect(x: 0, y: bgView.frame.size.height - (shadowSize * 0.4), width: bgView.frame.size.width , height: shadowSize)
           bgView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
           bgView.layer.shadowRadius = 5
           bgView.layer.shadowOpacity = 0.5
           bgView.layer.borderColor = UIColor.gradient2.cgColor
           bgView.layer.borderWidth = 0.8
           bgView.layer.masksToBounds = false
           

           
//           let shadowPath = UIBezierPath()
//           shadowPath.move(to: CGPoint(x: bgView.bounds.origin.x, y: bgView.frame.size.height))
//           shadowPath.addLine(to: CGPoint(x: bgView.bounds.width  / 2, y: bgView.bounds.width + 7.0))
//           shadowPath.addLine(to: CGPoint(x: bgView.bounds.width, y: bgView.bounds.height))
//
//
//           shadowPath.close()
//           
//      
//           bgView.layer.shadowColor = UIColor.darkGray.cgColor
//           bgView.layer.shadowOpacity = 0.8
//           bgView.layer.masksToBounds = false
//           bgView.layer.shadowPath = shadowPath.cgPath
//           bgView.layer.shadowRadius = 4.8
//           bgView.layer.shadowOffset = CGSize(width: 0, height: 3)
          
       }
       
       private func removeShadow() {
           bgView.layer.shadowColor = nil
           bgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
           bgView.layer.shadowRadius = 0.0
           bgView.layer.shadowOpacity = 0.0
           bgView.layer.borderColor = UIColor.clear.cgColor
           bgView.layer.borderWidth = 0
           bgView.layer.masksToBounds = true
       }

    
  
}
