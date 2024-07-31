//
//  CustomPlaceOrderView.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/07/24.
//

import UIKit

class CustomPlaceOrderView:  UIViewController {
    
    //IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
//    @IBOutlet var bgView : UIView!
//    @IBOutlet var imgDiamond : UIImageView!
//    @IBOutlet var iblTitle : UILabel!
    


    
    init() {
        super.init(nibName: "CustomPlaceOrderView", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
       

    }
    
 
   
    
    @IBAction func btnActionSupoort(_ sender : UIButton){

        if sender.tag == 0{
            let phoneNumber = nv_whatsapp
            if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                if UIApplication.shared.canOpenURL(phoneURL) {
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                } else {
                    // Handle the error
                    print("Cannot open phone dialer")
                }
            }
        }
        else{
            let email = nv_emial
                   if let emailURL = URL(string: "mailto:\(email)") {
                       if UIApplication.shared.canOpenURL(emailURL) {
                           UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                       } else {
                           // Handle the error
                           print("Cannot open email client")
                       }
                   }
        }
        
    }
    
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
            
        }
    }
    
    
  
    
    
    private func show() {
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
