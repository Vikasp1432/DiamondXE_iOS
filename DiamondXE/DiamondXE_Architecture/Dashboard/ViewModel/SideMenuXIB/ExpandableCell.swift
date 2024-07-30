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
    
    var tapCell : (() -> Void) = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
       
    }
    
    @objc func cellTapped() {
        tapCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
        
}

    

