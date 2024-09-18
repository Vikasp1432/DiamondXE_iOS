//
//  PaymentInProgressVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/08/24.
//

import UIKit

class PaymentInProgressVC: UIViewController {
    
    @IBOutlet var lblOrderID:UILabel!
    @IBOutlet var lblAmount:UILabel!
    @IBOutlet var lblUTRCHequeNo:UILabel!
    @IBOutlet var lblPaymentMode:UILabel!
    
    var paymentINProcessStruct = PaymentINProcessStruct()
    var checqNum = String()

    @IBOutlet var viewBG:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBG.applyShadow()
        // Do any additional setup after loading the view.
        
        lblOrderID.text = paymentINProcessStruct.details?.orderID
        lblAmount.text = "\(paymentINProcessStruct.details?.currencySymbol ?? "")\(paymentINProcessStruct.details?.totalAmount ?? 0)"
        lblUTRCHequeNo.text = checqNum
        lblPaymentMode.text = paymentINProcessStruct.details?.paymentMode
    }

    
    @IBAction func btnActionMyOrderBacktoHome(_ sender:UIButton){
        
       // self.navigationController?.popToRootViewController(animated: true)

        
//        if sender.tag == 0{
//            self.navigationController?.popViewController(animated: true)
//        }
//        else{
//            self.navigationController?.popViewController(animated: true)
//        }
        
        
        for controller in self.navigationController!.viewControllers as Array {
            if let dashboardVC = controller as? DashboardVC {
                // Pop to the DashboardVC
                self.navigationController!.popToViewController(dashboardVC, animated: true)
                
                // Ensure the first tab is selected in the tab bar controller
                let button = UIButton()
                 button.tag = 0
                dashboardVC.btnActionTapped(button)
                
                break
            }
        }
        
    }

}
