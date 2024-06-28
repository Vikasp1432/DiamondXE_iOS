//
//  SelectCountryView.swift
//  DiamondXE
//
//  Created by iOS Developer on 25/06/24.
//

import Foundation
import UIKit

protocol SelectCountryViewDelegate: AnyObject {
    func customViewButtonTapped(_ customView: SelectCountryView, returnValue: String)
}

class SelectCountryView: UIView{
    
    @IBOutlet weak var viewInd:UIView!
    @IBOutlet weak var viewUSD:UIView!
    @IBOutlet weak var viewEUR:UIView!
    @IBOutlet weak var viewGBP:UIView!
    @IBOutlet weak var viewAUD:UIView!
    @IBOutlet weak var viewCAD:UIView!
    @IBOutlet weak var viewNZD:UIView!
    @IBOutlet weak var viewSGD:UIView!
    @IBOutlet weak var viewAED:UIView!
    
    @IBOutlet weak var viewSelected:UIView!
    @IBOutlet weak var dropDown:UIButton!
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblSubTitle:UILabel!
    @IBOutlet weak var btnFlag:UIButton!
    
    @IBOutlet weak var viewData:UIView!
    
    var selectedIndex = String()
    var delegate : SelectCountryViewDelegate?
    
    var isViewExpand = false
    
    var setDataArr = ["INR":"Indian Rupees","USD":"US Dollar","EUR":"EURO","GBP":"British Pound Streling","AUD":"Australian Dollar","CAD":"Canadian Dollar","NZD":"New Zealand Dollar","SGD":"Singapore Dollar","AED":"United Arab Emirates Dirham"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){

        let bundle = Bundle(for: type(of: self))
                let nib = UINib(nibName: "SelectCountryView", bundle: bundle)
                guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
                view.frame = self.bounds
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.addSubview(view)

                // Set compression resistance and hugging priority
                view.setContentHuggingPriority(.defaultHigh, for: .vertical)
                view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        viewSelected.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewSelected.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewSelected.layer.shadowRadius = 2.0
        viewSelected.layer.shadowOpacity = 0.4
        viewSelected.layer.masksToBounds = false
 
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewInd?.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewUSD?.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewEUR?.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewGBP?.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewAUD?.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewCAD?.addGestureRecognizer(tap6)
        
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewNZD?.addGestureRecognizer(tap7)
        
        let tap8 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewSGD?.addGestureRecognizer(tap8)
        
        let tap9 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewAED?.addGestureRecognizer(tap9)
        
        let tap11 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewSelected?.addGestureRecognizer(tap11)
        
      
        
    }
    
    func setupData() {
        switch self.lblTitle.text {
        case "INR":
            viewInd.isHidden = true
            viewUSD.isHidden = false
            viewEUR.isHidden = false
            viewGBP.isHidden = false
            viewAUD.isHidden = false
            viewCAD.isHidden = false
            viewNZD.isHidden = false
            viewSGD.isHidden = false
            viewAED.isHidden = false
           
        case "USD":
            
            viewInd.isHidden = false
            viewUSD.isHidden = true
            viewEUR.isHidden = false
            viewGBP.isHidden = false
            viewAUD.isHidden = false
            viewCAD.isHidden = false
            viewNZD.isHidden = false
            viewSGD.isHidden = false
            viewAED.isHidden = false

        case "EUR":
            // Handle action for View 2
            viewInd.isHidden = false
            viewUSD.isHidden = false
            viewEUR.isHidden = true
            viewGBP.isHidden = false
            viewAUD.isHidden = false
            viewCAD.isHidden = false
            viewNZD.isHidden = false
            viewSGD.isHidden = false
            viewAED.isHidden = false

        case "GBP":

            viewInd.isHidden = false
            viewUSD.isHidden = false
            viewEUR.isHidden = false
            viewGBP.isHidden = true
            viewAUD.isHidden = false
            viewCAD.isHidden = false
            viewNZD.isHidden = false
            viewSGD.isHidden = false
            viewAED.isHidden = false

        case "AUD":

            viewInd.isHidden = false
            viewUSD.isHidden = false
            viewEUR.isHidden = false
            viewGBP.isHidden = false
            viewAUD.isHidden = true
            viewCAD.isHidden = false
            viewNZD.isHidden = false
            viewSGD.isHidden = false
            viewAED.isHidden = false

        case "CAD":
  
            viewInd.isHidden = false
            viewUSD.isHidden = false
            viewEUR.isHidden = false
            viewGBP.isHidden = false
            viewAUD.isHidden = false
            viewCAD.isHidden = true
            viewNZD.isHidden = false
            viewSGD.isHidden = false
            viewAED.isHidden = false

        case "NZD":
           
            viewInd.isHidden = false
            viewUSD.isHidden = false
            viewEUR.isHidden = false
            viewGBP.isHidden = false
            viewAUD.isHidden = false
            viewCAD.isHidden = false
            viewNZD.isHidden = true
            viewSGD.isHidden = false
            viewAED.isHidden = false

        case "SGD":

            viewInd.isHidden = false
            viewUSD.isHidden = false
            viewEUR.isHidden = false
            viewGBP.isHidden = false
            viewAUD.isHidden = false
            viewCAD.isHidden = false
            viewNZD.isHidden = false
            viewSGD.isHidden = true
            viewAED.isHidden = false
           
        case "AED":
    
            viewInd.isHidden = false
            viewUSD.isHidden = false
            viewEUR.isHidden = false
            viewGBP.isHidden = false
            viewAUD.isHidden = false
            viewCAD.isHidden = false
            viewNZD.isHidden = false
            viewSGD.isHidden = false
            viewAED.isHidden = true
          
        default:
            print("Other view tapped")
            // Handle action for other views
        }
        
        
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
           if let tappedView = sender.view {
               switch tappedView.tag {
               case 0:
                   viewInd.isHidden = true
                   viewUSD.isHidden = false
                   viewEUR.isHidden = false
                   viewGBP.isHidden = false
                   viewAUD.isHidden = false
                   viewCAD.isHidden = false
                   viewNZD.isHidden = false
                   viewSGD.isHidden = false
                   viewAED.isHidden = false
                   self.btnFlag.setImage(UIImage(named: "inr"), for: .normal)
                   self.lblTitle.text = "INR"
                   self.lblSubTitle.text = "Indian Rupees"
                   self.delegate?.customViewButtonTapped(self, returnValue: "INR")
               case 1:
                   
                   viewInd.isHidden = false
                   viewUSD.isHidden = true
                   viewEUR.isHidden = false
                   viewGBP.isHidden = false
                   viewAUD.isHidden = false
                   viewCAD.isHidden = false
                   viewNZD.isHidden = false
                   viewSGD.isHidden = false
                   viewAED.isHidden = false
                   self.btnFlag.setImage(UIImage(named: "usd"), for: .normal)
                   
                   self.lblTitle.text = "USD"
                   self.lblSubTitle.text = "US Dollar"
                   self.delegate?.customViewButtonTapped(self, returnValue: "USD")
               case 2:
                   print("View 2 tapped")
                   // Handle action for View 2
                   viewInd.isHidden = false
                   viewUSD.isHidden = false
                   viewEUR.isHidden = true
                   viewGBP.isHidden = false
                   viewAUD.isHidden = false
                   viewCAD.isHidden = false
                   viewNZD.isHidden = false
                   viewSGD.isHidden = false
                   viewAED.isHidden = false
                   self.btnFlag.setImage(UIImage(named: "eur"), for: .normal)
                 
                   self.lblTitle.text = "EUR"
                   self.lblSubTitle.text = "EURO"
                   self.delegate?.customViewButtonTapped(self, returnValue: "EUR")
               case 3:
                   print("View 1 tapped")
                   // Handle action for View 1
                   viewInd.isHidden = false
                   viewUSD.isHidden = false
                   viewEUR.isHidden = false
                   viewGBP.isHidden = true
                   viewAUD.isHidden = false
                   viewCAD.isHidden = false
                   viewNZD.isHidden = false
                   viewSGD.isHidden = false
                   viewAED.isHidden = false
                   self.btnFlag.setImage(UIImage(named: "gbp"), for: .normal)
                   
                   self.lblTitle.text = "GBP"
                   self.lblSubTitle.text = "British Pound Streling"
                   self.delegate?.customViewButtonTapped(self, returnValue: "GBP")
               case 4:
                   print("View 2 tapped")
                   // Handle action for View 2
                   viewInd.isHidden = false
                   viewUSD.isHidden = false
                   viewEUR.isHidden = false
                   viewGBP.isHidden = false
                   viewAUD.isHidden = true
                   viewCAD.isHidden = false
                   viewNZD.isHidden = false
                   viewSGD.isHidden = false
                   viewAED.isHidden = false
                   self.btnFlag.setImage(UIImage(named: "aud"), for: .normal)
                   
                   self.lblTitle.text = "AUD"
                   self.lblSubTitle.text = "Australian Dollar"
                   self.delegate?.customViewButtonTapped(self, returnValue: "AUD")
               case 5:
                   print("View 1 tapped")
                   // Handle action for View 1
                   viewInd.isHidden = false
                   viewUSD.isHidden = false
                   viewEUR.isHidden = false
                   viewGBP.isHidden = false
                   viewAUD.isHidden = false
                   viewCAD.isHidden = true
                   viewNZD.isHidden = false
                   viewSGD.isHidden = false
                   viewAED.isHidden = false
                   self.btnFlag.setImage(UIImage(named: "cad"), for: .normal)
                   
                   self.lblTitle.text = "CAD"
                   self.lblSubTitle.text = "Canadian Dollar"
                   self.delegate?.customViewButtonTapped(self, returnValue: "CAD")
               case 6:
                   print("View 2 tapped")
                   // Handle action for View 2
                   viewInd.isHidden = false
                   viewUSD.isHidden = false
                   viewEUR.isHidden = false
                   viewGBP.isHidden = false
                   viewAUD.isHidden = false
                   viewCAD.isHidden = false
                   viewNZD.isHidden = true
                   viewSGD.isHidden = false
                   viewAED.isHidden = false
                   self.btnFlag.setImage(UIImage(named: "nzd"), for: .normal)
                   
                   self.lblTitle.text = "NZD"
                   self.lblSubTitle.text = "New Zealand Dollar"
                   self.delegate?.customViewButtonTapped(self, returnValue: "NZD")
               case 7:
                   print("View 1 tapped")
                   // Handle action for View 1
                   viewInd.isHidden = false
                   viewUSD.isHidden = false
                   viewEUR.isHidden = false
                   viewGBP.isHidden = false
                   viewAUD.isHidden = false
                   viewCAD.isHidden = false
                   viewNZD.isHidden = false
                   viewSGD.isHidden = true
                   viewAED.isHidden = false
                   self.btnFlag.setImage(UIImage(named: "sgd"), for: .normal)
                   
                   self.lblTitle.text = "SGD"
                   self.lblSubTitle.text = "Singapore Dollar"
                   self.delegate?.customViewButtonTapped(self, returnValue: "SGD")
               case 8:
                   print("View 2 tapped")
                   // Handle action for View 2
                   viewInd.isHidden = false
                   viewUSD.isHidden = false
                   viewEUR.isHidden = false
                   viewGBP.isHidden = false
                   viewAUD.isHidden = false
                   viewCAD.isHidden = false
                   viewNZD.isHidden = false
                   viewSGD.isHidden = false
                   viewAED.isHidden = true
                   self.btnFlag.setImage(UIImage(named: "aed"), for: .normal)
                  
                   self.lblTitle.text = "AED"
                   self.lblSubTitle.text = "United Arab Emirates Dirham"
                   self.delegate?.customViewButtonTapped(self, returnValue: "AED")
               case 11:
                   isViewExpand.toggle()
                   if isViewExpand{
                       viewInd.isHidden = true
                       viewUSD.isHidden = false
                       viewEUR.isHidden = false
                       viewGBP.isHidden = false
                       viewAUD.isHidden = false
                       viewCAD.isHidden = false
                       viewNZD.isHidden = false
                       viewSGD.isHidden = false
                       viewAED.isHidden = false
                       self.delegate?.customViewButtonTapped(self, returnValue: "isExpand")
                       self.dropDown.setImage(UIImage(named: "Drop_Up"), for: .normal)

                   }
                   else{
                       viewInd.isHidden = true
                       viewUSD.isHidden = true
                       viewEUR.isHidden = true
                       viewGBP.isHidden = true
                       viewAUD.isHidden = true
                       viewCAD.isHidden = true
                       viewNZD.isHidden = true
                       viewSGD.isHidden = true
                       viewAED.isHidden = true
                       self.delegate?.customViewButtonTapped(self, returnValue: "None")
                       self.dropDown.setImage(UIImage(named: "Sub Bar Icon"), for: .normal)
                   }
                  
               default:
                   print("Other view tapped")
                   // Handle action for other views
               }
           }
       }
    
    @IBAction func btnActionView(_ sender : UIButton){
        print("Some")
    }
 
    
    @IBAction func btnactionCallEnquiry(_ sender : UIButton){
        print("Some")
    }
    
}
