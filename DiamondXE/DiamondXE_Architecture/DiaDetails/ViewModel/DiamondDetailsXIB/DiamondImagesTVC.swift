//
//  DiamondImagesTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 20/06/24.
//

import UIKit

class DiamondImagesTVC: UITableViewCell {
    
    static let cellIdentifierDiaDetailsTVC = String(describing: DiamondImagesTVC.self)
    
    @IBOutlet var btnShowInfoView: UIButton!
    @IBOutlet var lblTypeDia: UILabel!
    @IBOutlet var viewBG: UIView!
    @IBOutlet var btnAvailable: UIButton!
    
    @IBOutlet var viewCategoryBG: UIView!
    @IBOutlet var lmgLuxTag :UIImageView!
    @IBOutlet var viewImages: UIView!
    @IBOutlet var view360View: UIView!
    @IBOutlet var viewCertificate: UIView!
    @IBOutlet var viewSize: UIView!
    @IBOutlet var imgImages: UIImageView!
    @IBOutlet var img360View: UIImageView!
    @IBOutlet var imgCertificate: UIImageView!
    @IBOutlet var imgSize: UIImageView!
    
    @IBOutlet var imgTapImages: UIImageView!
    @IBOutlet var imgTap360View: UIImageView!
    @IBOutlet var imgTapCertificate: UIImageView!
    @IBOutlet var imgTapSize: UIImageView!
    @IBOutlet var lblImages: UILabel!
    @IBOutlet var lbl360View: UILabel!
    @IBOutlet var lblCertificate: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var viewRefundable: UIView!
    
    @IBOutlet var imgDiamndView: UIImageView!


    var alertActionTag = 0
    var alertAction : ((Int) -> Void) = { _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.5
        viewBG.layer.masksToBounds = false
        
        imgDiamndView.translatesAutoresizingMaskIntoConstraints = false
        imgDiamndView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imgDiamndView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        alertAction(alertActionTag)
    }
    
    @IBAction func btnActionRetunable(_ sender : UIButton){
        
        viewRefundable.isHidden = false
        
        // Perform animation
        UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
            self.viewRefundable.alpha = 0.0 // Fade out
        }) { _ in
            self.viewRefundable.isHidden = true // Hide after animation completes
            self.viewRefundable.alpha = 1.0 // Reset alpha for next use
        }
    }
    
  
    @IBAction func btnViewAction(_ sender:UIButton){
        switch sender.tag {
        case 0:
            self.imgImages.backgroundColor = UIColor.tabSelectClr
            self.img360View.tintColor = UIColor.darkGray
            self.imgCertificate.backgroundColor = UIColor.darkGray
            self.imgSize.backgroundColor = UIColor.darkGray
            
            self.imgTapImages.tintColor = UIColor.tabSelectClr
            self.imgTap360View.tintColor = UIColor.darkGray
            self.imgTapCertificate.tintColor = UIColor.darkGray
            self.imgTapSize.tintColor = UIColor.darkGray
            
            self.lblImages.textColor = UIColor.tabSelectClr
            self.lbl360View.textColor = UIColor.darkGray
            self.lblCertificate.textColor = UIColor.darkGray
            self.lblSize.textColor = UIColor.darkGray
            alertActionTag = 0
            alertAction(alertActionTag)
        case 1:
            self.imgImages.backgroundColor = UIColor.darkGray
            self.img360View.tintColor = UIColor.tabSelectClr
            self.imgCertificate.backgroundColor = UIColor.darkGray
            self.imgSize.backgroundColor = UIColor.darkGray
            
            self.imgTapImages.tintColor = UIColor.darkGray
            self.imgTap360View.tintColor = UIColor.tabSelectClr
            self.imgTapCertificate.tintColor = UIColor.darkGray
            self.imgTapSize.tintColor = UIColor.darkGray
            
            self.lblImages.textColor = UIColor.darkGray
            self.lbl360View.textColor = UIColor.tabSelectClr
            self.lblCertificate.textColor = UIColor.darkGray
            self.lblSize.textColor = UIColor.darkGray
            alertActionTag = 1
            alertAction(alertActionTag)
        case 2:
            self.imgImages.backgroundColor = UIColor.darkGray
            self.img360View.tintColor = UIColor.darkGray
            self.imgCertificate.backgroundColor = UIColor.tabSelectClr
            self.imgSize.backgroundColor = UIColor.darkGray
            
            self.imgTapImages.tintColor = UIColor.darkGray
            self.imgTap360View.tintColor = UIColor.darkGray
            self.imgTapCertificate.tintColor = UIColor.tabSelectClr
            self.imgTapSize.tintColor = UIColor.darkGray
            
            self.lblImages.textColor = UIColor.darkGray
            self.lbl360View.textColor = UIColor.darkGray
            self.lblCertificate.textColor = UIColor.tabSelectClr
            self.lblSize.textColor = UIColor.darkGray
            alertActionTag = 2
            alertAction(alertActionTag)
        case 3:
            self.imgImages.backgroundColor = UIColor.darkGray
            self.img360View.tintColor = UIColor.darkGray
            self.imgCertificate.backgroundColor = UIColor.darkGray
            self.imgSize.backgroundColor = UIColor.tabSelectClr
            
            self.imgTapImages.tintColor = UIColor.darkGray
            self.imgTap360View.tintColor = UIColor.darkGray
            self.imgTapCertificate.tintColor = UIColor.darkGray
            self.imgTapSize.tintColor = UIColor.tabSelectClr
            
            self.lblImages.textColor = UIColor.darkGray
            self.lbl360View.textColor = UIColor.darkGray
            self.lblCertificate.textColor = UIColor.darkGray
            self.lblSize.textColor = UIColor.tabSelectClr
            alertActionTag = 3
            alertAction(alertActionTag)
        default:
            print("")
        }
    }
    
    
  
    
}
