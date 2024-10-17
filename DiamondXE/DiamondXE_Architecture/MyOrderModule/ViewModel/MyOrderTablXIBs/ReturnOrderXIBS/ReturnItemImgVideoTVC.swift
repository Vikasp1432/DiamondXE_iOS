//
//  ReturnItemImgVideoTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 04/10/24.
//

import UIKit
import DTTextField

class ReturnItemImgVideoTVC: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {

    static let cellIdentifierReturnItemImgVideoTVC = String(describing: ReturnItemImgVideoTVC.self)
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var resionView: UIView!
    
    @IBOutlet weak var lblShape: UILabel!
    @IBOutlet weak var lblClr: UILabel!
    @IBOutlet weak var lblCarat: UILabel!
    @IBOutlet weak var lblClarity: UILabel!
    @IBOutlet weak var imgDia: UIImageView!
    
    @IBOutlet weak var txtResion: DTTextField!
    @IBOutlet weak var txtVideoURL: DTTextField!
    
    
    @IBOutlet weak var viewIMGGet: UIButton!
    @IBOutlet weak var viewIMGGetDone: UIButton!
    @IBOutlet weak var viewVideoGet: UIButton!
    @IBOutlet weak var viewVideoGetDone: UIButton!
    
    let placeholderText = "Enter your resion here..."
    
    var tapAction : ((Int) -> Void) = { _ in  }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTextView()
        txtVideoURL.delegate = self
        textView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        resionView.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        tapAction(0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTextView() {
          
           textView.text = placeholderText
           textView.textColor = UIColor.lightGray
       }
       
       // UITextViewDelegate method to clear the placeholder when the user starts editing
       func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == placeholderText {
               textView.text = ""
               textView.textColor = UIColor.black
           }
       }
 
       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.isEmpty {
               textView.text = placeholderText
               textView.textColor = UIColor.lightGray
               
           }
           else{
               tapAction(5)
           }
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
            tapAction(4)
        }
    }
    
    
    
    @IBAction func btnactionsManage(_ sender : UIButton){
        
        if sender.tag == 0{
            tapAction(0)
        }
        else if sender.tag == 1{
            tapAction(1)
        }
        else if sender.tag == 2{
            tapAction(2)
        }
        else{
            tapAction(3)
        }
        
    }
    
    
    
    
}
