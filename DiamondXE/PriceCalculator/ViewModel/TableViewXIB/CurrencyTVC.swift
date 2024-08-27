//
//  CurrencyTVC.swift
//  DXE Calc
//
//  Created by Genie Talk on 02/03/23.
//

import UIKit

class CurrencyTVC: UITableViewCell {

    @IBOutlet var lblCurrencyName : UILabel!
    @IBOutlet var lblCurrencyValue : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
