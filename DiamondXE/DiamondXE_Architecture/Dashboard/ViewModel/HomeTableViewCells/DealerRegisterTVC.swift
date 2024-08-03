//
//  DealerRegisterTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/05/24.
//

import UIKit

class DealerRegisterTVC: UITableViewCell {
    
    static let cellIdentifierDealerReg = String(describing: DealerRegisterTVC.self)

    @IBOutlet var imgRegisterNow:UIImageView!
    
    var registerNow : (() -> Void) = { }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
            contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        registerNow()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
