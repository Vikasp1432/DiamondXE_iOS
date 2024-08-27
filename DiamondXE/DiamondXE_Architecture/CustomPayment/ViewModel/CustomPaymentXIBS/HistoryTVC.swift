//
//  HistoryTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/08/24.
//

import UIKit

class HistoryTVC: UITableViewCell {
    
    static let cellIdentifierHistoryTVC = String(describing: HistoryTVC.self)
    
    @IBOutlet var viewBG:UIView!
    @IBOutlet var lblDateTime : UILabel!
    @IBOutlet var lblTransactionID : UILabel!
    @IBOutlet var lblStatus : UILabel!
    @IBOutlet var lblAmount : UILabel!
    @IBOutlet var lblMode : UILabel!
    @IBOutlet var lblNarration : UILabel!
    
    @IBOutlet var viewBGDateTime:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBG.applyShadow()
        viewBGDateTime.roundTopCorners(radius: 8)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
