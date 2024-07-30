//
//  MainCell.swift
//  expandableCellDemo
//
//  
//

import UIKit

class MainCell: UITableViewCell {
    static let cellIdentifier = String(describing: MainCell.self)
    @IBOutlet weak var mainIconIMG: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet  var dropdownIcon: UIImageView! // Add this outlet
    
    var tapCell : (() -> Void) = { }

    func configure(with section: Sections) {
        
        label.text = section.mainCellTitle
                if section.expandableCellOptions.isEmpty {
                    dropdownIcon.isHidden = true // Hide the dropdown icon if no expandable options
                } else {
                    dropdownIcon.isHidden = false
                    let imageName = section.isExpanded ? "Sub Bar Icon" : "Drop_Up" // Replace with your icon names
                    dropdownIcon.image = UIImage(named: imageName)
                }
   
        }
    
    func configure2(with section: SectionsAccount) {
        
        label.text = section.mainCellTitle
                if section.expandableCellOptions.isEmpty {
                    dropdownIcon.isHidden = true // Hide the dropdown icon if no expandable options
                } else {
                    dropdownIcon.isHidden = false
                    let imageName = section.isExpanded ? "Sub Bar Icon" : "Drop_Up" // Replace with your icon names
                    dropdownIcon.image = UIImage(named: imageName)
                }
   
        }
    
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
    
}
