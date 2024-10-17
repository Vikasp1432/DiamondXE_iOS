//
//  ItemAgreeToRefundTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/10/24.
//

import UIKit

class ItemAgreeToRefundTVC: UITableViewCell {

    static let cellIdentifierItemAgreeToRefundTVC = String(describing: ItemAgreeToRefundTVC.self)
    
    @IBOutlet var viewDataBG : UIView!
    
    @IBOutlet var checkBoxButton : UIButton!
    
    var isCheckBoxSelected: Bool = false

    var isSelectCondition : ((Bool) -> Void) = { _ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //viewDataBG.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnactionsTandC(_ sender : UIButton){
        isCheckBoxSelected.toggle()
        updateButtonAppearance(isSelected: isCheckBoxSelected)
        isSelectCondition(isCheckBoxSelected)
//        if isCheckBoxSelected {
//            print("Checkbox is selected")
//        } else {
//            print("Checkbox is unselected")
//        }
    }
    
    // Update button appearance based on the selection state
    func updateButtonAppearance(isSelected: Bool) {
        if isSelected {
            checkBoxButton.setImage(UIImage(named: "check"), for: .normal)
        } else {
            checkBoxButton.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    
    
}
