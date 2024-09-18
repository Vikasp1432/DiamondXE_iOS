//
//  CellMultiItemTV.swift
//  DiamondXE
//
//  Created by iOS Developer on 12/09/24.
//

import UIKit

class CellMultiItemTV: UITableViewCell {

    static let cellIdentifierCellMultiItemTV = String(describing: CellMultiItemTV.self)
    
    @IBOutlet var imgDiamond : UIImageView!
   
    @IBOutlet var lblCertificateNo : UILabel!
    @IBOutlet var lblPrice : UILabel!
    @IBOutlet var lblShape : UILabel!
    @IBOutlet var lblCarat : UILabel!
    @IBOutlet var lblColor : UILabel!
    @IBOutlet var lblClarity : UILabel!
    @IBOutlet var lblOrderStatus : UILabel!
    @IBOutlet var lblDiaType : UILabel!
    @IBOutlet var viewOrderStatus : UIView!
    @IBOutlet var viewDiaType : UIView!
    @IBOutlet var btnSelected : UIButton!
    
    var btnActionsManage : ((Int) -> Void) = { _ in}
    
    var checkboxButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnSelected.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(isSelected: Bool) {
        let checkboxImage = isSelected ? UIImage(named: "checked") : UIImage(named: "uncheck")
        btnSelected.setImage(checkboxImage, for: .normal)
        }

    
    @IBAction func btnactionsSelect(_ sender : UIButton){
        
        checkboxButtonAction?()
        //self.btnActionsManage(sender.tag)
    }
    
}
