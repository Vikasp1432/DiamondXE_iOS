//
//  WKWebViewVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/05/24.
//

import UIKit
import WebKit


class WKWebViewVC: UIViewController {
    
    @IBOutlet var wkWebview:WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        loadURL()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    func loadURL(){
        let web_url = URL(string:APIs().supplierWebLogin)!
        let web_request = URLRequest(url: web_url)
        wkWebview.load(web_request)
    }

}
