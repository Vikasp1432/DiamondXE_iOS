//
//  MainCell.swift
//  expandableCellDemo
//
//  
//

import UIKit

class MainCell: UITableViewCell {
    static let cellIdentifier = String(describing: MainCell.self)

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
