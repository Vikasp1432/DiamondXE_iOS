//
//  AddShippingAddressVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 06/07/24.
//

import UIKit

class AddShippingAddressVC: BaseViewController {
    
    @IBOutlet var btnHomeTime:UIButton!
    @IBOutlet var btnOfficeTime:UIButton!
    @IBOutlet var btnVerify:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.btnVerify.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnHomeTime.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
    }
    

    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnActionTime(_ sender: UIButton){
        if sender.tag == 0{
            btnHomeTime.setTitleColor(.whitClr, for: .normal)
            btnOfficeTime.backgroundColor = .clear
            btnOfficeTime.setTitleColor(.tabSelectClr, for: .normal)
            btnOfficeTime.clearGradient()
            self.btnHomeTime.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        }
        else{
            
            btnHomeTime.backgroundColor = .clear
            btnHomeTime.setTitleColor(.tabSelectClr, for: .normal)
            btnOfficeTime.setTitleColor(.whitClr, for: .normal)
            btnHomeTime.clearGradient()
            self.btnOfficeTime.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            
        }
    }
    
    @IBAction func btnActionApply(_ sender: UIButton){
        self.navigationManager(storybordName: "ShippingModule", storyboardID: "ShippingModuleVC", controller: ShippingModuleVC())
    }
    
    
}
