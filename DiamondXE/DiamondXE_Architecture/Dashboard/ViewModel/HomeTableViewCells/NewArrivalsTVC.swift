//
//  NewArrivalsTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/05/24.
//

import UIKit

class NewArrivalsTVC: UITableViewCell {
    static let cellIdentifierNewArrTVC = String(describing: NewArrivalsTVC.self)
    
    @IBOutlet var newArrImg1:UIImageView!
    @IBOutlet var newArrImg2:UIImageView!
    @IBOutlet var lblTitle:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
