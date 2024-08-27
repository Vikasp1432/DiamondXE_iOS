//
//  RingSizeShareSheet.swift
//  DXE Price
//
//  Created by iOS Developer on 16/04/24.
//

import UIKit

struct RingSizerInfo: Codable{
    var mm : String?
    var usa : String?
    var eur : String?
    var uk : String?
    var ind : String?
}

class RingSizeShareSheet: UIViewController {
    
    @IBOutlet var lblMM:UILabel!
    @IBOutlet var lblUSA:UILabel!
    @IBOutlet var lblEUR:UILabel!
    @IBOutlet var lblUK:UILabel!
    @IBOutlet var lblIND:UILabel!
    
    @IBOutlet var btnShare:UIButton!
    @IBOutlet var btnCros:UIButton!
    @IBOutlet var infoBGView:UIView!
    
    
    var ringSizerInfo = RingSizerInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.lblMM.text = ringSizerInfo.mm
        self.lblUSA.text = ringSizerInfo.usa
        self.lblEUR.text = ringSizerInfo.eur
        self.lblUK.text = ringSizerInfo.uk
        self.lblIND.text = ringSizerInfo.ind
        
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
