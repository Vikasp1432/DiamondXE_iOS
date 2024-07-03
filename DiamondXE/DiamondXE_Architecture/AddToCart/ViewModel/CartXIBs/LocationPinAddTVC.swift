//
//  LocationPinAddTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/06/24.
//

import UIKit

class LocationPinAddTVC: UITableViewCell {
    
    static let cellIdentifierLocation = String(describing: LocationPinAddTVC.self)

    @IBOutlet var viewBG:UIView!
    @IBOutlet var imgCheckBox:UIImageView!
    @IBOutlet var btnSelectPin:UIButton!
    @IBOutlet var lblPinCode:UILabel!

    
    var isChekd = false
    var alertAction : (() -> Void) = {  }
    var actionShipingChrg : (() -> Void) = {  }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBG.applyShadow()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgCheckBox.isUserInteractionEnabled = true
        imgCheckBox.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        lblPinCode.addGestureRecognizer(tapGesture)

    }
    
    @objc func cellTapped() {
        alertAction()
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        isChekd.toggle()
        actionShipingChrg()
        if isChekd{
            imgCheckBox.image = UIImage(named: "check")
        }
        else{
            imgCheckBox.image = UIImage(named: "uncheck")
        }
    }
    
    
    @IBAction func actionSelect(_ sender: UIButton){
        alertAction()
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
