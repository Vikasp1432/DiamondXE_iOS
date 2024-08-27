//
//  QuotatiosVC.swift
//  DXE Price
//
//  Created by iOS Developer on 11/04/24.
//

import UIKit

class QuotatiosVC: UIViewController {
    
    // outlets
    @IBOutlet weak var lblDiamondType: UILabel!
    @IBOutlet weak var lblSolitairDNots: UILabel!
    @IBOutlet weak var lblSideDIADNots: UILabel!
    @IBOutlet weak var lblOtherChargesNots: UILabel!

    
    
    @IBOutlet weak var lblProducName: UILabel!
    @IBOutlet weak var lblPurity: UILabel!
    
    @IBOutlet weak var lblMetalWt : UILabel!
    @IBOutlet weak var lblMetalRatePG: UILabel!
    @IBOutlet weak var lblMetalTotalAmt: UILabel!
    
    @IBOutlet weak var lblLabour: UILabel!
    @IBOutlet weak var lblLabourRatePG: UILabel!
    @IBOutlet weak var lblLabourTotalAmt: UILabel!
    
    @IBOutlet weak var lblSolitairWt: UILabel!
    @IBOutlet weak var lblSolitairRatePC: UILabel!
    @IBOutlet weak var lblSolitairTatoalAmt: UILabel!
    
    @IBOutlet weak var lblSideDIA: UILabel!
    @IBOutlet weak var lblSideDIARatePC: UILabel!
    @IBOutlet weak var lblSideDIATotalAmt: UILabel!
    
    @IBOutlet weak var lblColStoneWt: UILabel!
    @IBOutlet weak var lblColStoneWtPC: UILabel!
    @IBOutlet weak var lblColStoneTotalAmt: UILabel!
    
    @IBOutlet weak var lblExtraCharges: UILabel!
    @IBOutlet weak var lblTaxCharges: UILabel!
    @IBOutlet weak var lblTaxCalculation: UILabel!
    
    
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var viewNotes: UIView!
    @IBOutlet weak var viewTopbar: UIView!
    @IBOutlet weak var viewBGHeading:UIView!
    @IBOutlet weak var viewTopbarLayout: NSLayoutConstraint!
    
    

    //Var of txtFields
    let calculation = Calculation()
    
    var metalwt = Double()
    var metalRatePGm = Double()
    var metalwtTotal = Double()
    
    var labourChar = Double()
    var labourCharRatePGm = Double()
    var labourCharTotal = Double()
    
    var solitairwt = Double()
    var solitairRatePCt = Double()
    var solitairTotal = Double()
    
    var sideDIA = Double()
    var sideDIARatePCt = Double()
    var sideDIATotal = Double()
    
    var colStoneWt = Double()
    var colStonePCt = Double()
    var colStoneTotal = Double()
    
    var extraCharges = Double()
    var taxCharges = Double()
    var taxCalculation = Double()
    var currncyVal  = Double()
    var currencyType  = String()
    
    var natualOrLabGrown = String()
    var solitaierNotes = String()
    var sideDiaNotes = String()
    var otherCharges = String()
    var productName = String()
    var purityType = String()
    
    var grandTotal = String()
    var priceWitCurr = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setData()
        self.view.CalcaddShadow(view: viewNotes)
        self.view.CalcaddShadow(view: viewTable)
        viewBGHeading.layer.cornerRadius = 18
        viewBGHeading.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

    }
    
    @IBAction func btnActionBack(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionShareScreenshots(_ sender : UIButton){
        if let screenshot = takeScreenshot() {
            self.viewTopbar.isHidden = false
            self.viewTopbarLayout.constant = 40
            // Save the screenshot to the photo library
            UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
            // Share the saved screenshot via WhatsApp
            shareImageViaWhatsApp(image: screenshot)
        }
    }
    
    func takeScreenshot() -> UIImage? {
        self.viewTopbar.isHidden = true
        self.viewTopbarLayout.constant = 0
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot
    }
    
    func shareImageViaWhatsApp(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // Check if WhatsApp is installed
        if let whatsappURL = URL(string: "whatsapp://") {
            if UIApplication.shared.canOpenURL(whatsappURL) {
                activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
            }
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    // set Data
    func setData(){
        
        self.lblDiamondType.text = "\(natualOrLabGrown)"
        self.lblSolitairDNots.text = "Solitaire: \(solitaierNotes)"
        self.lblSideDIADNots.text = "Side DIA: \(sideDiaNotes)"
        self.lblOtherChargesNots.text = "Other Charges: \(otherCharges)"
        
        
        self.lblProducName.text = productName
        self.lblPurity.text = purityType
        
        self.lblMetalWt.text = "\(calculation.decimalManage(value: self.metalwt))gm"
        self.lblMetalRatePG.text = calculation.decimalManage(value: self.metalRatePGm)
       // self.lblMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)
        let roundOffPriceMatel = calculation.decimalRoundOf(value: self.metalwtTotal)
        self.lblMetalTotalAmt.text = calculation.totalPriceFormatter(value: Double(roundOffPriceMatel) ?? 0)
        
        self.lblLabour.text = "\(calculation.decimalManage(value: self.labourChar))gm"
        self.lblLabourRatePG.text = calculation.decimalManage(value: self.labourCharRatePGm)
       // self.lblLabourTotalAmt.text = calculation.decimalRoundOf(value: self.labourCharTotal)
        
        let roundOffPriceLabour = calculation.decimalRoundOf(value: self.labourCharTotal)
        self.lblLabourTotalAmt.text = calculation.totalPriceFormatter(value: Double(roundOffPriceLabour) ?? 0)
        
        
        self.lblSolitairWt.text = "\(calculation.decimalManage(value: self.solitairwt))ct"
        self.lblSolitairRatePC.text = calculation.decimalManage(value: self.solitairRatePCt)
        //self.lblSolitairTatoalAmt.text = calculation.decimalRoundOf(value: self.solitairTotal)
        
        let roundOffPriceSolitair = calculation.decimalRoundOf(value: self.solitairTotal)
        self.lblSolitairTatoalAmt.text = calculation.totalPriceFormatter(value: Double(roundOffPriceSolitair) ?? 0)
        
        self.lblSideDIA.text = "\(calculation.decimalManage(value: self.sideDIA))ct"
        self.lblSideDIARatePC.text = calculation.decimalManage(value: self.sideDIARatePCt)
        //self.lblSideDIATotalAmt.text = calculation.decimalRoundOf(value: self.sideDIATotal)
        
        let roundOffPriceSideDia = calculation.decimalRoundOf(value: self.sideDIATotal)
        self.lblSideDIATotalAmt.text = calculation.totalPriceFormatter(value: Double(roundOffPriceSideDia) ?? 0)
        
        self.lblColStoneWt.text = "\(calculation.decimalManage(value: self.colStoneWt))ct"
        self.lblColStoneWtPC.text = calculation.decimalManage(value: self.colStonePCt)
        //self.lblColStoneTotalAmt.text = calculation.decimalRoundOf(value: self.colStoneTotal)
        
        let roundOffPriceColStone = calculation.decimalRoundOf(value: self.colStoneTotal)
        self.lblColStoneTotalAmt.text = calculation.totalPriceFormatter(value: Double(roundOffPriceColStone) ?? 0)
        
        self.lblExtraCharges.text = calculation.totalPriceFormatter(value: Double(self.extraCharges))//"\(self.extraCharges)"
        self.lblTaxCharges.text = "\(self.taxCharges)"
        
        let roundOffPriceTaxCalcu = calculation.decimalRoundOf(value: self.taxCalculation)
        self.lblTaxCalculation.text = calculation.totalPriceFormatter(value: Double(roundOffPriceTaxCalcu) ?? 0)//"\(self.taxCalculation)"
        
        
        self.lblGrandTotal.text = self.grandTotal
        self.lblCurrency.text = "\(self.priceWitCurr)*"
    }
    
    
    
    
}
