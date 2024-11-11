//
//  DXELUXeTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/05/24.
//

import UIKit

class DXELUXeTVC: UITableViewCell {

    static let cellIdentifierDXELuxe = String(describing: DXELUXeTVC.self)
    @IBOutlet var imgDXELuxe:UIImageView!
    var registerNowDXELUX : (() -> Void) = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
            contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        registerNowDXELUX()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
