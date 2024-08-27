//
//  GoldRateShareSheet.swift
//  DXE Price
//
//  Created by iOS Developer on 26/04/24.
//

import UIKit

struct GoldRatePrice: Codable{
    var kt24 : String?
    var kt22 : String?
    var kt18 : String?
    var kt14 : String?
    var kt9 : String?
}


class GoldRateShareSheet: UIViewController {
    
    @IBOutlet var lbl24k:UILabel!
    @IBOutlet var lbl22k:UILabel!
    @IBOutlet var lbl18k:UILabel!
    @IBOutlet var lbl14k:UILabel!
    @IBOutlet var lbl9k:UILabel!
    @IBOutlet var lblTodayDate:UILabel!
    
    @IBOutlet var btnShare:UIButton!
    @IBOutlet var btnCros:UIButton!
    @IBOutlet var infoBGView:UIView!


    var goldRatePrice = GoldRatePrice()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lbl24k.text = goldRatePrice.kt24
        self.lbl22k.text = goldRatePrice.kt22
        self.lbl18k.text = goldRatePrice.kt18
        self.lbl14k.text = goldRatePrice.kt14
        self.lbl9k.text = goldRatePrice.kt9
        self.getTodayDate()
    }
    
    
    func getTodayDate(){
        // Get today's date
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, MMM d, yyyy"
        let dateString = dateFormatter.string(from: today)
        self.lblTodayDate.text = "Gold Rate \(dateString)"
    }
    
    @IBAction func btnActionBack( _ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnActionShare( _ sender : UIButton){
        if let screenshot = takeScreenshot(of: infoBGView) {
            self.btnCros.isHidden = false
            self.btnShare.isHidden = false
            shareScreenshot(screenshot)
        } else {
            print("Failed to capture screenshot")
        }
    }
    
    func takeScreenshot(of view: UIView) -> UIImage? {
        self.btnCros.isHidden = true
        self.btnShare.isHidden = true
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
    }
    
    func shareScreenshot(_ image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    

}
