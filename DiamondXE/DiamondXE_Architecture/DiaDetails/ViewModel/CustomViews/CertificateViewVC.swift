//
//  CertificateViewVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/06/24.
//

import UIKit
import WebKit

class CertificateViewVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblNoCertificateFound: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
    @IBOutlet var wkWebview:WKWebView!

    
  
    init() {
        super.init(nibName: "CertificateViewVC", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
     
    }
    
   
  
    
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController, tag:Int, url:String) {
        sender.present(self, animated: false) {
            
            if  url.isEmpty{
                self.lblNoCertificateFound.isHidden = false
                self.wkWebview.isHidden = true
            }
            else{
                self.lblNoCertificateFound.isHidden = true
                self.wkWebview.isHidden = false
            }
            self.show()
            let urlA = URL(string: url)
            if let url = urlA{
                let web_request = URLRequest(url: url)
                self.wkWebview.load(web_request)
            }
           
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




