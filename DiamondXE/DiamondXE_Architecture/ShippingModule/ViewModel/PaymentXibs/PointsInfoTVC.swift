//
//  PointsInfoTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/09/24.
//

import UIKit
import DTTextField

protocol TextFieldUpdateDelegate: AnyObject {
    func didUpdateText(_ text: String, tag:Int)
}

class PointsInfoTVC: UITableViewCell, UITextFieldDelegate {
    
    static let cellIdentifierPointsInfoTVC = String(describing: PointsInfoTVC.self)
    
    
    weak var delegate: TextFieldUpdateDelegate?
    
    @IBOutlet var viewData:UIView!
    
    @IBOutlet var btnWalletPointVerify:UIButton!
    @IBOutlet var btnPointVeryfy:UIButton!
    
    @IBOutlet var btnWalletPointVerified:UIButton!
    @IBOutlet var btnPointVeryfied:UIButton!
    
    @IBOutlet var txtWalletPoint:DTTextField!
    @IBOutlet var txtPoints:DTTextField!
    
    @IBOutlet var viewPointEnter:UIView!
    @IBOutlet var lblTotalWalletPoints:UILabel!
    @IBOutlet var lblTotalPoints:UILabel!
    @IBOutlet var btnInfo:UIButton!
    
    var btnAction : ((Int) -> Void) = {_ in }
    var btnActionApply : (() -> Void) = { }
    
   // var ifUpdatePoint = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtWalletPoint.delegate = self
        viewData.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewData.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewData.layer.shadowRadius = 2.0
        viewData.layer.shadowOpacity = 0.5
        viewData.layer.masksToBounds = false
        
        //self.btnPointVeryfy.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnWalletPointVerify.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let dtTextField = textField as? DTTextField {
            dtTextField.borderColor = UIColor.tabSelectClr
                
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // Change border color or perform any other actions
           if let customTextField = textField as? DTTextField {
               customTextField.borderColor = UIColor.tabSelectClr
              
              // delegate?.didUpdateText(textField.text ?? "", tag: 0)
           }
       }
       
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
            delegate?.didUpdateText(textField.text ?? "", tag: 0)
            
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pointsView(isShow:Bool){
        if isShow{
            viewPointEnter.isHidden = false
        }
        else{
            viewPointEnter.isHidden = true
        }
    }
    
    @IBAction func btnActionDD(_ sender:UIButton){
        btnAction(sender.tag)
       
    }
    
    @IBAction func btnActionApply(_ sender:UIButton){
        btnActionApply()
       
    }
    
}
