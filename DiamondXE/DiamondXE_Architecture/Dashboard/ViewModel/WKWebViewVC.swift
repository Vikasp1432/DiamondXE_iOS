//
//  WKWebViewVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/05/24.
//

import UIKit
import WebKit


class WKWebViewVC: BaseViewController , DataReceiver{
    var vcTag =  VCTags()
    
    
    func receiveData(_ data: VCTags) {
        // Use the received data here
        vcTag = data
    }
    
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
        var url : URL?
        switch vcTag.tagVC {
        case 0:
            url = URL(string:APIs().supplierWebLogin)
        case 1:
            url = URL(string:SideBarURLs().diamondEducation)
        case 2:
            url = URL(string:SideBarURLs().ForJeweller)
        case 3:
            url = URL(string:SideBarURLs().forSupplier)
        case 4:
            url = URL(string:SideBarURLs().aboutUs)
        case 5:
            url = URL(string:SideBarURLs().whyUs)
        case 6:
            url = URL(string:SideBarURLs().blogs)
        case 7:
            url = URL(string:SideBarURLs().mediaGallery)
        case 8:
            url = URL(string:SideBarURLs().support)
        case 9:
            url = URL(string:SideBarURLs().termsConditions)
        case 10:
            url = URL(string:SideBarURLs().privacyPolicy)
        case 11:
            url = URL(string:SideBarURLs().rateUs)
        case 12:
            url = URL(string:SideBarURLs().Instagram)
           
        case 13:
            url = URL(string:SideBarURLs().Facebook)
        case 14:
            url = URL(string:SideBarURLs().LinkedIn)
        case 15:
            url = URL(string:SideBarURLs().YouTube)
            
        case 16:
            url = URL(string:SideBarURLs().economicTimes)
        case 17:
            url = URL(string:SideBarURLs().retailJeweller)
        case 18:
            url = URL(string:SideBarURLs().midday)
        case 19:
            url = URL(string:SideBarURLs().viewALL)
        case 20:
            url = URL(string:SideBarURLs().termandCondition)
        default:
            print(vcTag.tagVC)
        }
        
        //let web_url = url
        let web_request = URLRequest(url: url!)
        wkWebview.load(web_request)
    }

}
