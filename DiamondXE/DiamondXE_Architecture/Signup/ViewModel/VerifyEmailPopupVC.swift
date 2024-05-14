//
//  VerifyEmailPopupVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/05/24.
//

import UIKit

class VerifyEmailPopupVC: UIViewController {
    
    @IBOutlet var txtOTP:FloatingTextField!
    @IBOutlet var lblTimer:UILabel!
    @IBOutlet var lblHeading:UILabel!
    var isEmailVerify : ((Int, String) -> Void) = {_,_  in }
    var email = String()
    var param : [String:Any] = [:]
    var emailStruct = EmialVerify()
    var emailVerifyDelegate : EmialVerifyDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtOTP.floatPlaceholderActiveColor = .themeClr
        self.txtOTP.floatPlaceholderColor = .themeClr
        
       
       // get otp
     //   getOTP()
        TimerManager.shared.startTimer(withLabel: self.lblTimer) {
             print("Start time")
        }
        
        self.lblHeading.text = "We have sent an OTP to your \(email)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        verifyOTP()
    }
    
    @IBAction func buttonActionResend(_ sender: UIButton) {
        getOTP()
       
    }
    
    @IBAction func buttonActionBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func verifyOTP(){
        
        if txtOTP.text?.count ?? 0 > 0{
            
            
            
            param  = ["email" : self.email, "requestOtp": 0,  "otp": Int(self.txtOTP.text ?? "") ?? 0]
            
            
            CustomActivityIndicator.shared.show(in: view)
            SignupDataModel().emialVerification(url: APIs().email_verification_API, requestParam: self.param, completion: { emailVerify , message in
                print(emailVerify)
                if emailVerify.status == 1{
                    self.emailVerifyDelegate?.didEmailVerify(status: emailVerify.status ?? 0, msg: emailVerify.msg ?? "")
                    self.toastMessage(emailVerify.msg ?? "")
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    self.toastMessage(emailVerify.msg ?? "")
                }
                CustomActivityIndicator.shared.hide()
                
            })
        }
        else{
            txtOTP.showError(message: "Enter OTP first")

        }
        
    }
    
    func getOTP() {
        param  = ["email" : self.email, "requestOtp": 1]
        CustomActivityIndicator.shared.show(in: view)
        SignupDataModel().emialVerification(url: APIs().email_verification_API, requestParam: self.param, completion: { emailVerify , message in
            print(emailVerify)
            if emailVerify.status == 2{
                self.emailStruct.msg = emailVerify.msg
                self.emailStruct.status = emailVerify.status
                self.toastMessage(emailVerify.msg ?? "")
//                TimerManager.shared.startTimer(withLabel: self.lblTimer) {
//                     print("Start time")
//                }
            }
            else{
                self.toastMessage(emailVerify.msg ?? "")
            }
            CustomActivityIndicator.shared.hide()
            
        })
    }
    
    


}
