//
//  BottomSheetVC.swift
//  DXE Calc
//
//  Created by Genie Talk on 02/03/23.
//

import UIKit

class BottomSheetVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var btnHideShowPass : UIButton!
    @IBOutlet var txtIUserID : UITextField!
    @IBOutlet var txtIUserPass : UITextField!
    
    var bottomSheetDelegate : BottomSheetActionDelegate?

    var isHidePass = true
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIUserID.delegate = self
        txtIUserPass.delegate = self
        UITextField.connectFields(fields: [txtIUserID, txtIUserPass])
        self.txtIUserPass.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnActionHideShowPass( _ sender : UIButton){
        if isHidePass{
            self.isHidePass = false
            self.txtIUserPass.isSecureTextEntry = false
            btnHideShowPass.setImage(UIImage(named: "Show password"), for: .normal)
        }
        else{
            self.isHidePass = true
            self.txtIUserPass.isSecureTextEntry = true
            btnHideShowPass.setImage(UIImage(named: "hide password"), for: .normal)
        }
    }

    @IBAction func btnActionCancel( _ sender : UIButton){
        self.dismiss(animated: true)
       // self.bottomSheetDelegate?.bottomSheetDelegate(userID: self.txtIUserID.text ?? "", userIDPass: self.txtIUserPass.text ?? "", actionTag: 0)
    }
    
    @IBAction func btnActionLogin( _ sender : UIButton){
        self.dismiss(animated: true)
        self.bottomSheetDelegate?.bottomSheetDelegate(userID: self.txtIUserID.text ?? "", userIDPass: self.txtIUserPass.text ?? "", actionTag: 1)
    }

}


extension UITextField {
class func connectFields(fields:[UITextField]) -> Void {
    guard let last = fields.last else {
        return
    }
    for i in 0 ..< fields.count - 1 {
        fields[i].returnKeyType = .next
        fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
    }
    last.returnKeyType = .done
    last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}
