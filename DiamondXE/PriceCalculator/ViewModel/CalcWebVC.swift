//
//  CalcWebVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/08/24.
//

import UIKit
import WebKit

class CalcWebVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var lblHeadingName : UILabel!
    @IBOutlet var webView : WKWebView!
    var activityView: UIActivityIndicatorView?

    var heading = String()
    var urlStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showActivityIndicator()
        self.lblHeadingName.text = heading
        webView.navigationDelegate = self
        let url = URL(string: urlStr)
        webView.load(URLRequest(url: url!))
    }
    
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }

    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }

    //Equivalent of shouldStartLoadWithRequest:
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            var action: WKNavigationActionPolicy?

            defer {
                decisionHandler(action ?? .allow)
            }

            guard let url = navigationAction.request.url else { return }
            print("decidePolicyFor - url: \(url)")

            //Uncomment below code if you want to open URL in safari
            /*
            if navigationAction.navigationType == .linkActivated, url.absoluteString.hasPrefix("https://developer.apple.com/") {
                action = .cancel  // Stop in WebView
                UIApplication.shared.open(url)
            }
            */
        }

        //Equivalent of webViewDidStartLoad:
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("didStartProvisionalNavigation - webView.url: \(String(describing: webView.url?.description))")
           
        }

        //Equivalent of didFailLoadWithError:
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            let nserror = error as NSError
            if nserror.code != NSURLErrorCancelled {
                webView.loadHTMLString("Page Not Found", baseURL: URL(string: "https://developer.apple.com/"))
            }
        }

        //Equivalent of webViewDidFinishLoad:
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("didFinish - webView.url: \(String(describing: webView.url?.description))")
            hideActivityIndicator()
        }
}
