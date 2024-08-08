//
//  CommingSoonVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 06/08/24.
//

import UIKit

class CommingSoonVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
