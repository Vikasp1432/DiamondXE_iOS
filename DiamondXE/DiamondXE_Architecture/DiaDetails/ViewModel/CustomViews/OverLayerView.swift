//
//  OverLayerView.swift
//  CustomPopUp
//
//  Created by Sajjad Sarkoobi on 8.07.2022.
//

import UIKit
import AVKit
import AVFoundation
import WebKit

class OverLayerView: UIViewController {

    //IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
    @IBOutlet var bgView : UIView!
    @IBOutlet var imgDiamond : UIImageView!
    @IBOutlet var iblTitle : UILabel!
    
    
//    private var player: AVPlayer?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    private var htmlWebView: HTMLWebView!

    
    init() {
        super.init(nibName: "OverLayerView", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        playerLayer?.frame = bgView.bounds
        setupHTMLWebView()

    }
    
    private func setupHTMLWebView() {
           htmlWebView = HTMLWebView(frame: bgView.bounds)
           htmlWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgView.addSubview(htmlWebView)
       }
    
  
    private func playVideo(url:String) {
           // Ensure the URL is valid
           guard let videoURL = URL(string: url) else {
               print("Invalid URL")
               return
           }

           // Create an AVPlayer instance
           player = AVPlayer(url: videoURL)

           // Create an AVPlayerLayer instance
           playerLayer = AVPlayerLayer(player: player)
           playerLayer?.frame = bgView.bounds
           playerLayer?.videoGravity = .resizeAspectFill

           // Add the player layer to the view's layer
           if let playerLayer = playerLayer {
               bgView.layer.addSublayer(playerLayer)
           }

           // Start playback
           player?.play()
       }
    
    @IBAction func btnActionShare(_ sender : UIButton){
//        guard let image = bgView.image else {
//                   print("Image not found!")
//                   return
//               }
//               
//               guard let jpegData = image.jpegData(compressionQuality: 1.0) else {
//                   print("Failed to convert image to JPEG")
//                   return
//               }
//               
//               let activityViewController = UIActivityViewController(activityItems: [jpegData], applicationActivities: nil)
//               
//               // For iPad, you need to specify the source view.
//               activityViewController.popoverPresentationController?.sourceView = self.view
//               
//               // Present the view controller
//               self.present(activityViewController, animated: true, completion: nil)
        
        let bounds = bgView.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        bgView.drawHierarchy(in: bounds, afterScreenUpdates: false)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        
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
            self.show()
            switch tag {
            case 0:
                self.imgDiamond.isHidden = true
                self.iblTitle.text = "Diamond Image"
                self.htmlWebView.loadURL(url)
                //self.imgDiamond.sd_setImage(with: URL(string:  url), placeholderImage: UIImage(named: "place_Holder"))
            case 1:
                self.imgDiamond.isHidden = true
                self.iblTitle.text = "Diamond Video"
//                self.playVideo(url:url)
                self.htmlWebView.loadURL(url)

            default:
                print("")
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


class HTMLWebView: UIView {
    private var webView: WKWebView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWebView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupWebView()
    }

    private func setupWebView() {
        webView = WKWebView(frame: self.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(webView)
    }

    func loadURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string.")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
