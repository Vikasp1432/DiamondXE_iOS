//
//  MediaSpotlightTVCl.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/05/24.
//

import UIKit

class MediaSpotlightTVCl: UITableViewCell {

    static let cellIdentifierMediaSpotlight = String(describing: MediaSpotlightTVCl.self)
    
    @IBOutlet var bgView:UIView!
    @IBOutlet var imgMedia1:UIImageView!
    @IBOutlet var lblDesc1:UILabel!
    
    @IBOutlet var imgMedia2:UIImageView!
    @IBOutlet var lblDesc2:UILabel!
    
    @IBOutlet var imgMedia3:UIImageView!
    @IBOutlet var lblDesc3:UILabel!

    var btnActionMediaSpotlight : ((Int) -> Void) = { _ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        bgView.layer.shadowColor = UIColor.blackClr.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        bgView.layer.shadowRadius = 2.0
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.masksToBounds = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionSpotlight(_ sender : UIButton){
        self.btnActionMediaSpotlight(sender.tag)
    }
    
}
