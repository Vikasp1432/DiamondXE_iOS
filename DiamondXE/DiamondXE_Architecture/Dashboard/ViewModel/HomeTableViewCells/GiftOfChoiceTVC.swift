//
//  GiftOfChoiceTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/05/24.
//

import UIKit

class GiftOfChoiceTVC: UITableViewCell {
    
    static let cellIdentifierGiftChoiceTVC = String(describing: GiftOfChoiceTVC.self)
    
    @IBOutlet var giftImg1:UIImageView!
    @IBOutlet var giftImg2:UIImageView!
    @IBOutlet var giftImg3:UIImageView!
    @IBOutlet var giftImg4:UIImageView!
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
