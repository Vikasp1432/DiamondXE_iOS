//
//  PersonalProfileVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 25/07/24.
//

import UIKit
import DTTextField

class PersonalProfileVC: BaseViewController {
    
    @IBOutlet var txtFirstName:DTTextField!
    @IBOutlet var txtLastName:DTTextField!
    @IBOutlet var txtMobile:DTTextField!
    @IBOutlet var txtEmail:DTTextField!
    @IBOutlet var txtCompanyName:DTTextField!
    @IBOutlet var txtCompanyEmail:DTTextField!
    @IBOutlet var txtCompanyPhone:DTTextField!
    @IBOutlet var txtCompanyType:DTTextField!
    @IBOutlet var txtCompanyNatureBusiness:DTTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtMobile.delegate = self
        txtEmail.delegate = self
        txtCompanyName.delegate = self
        txtCompanyPhone.delegate = self
        txtCompanyEmail.delegate = self
        txtCompanyType.delegate = self
        txtCompanyNatureBusiness.delegate = self
        txtMobile.paddingX = 110
        txtCompanyPhone.paddingX = 110
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
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
    }

}
