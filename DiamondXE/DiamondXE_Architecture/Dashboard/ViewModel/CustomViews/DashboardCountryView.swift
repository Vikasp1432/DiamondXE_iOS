//
//  DashboardCountryView.swift
//  DiamondXE
//
//  Created by iOS Developer on 20/07/24.
//

import UIKit


protocol DashbordCountryPopupViewDelegate: AnyObject {
    func customViewButtonTapped(_ customView: DashboardCountryView, returnValue: String)
}

class DashboardCountryView: UIView {

    @IBOutlet weak var viewINR:UIView!
    @IBOutlet weak var viewUSD:UIView!
    @IBOutlet weak var viewEUR:UIView!
    @IBOutlet weak var viewGBP:UIView!
    @IBOutlet weak var viewAUD:UIView!
    @IBOutlet weak var viewCAD:UIView!
    @IBOutlet weak var viewNZD:UIView!
    @IBOutlet weak var viewSGD:UIView!
    @IBOutlet weak var viewAED:UIView!
    
    var delegate : DashbordCountryPopupViewDelegate?


    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("DashboardCountryView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewINR?.addGestureRecognizer(tap1)
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
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        if let tappedView = sender.view {
            switch tappedView.tag {
            case 0:
                self.delegate?.customViewButtonTapped(self, returnValue: "INR")
            case 1:
                self.delegate?.customViewButtonTapped(self, returnValue: "USD")
            case 2:
                self.delegate?.customViewButtonTapped(self, returnValue: "EUR")
            case 3:
                self.delegate?.customViewButtonTapped(self, returnValue: "GBD")
            case 4:
                self.delegate?.customViewButtonTapped(self, returnValue: "AUD")
            case 5:
                self.delegate?.customViewButtonTapped(self, returnValue: "CAD")
            case 6:
                self.delegate?.customViewButtonTapped(self, returnValue: "NZD")
            case 7:
                self.delegate?.customViewButtonTapped(self, returnValue: "SGD")
            case 8:
                self.delegate?.customViewButtonTapped(self, returnValue: "AED")
                
            default:
                print("Other view tapped")
                // Handle action for other views
            }
        }
    }
}
