//
//  CustomInfoTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/08/24.
//

import UIKit
import DTTextField

protocol CustomCellInfoDelegate: AnyObject {
    func textFieldDidEndEditing(cell: CustomInfoTVC, text: String)
}

class CustomInfoTVC: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {
    static let cellIdentifierCustomInfoTVC = String(describing: CustomInfoTVC.self)

   // @IBOutlet var viewBG:UIView!
    
    @IBOutlet weak var textView: UITextView!
    private let placeholderLabel = UILabel()
    
    @IBOutlet weak var txtName: DTTextField!
    @IBOutlet weak var txtComopanyName: DTTextField!
    @IBOutlet weak var txtAmount: DTTextField!
    
    var customPymnt = CustomPaymentVC()
    weak var delegate: CustomCellInfoDelegate?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // viewBG.applyShadow()
        setupPlaceholder()
        textView.delegate = self
        
        txtAmount.keyboardType = .decimalPad
        
        txtName.delegate = self
        txtComopanyName.delegate = self
        txtAmount.delegate = self
     
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
           }
       }
       
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
        
        if let  txtfield = txtAmount {
            delegate?.textFieldDidEndEditing(cell: self, text: txtfield.text ?? "")

        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupPlaceholder() {
          placeholderLabel.text = "Enter your remark"
          placeholderLabel.font = UIFont.systemFont(ofSize: 14)
          placeholderLabel.sizeToFit()
          placeholderLabel.frame.origin = CGPoint(x: 5, y: textView.font?.pointSize ?? 14 / 2)
          placeholderLabel.textColor = UIColor.lightGray
          placeholderLabel.isHidden = !textView.text.isEmpty
          
          textView.addSubview(placeholderLabel)
      }
      
      func textViewDidChange(_ textView: UITextView) {
          placeholderLabel.isHidden = !textView.text.isEmpty
      }
    
    
    func dataCollect() -> Bool{
        
        if self.validateData() {
            customPymnt.name = self.txtName.text ?? ""
            customPymnt.companyName = self.txtComopanyName.text ?? ""
            customPymnt.amount = self.txtAmount.text ?? ""
            customPymnt.remark = self.textView.text ?? ""
            return true
        }
        return false
    }
    
    func validateData() -> Bool {
        
        guard !txtName.text!.isEmptyStr else {
            txtName.showError(message: "Enter Name")
            return false
        }
        guard !txtComopanyName.text!.isEmptyStr else {
            txtComopanyName.showError(message: "Enter company name")
            return false
        }
        guard !txtAmount.text!.isEmptyStr else {
            txtAmount.showError(message: "Enter amount")
            return false
        }
        return true
    }
    
}
