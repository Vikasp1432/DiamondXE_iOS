//
//  ExpandableCell.swift
//  expandableCellDemo
//
//
//

import UIKit

class ExpandableCell: UITableViewCell {
    static let cellIdentifier = String(describing: ExpandableCell.self)
    

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var iconIMG: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
        
}

    

