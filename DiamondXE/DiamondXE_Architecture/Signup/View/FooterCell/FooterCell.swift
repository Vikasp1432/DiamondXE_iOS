//
//  FooterCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/04/24.
//

import UIKit

class FooterCell: UITableViewCell, UITextFieldDelegate {

    var buttonPressed : ((Int) -> Void) = {_ in }
    @IBOutlet var txtRefralCode:FloatingTextField!
    @IBOutlet var btnCreateAccount:UIButton!
    @IBOutlet var btnTNC:UIButton!

    var termAndCondition = false


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtRefralCode.delegate = self
        self.txtRefralCode.floatPlaceholderActiveColor = .themeClr
        self.txtRefralCode.floatPlaceholderColor = .themeClr
        self.btnCreateAccount.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func buttonTNC(_ sender: UIButton) {
        self.termAndCondition.toggle()
        if termAndCondition {
            self.btnCreateAccount.isEnabled = true
            self.btnTNC.setImage(UIImage(named: "checked"), for: .normal)
            btnCreateAccount.backgroundColor = UIColor.themeClr
        }
        else{
            self.btnCreateAccount.isEnabled = false
            self.btnTNC.setImage(UIImage(named: "unchekBox"), for: .normal)
            btnCreateAccount.backgroundColor = UIColor.themeFadeClr
        }
    }
    
    func getRefralCode() -> String {
        return txtRefralCode.text ?? ""
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        buttonPressed(sender.tag)
    }
}
