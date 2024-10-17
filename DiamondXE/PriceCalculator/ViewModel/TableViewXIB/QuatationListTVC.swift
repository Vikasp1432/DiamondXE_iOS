//
//  QuatationListTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 10/10/24.
//

import UIKit

class QuatationListTVC: UITableViewCell {
    
    @IBOutlet var lbldate : UILabel!
    @IBOutlet var lblKt : UILabel!
    @IBOutlet var lblName : UILabel!
    @IBOutlet var lblGrandTotl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
