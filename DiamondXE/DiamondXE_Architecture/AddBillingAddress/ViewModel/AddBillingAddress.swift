//
//  AddBillingAddress.swift
//  DiamondXE
//
//  Created by iOS Developer on 06/07/24.
//

import UIKit

class AddBillingAddress: BaseViewController {
    
    
    @IBOutlet var btnVerify:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.btnVerify.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActionApply(_ sender: UIButton){
        self.navigationManager(storybordName: "ShippingAddress", storyboardID: "AddShippingAddressVC", controller: AddShippingAddressVC())
    }
    

}
