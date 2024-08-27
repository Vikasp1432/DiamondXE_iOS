//
//  RingSiZerTableCell.swift
//  DXE Price
//
//  Created by iOS Developer on 12/04/24.
//

import UIKit

class RingSiZerTableCell: UITableViewCell {
    
    @IBOutlet var lblMM:UILabel!
    @IBOutlet var lblUS:UILabel!
    @IBOutlet var lblIEUR:UILabel!
    @IBOutlet var lblIND:UILabel!
    @IBOutlet var lblIUK:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
