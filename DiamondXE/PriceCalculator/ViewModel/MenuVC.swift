//
//  MenuVC.swift
//  DXE Calc
//
//  Created by Genie Talk on 01/03/23.
//

import UIKit

class MenuVC: UIViewController, BottomSheetActionDelegate, UITextFieldDelegate {
    
    func bottomSheetDelegate(userID: String, userIDPass: String, actionTag: Int) {
        print(userID)
        print(userIDPass)
    }
    
    var currncyVal  = Double()
    var currencyType  = String()
    var currencyVCDelegate : CurrencyVCDelegate?
    var switchButtonDelegate : MenuVCSwitchCaseDelegate?
    var switchButtonState = Bool()

    var metalRateVal  = Double()
    var labourChrVal  = Double()
    var extraChrVal  = Double()
    var taxVal  = Double()
    let calculation = Calculation()

    
    var rate22K = 91.6
    var rate18K = 75
    var rate9K = 37.5
    var rate14K = 58.3
    var goldRatePrice = GoldRatePrice()


    
    
    @IBOutlet weak var switch10CT: UISwitch!
    @IBOutlet weak var btnSave: UIButton!

    @IBOutlet weak var txtMetalRate: UITextField!
    @IBOutlet weak var txtLabour: UITextField!
    @IBOutlet weak var txtExtCharges: UITextField!
    @IBOutlet weak var txtTax: UITextField!
    @IBOutlet weak var lblAppVersion: UILabel!

    @IBOutlet weak var txt22K: UITextField!
    @IBOutlet weak var txt18K: UITextField!
    @IBOutlet weak var txt09K: UITextField!
    @IBOutlet weak var txt14K: UITextField!
    
    @IBOutlet weak var lblCalcu22k: UILabel!
    @IBOutlet weak var lblCalcu18k: UILabel!
    @IBOutlet weak var lblCalcu14k: UILabel!
    @IBOutlet weak var lblCalcu9k: UILabel!
    @IBOutlet weak var lblBaseCurrency: UILabel!

    @IBOutlet weak var viewQuatation: UIView!
    
    var set22KValue  = Double()
    var set18KValue  = Double()
    var set9KValue = Double()
    var set14KValue = Double()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch10CT.isOn = switchButtonState
        
        self.txtMetalRate.delegate = self
        self.txtLabour.delegate = self
        self.txtExtCharges.delegate = self
        self.txtTax.delegate = self
        self.txt22K.delegate = self
        self.txt18K.delegate = self
        self.txt09K.delegate = self
        self.txt14K.delegate = self
        setDefaultValue()
        appVersion()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        viewQuatation.isUserInteractionEnabled = true
        viewQuatation.addGestureRecognizer(tapGesture)

        
    }
    
    @objc func viewTapped() {
        let vc = UIStoryboard(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuatationHistoryVC") as? QuatationHistoryVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnActionQutnHistory(_ sender: UIButton){
        let vc = UIStoryboard(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuatationHistoryVC") as? QuatationHistoryVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func appVersion(){
        // Get the app version from the Info.plist file
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            // Update the UILabel text with the app version
            lblAppVersion.text = "Version: \(appVersion)"
        } else {
            // Unable to retrieve app version
            lblAppVersion.text = "Version: N/A"
        }
    }
    
    
    @IBAction func btnActionShareSheetGoldRate(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "DXECalc", bundle: nil)
                let alertSheet = storyboard.instantiateViewController(withIdentifier: "GoldRateShareSheet") as? GoldRateShareSheet
        alertSheet?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.getPriceCal()
        alertSheet?.goldRatePrice = self.goldRatePrice
        alertSheet?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertSheet!, animated: true, completion: nil)
    }
    
    func getPriceCal(){
        self.goldRatePrice.kt24 = "\(self.calculation.totalPriceFormatter(value: self.metalRateVal))"
        self.goldRatePrice.kt22 = self.lblCalcu22k.text ?? ""
        self.goldRatePrice.kt18 = self.lblCalcu18k.text ?? ""
        self.goldRatePrice.kt14 = self.lblCalcu14k.text ?? ""
        self.goldRatePrice.kt9 = self.lblCalcu9k.text ?? ""
    }
    
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
            if sender.isOn {
                switchButtonDelegate?.isSwitch(isPriceWith10Ct: true)
            } else {
                switchButtonDelegate?.isSwitch(isPriceWith10Ct: false)
            }
        }
    
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.currencyVCDelegate?.getCurrency(currencyType: self.currencyType, currencyVal: self.currncyVal)
        self.navigationController?.popViewController(animated: true)
    }
    
    func setDefaultValue(){
        self.metalRateVal = CalcUserDefaultManager().getMetalRateValue()
        self.labourChrVal = CalcUserDefaultManager().getLabourChargesValueValue()
        self.extraChrVal = CalcUserDefaultManager().getExtChargesValue()
        self.taxVal = CalcUserDefaultManager().getTaxValue()
        
        self.txtMetalRate.text = "\(metalRateVal)"
        self.txtLabour.text = "\(labourChrVal)"

        self.txtExtCharges.text = "\(extraChrVal)"
        self.txtTax.text = "\(taxVal)"
        
        if let ct22K = CalcUserDefaultManager().get22KValue() {
            if ct22K > 0{
                rate22K = ct22K
            }
        }
        if let ct18K = CalcUserDefaultManager().get18KValue(){
            if ct18K > 0{
                rate18K = Int(ct18K)
            }
            
        }
        if let ct9K = CalcUserDefaultManager().get9KValue(){
            if ct9K > 0{
                rate9K = ct9K
            }
            
        }
        if  let ct14K = CalcUserDefaultManager().get14KValue(){
            
            if ct14K > 0{
                rate14K = ct14K
            }
        }
        
        self.txt22K.text = "\(rate22K)"
        self.txt18K.text = "\(rate18K)"

        self.txt09K.text = "\(rate9K)"
        self.txt14K.text = "\(rate14K)"
        
        self.lblBaseCurrency.text = CalcUserDefaultManager().getCurrencyType()
        
        self.goldRateCalcu()

    }
    
    
    func goldRateCalcu(){
        let purity22k = self.calculation.calculatePercentage(value: self.metalRateVal, percentageVal: rate22K)
        self.lblCalcu22k.text = self.calculation.totalPriceFormatter(value: purity22k)
        
        let purity18k = self.calculation.calculatePercentage(value: self.metalRateVal, percentageVal: Double(rate18K))
        self.lblCalcu18k.text = self.calculation.totalPriceFormatter(value: purity18k)
        
        let purity14k = self.calculation.calculatePercentage(value: self.metalRateVal, percentageVal: rate14K)
        self.lblCalcu14k.text = self.calculation.totalPriceFormatter(value: purity14k)
        
        let purity9k = self.calculation.calculatePercentage(value: self.metalRateVal, percentageVal: rate9K)
        self.lblCalcu9k.text = self.calculation.totalPriceFormatter(value: purity9k)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //   print("While entering the characters this method gets called")
        
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        
        if textField.tag == 1{
            if newString == "" {
                self.metalRateVal = 0            }
            else{
                if newString != "0" {
                    self.metalRateVal = Double(newString as String) ?? 0.0
                    self.goldRateCalcu()
                }
            }
            
        }
        else if textField.tag == 2{
            if newString == "" {
                self.labourChrVal = 0            }
            else{
                if newString != "0" {
                    self.labourChrVal = Double(newString as String) ?? 0.0
                }
            }
        }
        
        else if textField.tag == 3{
            if newString == "" {
                self.extraChrVal = 0            }
            else{
                if newString != "0" {
                    self.extraChrVal = Double(newString as String) ?? 0.0
                }
            }
        }
        else if textField.tag == 4{
            if newString == "" {
                self.taxVal = 0            }
            else{
                if newString != "0" {
                    self.taxVal = Double(newString as String) ?? 0.0
                }
            }
        }
        
        
        else if textField.tag == 5{
            if newString == "" {
                self.set22KValue = 0
            }
            else{
                if newString != "0" {
                    self.set22KValue = Double(newString as String) ?? 0.0
                    let purity22k = self.calculation.calculatePercentage(value: self.metalRateVal, percentageVal: set22KValue)
                    self.lblCalcu22k.text = self.calculation.totalPriceFormatter(value: purity22k)
                }
            }
        }
        
        else if textField.tag == 6{
            if newString == "" {
                self.set18KValue = 0      
            }
            else{
                if newString != "0" {
                    self.set18KValue = Double(newString as String) ?? 0.0
                    let purity18k = self.calculation.calculatePercentage(value: self.metalRateVal, percentageVal: set18KValue)
                    self.lblCalcu18k.text = self.calculation.totalPriceFormatter(value: purity18k)
                }
            }
        }
        
        else if textField.tag == 7{
            if newString == "" {
                self.set14KValue = 0
            }
            else{
                if newString != "0" {
                    self.set14KValue = Double(newString as String) ?? 0.0
                    let purity14k = self.calculation.calculatePercentage(value: self.metalRateVal, percentageVal: set14KValue)
                    self.lblCalcu14k.text = self.calculation.totalPriceFormatter(value: purity14k)
                }
            }
        }
        
        else if textField.tag == 8 {
            if newString == "" {
                self.set9KValue = 0
            }
            else{
                if newString != "0" {
                    self.set9KValue = Double(newString as String) ?? 0.0
                    let purity9k = self.calculation.calculatePercentage(value: self.metalRateVal, percentageVal: set9KValue)
                    self.lblCalcu9k.text = self.calculation.totalPriceFormatter(value: purity9k)
                }
            }
        }
       
        else{
            print(textField.tag)
        }
        
        
        return true;
    }
    
    
    @IBAction func btnActionSaveCustomDetails(_ sender: UIButton) {
        
        if self.metalRateVal <= 0 && labourChrVal <= 0 && extraChrVal <= 0 && self.taxVal <= 0
        {
                    let alert = UIAlertController(title: "Alert", message: "Enter Metal Rate/gm value", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        }
        else{
            if self.metalRateVal > 0{
                CalcUserDefaultManager().setMetalRateValue(metalRateValue: self.metalRateVal)
            }
            if self.labourChrVal > 0{
                CalcUserDefaultManager().setLabourChargesValue(labourChargesValue: self.labourChrVal)
            }
            if self.extraChrVal > 0{
                CalcUserDefaultManager().setExtChargesValue(extCharges: self.extraChrVal)
            }
            if self.taxVal > 0{
                CalcUserDefaultManager().setTaxValue(taxValue: self.taxVal)
            }
            
            
            if self.set22KValue > 0{
                CalcUserDefaultManager().set22KValue(ct24Value: self.set22KValue)
            }
            else{
                CalcUserDefaultManager().set22KValue(ct24Value: rate22K)

            }
            if self.set18KValue > 0{
                CalcUserDefaultManager().set18KValue(ct18Value: self.set18KValue)
            }
            else{
                CalcUserDefaultManager().set18KValue(ct18Value: Double(rate18K))

            }
            if self.set9KValue > 0{
                CalcUserDefaultManager().set9KValue(ct9Value: self.set9KValue)
            }
            else{
                CalcUserDefaultManager().set9KValue(ct9Value: rate9K)

            }
            if self.set14KValue > 0{
                CalcUserDefaultManager().set14KValue(ct14Value: self.set14KValue)
            }
            else{
                CalcUserDefaultManager().set14KValue(ct14Value: rate14K)

            }
            self.view.CalcshowToast(message: "Data Saved")

        }
    }
    

    
    @IBAction func btnActionCurrency(_ sender: AnyObject) {
        let vc = UIStoryboard.init(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyVC") as? CurrencyVC
        vc?.isViewChanges = false
        vc?.currencyVCDelegate = currencyVCDelegate
        vc?.currncyVal = self.currncyVal
        vc?.currencyType = self.currencyType
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnActionGIA(_ sender: AnyObject) {
        let vc = UIStoryboard.init(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "CalcWebVC") as? CalcWebVC
        vc?.heading = "GIA Policy"
        vc?.urlStr = giaURL
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnActionIGI(_ sender: AnyObject) {
        let vc = UIStoryboard.init(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "CalcWebVC") as? CalcWebVC
        vc?.heading = "IGI Policy"
        vc?.urlStr = igiURL
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func btnSwitchAccount(_ sender: AnyObject) {
        self.openBottomSheet()
    }
    
    func openBottomSheet(){
        if let bottomSheet = UIStoryboard.init(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "BottomSheetVC") as? BottomSheetVC{
            if #available(iOS 15.0, *) {
                if let sheet = bottomSheet.sheetPresentationController{
                   sheet.detents = [.medium()]

                }
            } else {
            }
                bottomSheet.modalPresentationStyle = .pageSheet
                bottomSheet.bottomSheetDelegate = self
                self.present(bottomSheet, animated: true)
            }
        
      
        
    }

}



