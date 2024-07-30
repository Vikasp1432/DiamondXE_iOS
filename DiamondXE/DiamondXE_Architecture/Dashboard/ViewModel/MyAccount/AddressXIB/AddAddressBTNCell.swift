//
//  AddAddressBTNCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 25/07/24.
//

import UIKit

class AddAddressBTNCell: UITableViewCell {
    
    static let cellIdentifierAddBTNCell = String(describing: AddAddressBTNCell.self)
    
    @IBOutlet var btnAddAddress:UIButton!
    
    var tapAction : (() -> Void) = {}
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAction(_ sender: UIButton){
        tapAction()
    }
}
