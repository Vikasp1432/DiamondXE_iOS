//
//  DropDownViewCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 06/06/24.
//

import UIKit

class DropDownViewCell: UITableViewCell {
    
    @IBOutlet open weak var optionLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
