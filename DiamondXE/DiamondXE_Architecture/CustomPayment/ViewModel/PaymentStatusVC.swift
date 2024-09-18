//
//  PaymentStatusVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 30/08/24.
//

import UIKit

class PaymentStatusVC: UIViewController {
    
    @IBOutlet var lblOrderID:UILabel!
    @IBOutlet var lblAmount:UILabel!
    @IBOutlet var lblUTRCHequeNo:UILabel!
    @IBOutlet var lblPaymentMode:UILabel!
    @IBOutlet var lblHeadingOrderID:UILabel!
    @IBOutlet var lblHeadingAmount:UILabel!
    @IBOutlet var lblHeadingUTRCHequeNo:UILabel!
    @IBOutlet var lblHeadingPaymentMode:UILabel!
    @IBOutlet var viewBG:CenterGradientView!
    @IBOutlet var viewSuperBG:UIView!
    
    @IBOutlet var imgViewLogoBG:UIImageView!
    @IBOutlet var lblStatus:UILabel!
    @IBOutlet var lblDec:UILabel!
    @IBOutlet var lblInfoSummry:UILabel!
    @IBOutlet var stackData1:UIStackView!
    @IBOutlet var stackData2:UIStackView!
    
    @IBOutlet var btnMyOrder:UIButton!
    @IBOutlet var btnBackTohome:UIButton!
    @IBOutlet var btnRetryPayment:UIButton!
    
    var paymentStatusDataStruct = PaymentStatusStruct()
    
    let gradientView = CenterGradientView()


    override func viewDidLoad() {
        super.viewDidLoad()
      
       // viewBG.applyShadow()
        setupData()
        // Do any additional setup after loading the view.
        btnMyOrder.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        btnBackTohome.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        btnRetryPayment.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
    }
    
    func setupData(){
        let status = paymentStatusDataStruct.details?.paymentStatus
        
        lblOrderID.text = paymentStatusDataStruct.details?.referenceNo
        lblAmount.text = "\(paymentStatusDataStruct.details?.currencySymbol ?? "")\(paymentStatusDataStruct.details?.finalAmount ?? "")"
        lblUTRCHequeNo.text = paymentStatusDataStruct.details?.paymentMode
        lblPaymentMode.text = paymentStatusDataStruct.details?.paymentMode
        self.lblInfoSummry.text = "*Order has been placed successfully. Availability of diamonds) is subject to confirmation."
        
        switch status {
        case "Paid":
            self.viewBG.applyCenterGradient(colors: [UIColor.themeClr, UIColor.tabSelectClr, UIColor.themeClr])
            self.stackData1.isHidden = false
            self.stackData2.isHidden = false
            self.btnMyOrder.isHidden = false
            self.btnBackTohome.isHidden = false
            self.btnRetryPayment.isHidden = true
            self.imgViewLogoBG.image = UIImage(named: "paymentSuccessful")
            self.lblDec.text = "Your payment has been processed! Details of the transaction are mentioned below"
            self.lblStatus.text = "Payment successful!"
            
            self.lblDec.isHidden = false
            self.lblStatus.isHidden = false
            self.lblInfoSummry.isHidden = false
            
            lblOrderID.textColor = UIColor.whitClr
            lblAmount.textColor = UIColor.whitClr
            lblUTRCHequeNo.textColor = UIColor.whitClr
            lblPaymentMode.textColor = UIColor.whitClr
            lblDec.textColor = UIColor.whitClr
            lblHeadingOrderID.textColor = UIColor.whitClr
            lblHeadingAmount.textColor = UIColor.whitClr
            lblHeadingUTRCHequeNo.textColor = UIColor.whitClr
            lblHeadingPaymentMode.textColor = UIColor.whitClr
            lblStatus.textColor = UIColor.themeGoldenClr
            lblInfoSummry.textColor = UIColor.themeGoldenClr
            
            viewSuperBG.backgroundColor = UIColor.themeClr
            
        case "In-Progress" , "Pending":
            self.viewBG.clearGradient()
            self.stackData1.isHidden = false
            self.stackData2.isHidden = false
            self.btnMyOrder.isHidden = false
            self.btnBackTohome.isHidden = false
            self.btnRetryPayment.isHidden = true
            self.imgViewLogoBG.image = UIImage(named: "payment_processing")
            self.lblDec.text = "Your payment is under review,details of the transaction are mentioned below"
            self.lblStatus.text = "Payment processing!"
           
            lblOrderID.textColor = UIColor.themeClr
            lblAmount.textColor = UIColor.themeClr
            lblUTRCHequeNo.textColor = UIColor.themeClr
            lblPaymentMode.textColor = UIColor.themeClr
            lblDec.textColor = UIColor.themeClr
            lblHeadingOrderID.textColor = UIColor.themeClr
            lblHeadingAmount.textColor = UIColor.themeClr
            lblHeadingUTRCHequeNo.textColor = UIColor.themeClr
            lblHeadingPaymentMode.textColor = UIColor.themeClr
            lblStatus.textColor = UIColor.blackClr
            lblInfoSummry.textColor = UIColor.blackClr
            viewSuperBG.backgroundColor = UIColor.whitClr
            self.lblDec.isHidden = false
            self.lblStatus.isHidden = false
            self.lblInfoSummry.isHidden = false
        case "Failed":
            self.viewBG.clearGradient()
            self.stackData1.isHidden = true
            self.stackData2.isHidden = true
            self.btnMyOrder.isHidden = true
            self.btnBackTohome.isHidden = true
            self.btnRetryPayment.isHidden = false
            self.imgViewLogoBG.image = UIImage(named: "payment_failed")
            self.lblDec.text = "Transaction has been cancelled"
            self.lblStatus.text = "Payment processing!"
            lblOrderID.textColor = UIColor.themeClr
            lblAmount.textColor = UIColor.themeClr
            lblUTRCHequeNo.textColor = UIColor.themeClr
            lblPaymentMode.textColor = UIColor.themeClr
            lblDec.textColor = UIColor.themeClr
            lblHeadingOrderID.textColor = UIColor.themeClr
            lblHeadingAmount.textColor = UIColor.themeClr
            lblHeadingUTRCHequeNo.textColor = UIColor.themeClr
            lblHeadingPaymentMode.textColor = UIColor.themeClr
            lblStatus.textColor = UIColor.blackClr
            lblInfoSummry.textColor = UIColor.blackClr
            viewSuperBG.backgroundColor = UIColor.whitClr
            self.lblDec.isHidden = false
            self.lblStatus.isHidden = false
            self.lblInfoSummry.isHidden = true

        default:
            print(status)
        }
        
    }
   
    
    @IBAction func btnActionMyOrderBacktoHome(_ sender:UIButton){
       // self.navigationController?.popToRootViewController(animated: true)

        
        if sender.tag == 0{
        }
        else  if sender.tag == 1{
        }
        else{
//       self.navigationController?.popViewController(animated: true)
        }
        
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



class CenterGradientView: UIView {
    
    private var gradientLayer: CAGradientLayer?

       // Function to apply the gradient
       func applyCenterGradient(colors: [UIColor]) {
           // Clear any existing gradient
           clearGradient()

           // Create a new gradient layer
           let gradientLayer = CAGradientLayer()

           // Convert the UIColor array to CGColor array
           gradientLayer.colors = colors.map { $0.cgColor }

           // Set the gradient direction from top to bottom
           gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
           gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

           // Define the locations where colors should change (center is lighter)
           gradientLayer.locations = [0.0, 0.5, 1.0]

           // Store the gradient layer for later reference
           self.gradientLayer = gradientLayer

           // Add the gradient layer to the view's layer
           self.layer.insertSublayer(gradientLayer, at: 0)
       }

       override func layoutSubviews() {
           super.layoutSubviews()
           
           // Ensure the gradient layer covers the entire view
           gradientLayer?.frame = self.bounds
       }
    
    // Function to clear the gradient
    func clearGradient() {
        // Remove any existing gradient layer
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
    }
}
