//
//  CalcDashboardVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/08/24.
//

import UIKit
import DropDown


class CalcDashboardVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var shapePickerView:UIPickerView!
    @IBOutlet var colorPickerView:UIPickerView!
    @IBOutlet var clarityPickerView:UIPickerView!
    @IBOutlet var shapeBGView:UIView!
    @IBOutlet var colorBGView:UIView!
    @IBOutlet var clarityBGView:UIView!
    @IBOutlet var btnDiscountPremium:UIButton!
    @IBOutlet var btnRefresh:UIButton!
    @IBOutlet var lblDropeDown:UILabel!
    @IBOutlet var lblDiscountPremium:UILabel!
    
    @IBOutlet var lblPriceCT:UILabel!
    @IBOutlet var lblDollorAmount:UILabel!
    @IBOutlet var lblINRAmount:UILabel!
    
    @IBOutlet var lblCurrency:UILabel!
    @IBOutlet var lblCurrencySecond:UILabel!

    @IBOutlet var txt$Amount:UITextField!
    @IBOutlet var txtCurrncyAmount:UITextField!
    
    @IBOutlet var txtCarateOfDiamond:UITextField!
    @IBOutlet var txtDiscountPremium:UITextField!
    @IBOutlet var txtLessPercentage:UITextField!
    @IBOutlet var txtTaxPercentage:UITextField!
    
    @IBOutlet var lblMarketPriceCrt:UILabel!
    @IBOutlet var lblPriceCrt:UILabel!
    @IBOutlet var lblTotalPriceCrt:UILabel!
    @IBOutlet var lblTotalPriceINR:UILabel!
    
    @IBOutlet var shadowViewGrandTotal:UIView!


    

    
    @IBOutlet var lblCurrencyType:UILabel!
    let dateFormatter = DateFormatter()
    var discountPremiumIndex = Int()
    var shape = String()
    var color = String()
    var clarity = String()
    var crate = Double()
    var marketPrice = Double()
    let dropDown = DropDown()
    var discountPremiumStr = "Discount"
    var totalAmnt$  = Double()
    var activityView: UIActivityIndicatorView?
    var cuccrncyINR = INRCurrency()
    var priceDataResponceRound = PriceListStruct()
    var priceDataResponcePear = PriceListStruct()
    let calculation = Calculation()
    var inrCurrencyVal  = Double()
    var currncyVal  = Double()
    var currencyType  = String()
    var priceCT  = Double()
    var discountPremiumAmt  = String()
    var lessPercentage  = String()
    var taxPercentage  = String()
    var currencyRealValue = Double()
    var caratAmt  = String()
    //10Ct
    var isPriceWith10Ct = true
    
    var txtgrandTotal$  = String()
    var txtGrandCurrency  = String()
    var totalPriveCrt  = Double()

  
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Dashboard")
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
        self.setupPickerView()
        self.dropDownSetup()
        self.txtCarateOfDiamond.delegate = self
        self.txtDiscountPremium.delegate = self
        self.txtLessPercentage.delegate = self
        self.txtTaxPercentage.delegate = self
        
        self.txt$Amount.delegate = self
        self.txtCurrncyAmount.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CalcDashboardVC.tapFunction))
        lblDropeDown.isUserInteractionEnabled = true
        lblDropeDown.addGestureRecognizer(tap)
        
        let tapUSD = UITapGestureRecognizer(target: self, action: #selector(CalcDashboardVC.tapFunctionUSD))
        lblDollorAmount.isUserInteractionEnabled = true
        lblDollorAmount.addGestureRecognizer(tapUSD)
        
        self.getData()
        // self.getPriceListRoundData()
        //shedul api call on friday
        //self.scheduleAPICall()
        self.setCurrencyVal()
        
        // add shadow
       // self.addShadow()
       self.view.CalcaddShadow(view: shadowViewGrandTotal)

        
    }
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    // Sample Code
    @IBAction func btnActionClearAll(_ sender: AnyObject) {
        self.txtCarateOfDiamond.text = ""
        self.txtCurrncyAmount.text = ""
        self.defaultValues()
    }
    
    @IBAction func btnActionJewelleryPriceVC(_ sender: UIButton) {
        DispatchQueue.main.async {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "JewelleryCalc", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "JewelleryCalcVC") as! JewelleryCalcVC
            vc.currncyVal = self.currncyVal
            vc.currencyType = self.currencyType
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func btnActionRingSizerVC(_ sender: UIButton) {
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "RingSizer", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "RingSizerVC") as! RingSizerVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setCurrencyVal(){
        let currencyV = CalcUserDefaultManager().getCurrencyValue()
        let currencyT = CalcUserDefaultManager().getCurrencyType()
        if !currencyV.isZero && !currencyT.isEmpty{
            let currencyFormat = Calculation().decimalManageCurrency(value: currencyV)
            self.lblDollorAmount.text = "\(currencyT)\(" ")\(currencyFormat)"
            //self.txtCurrncyAmount.text = "\(currencyT) 00"
            self.lblCurrency.text = "\(currencyT)"
            self.lblCurrencySecond.text = "\(currencyT)"
            //self.txtCurrncyAmount.text = "00"
           // self.currncyVal = currencyV
            self.currencyType = currencyT
            
            var desimalCurr = self.calculation.decimalManage(value: currencyV)
            self.currncyVal = Double(desimalCurr) ?? 0
        }
        else{
            self.getINRCurrencyInfo()
        }
        
    }
    
    func getData(){
        let roundData = CalcUserDefaultManager().getPriceListRoundData()
        let pearData = CalcUserDefaultManager().getPriceListPearData()
        
        if roundData.response == nil || pearData.response == nil{
            self.getPriceListRoundData()
        }
        else{
            self.priceDataResponceRound = roundData
            self.priceDataResponcePear = pearData
            self.scheduleAPICall()
        }
        
        self.txtCarateOfDiamond.attributedPlaceholder = NSAttributedString(
            string: "00.00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "lightGray") as Any]
        )
        self.txtDiscountPremium.attributedPlaceholder = NSAttributedString(
            string: "00.00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "lightGray") as Any]
        )
        
        self.txtTaxPercentage.attributedPlaceholder = NSAttributedString(
            string: "00.00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "lightGray") as Any]
        )
        self.txtLessPercentage.attributedPlaceholder = NSAttributedString(
            string: "00.00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "lightGray") as Any]
        )
    }
    
    
    
    func scheduleAPICall() {
        let date = Date().getCurrentDate()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.date(from:date)
        let priceSheet = CalcUserDefaultManager().getDatePriceSheet()
        let priceSheetDate = dateFormatter.date(from:priceSheet)!
       // print(priceSheetDate)
        let updatedDate = Calendar.current.date(byAdding: .day, value: 7, to: priceSheetDate)!
       // print(updatedDate)
        
        if currentDate! >= updatedDate{
            self.getPriceListRoundData()
            self.getINRCurrencyInfo()
        }
        
    }

    
    func manageFinalAmtTaxAndLess(enterStr:String){
        
        if self.lessPercentage.isEmpty  && self.taxPercentage.isEmpty {
            
            var total = Double()
            if self.totalAmnt$.isNaN{
                total = self.priceCT
            } else {
                total = self.totalAmnt$
            }
            
            let currencyINR = total * (self.currncyVal)
            self.txtCurrncyAmount.text = "\(calculation.decimalManage(value: currencyINR))"
            self.txt$Amount.text = "\(calculation.decimalManage(value: total))"
            
            let finalAmt = total * (self.currncyVal)
            let calculatedAmt = Calculation().totalPriceFormatter(value: finalAmt)
            self.lblCurrency.text = "\(self.currencyType)"
            self.lblCurrencySecond.text = "\(self.currencyType)"

            let totalPriceFormet = calculation.decimalManage(value: finalAmt)
            
            self.lblTotalPriceINR.text = calculation.totalPriceFormatter(value: Double(totalPriceFormet) ?? 0) //"\(calculatedAmt)"
            self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: totalAmnt$))"//"\(self.totalAmnt$)"
            //self.txtCurrncyAmount.text = "\(calculation.decimalManage(value: finalAmt))"//"\(self.totalAmnt$)"
        }
        else if !self.lessPercentage.isEmpty && self.taxPercentage.isEmpty{
            var total = Double()
            if self.totalAmnt$.isNaN{
                total = self.priceCT
            } else {
                total = self.totalAmnt$
            }
            
            var currencyINR = self.currncyVal * total
            self.txtCurrncyAmount.text = "\(calculation.decimalManage(value: currencyINR))"
          //  self.txt$Amount.text = "\(calculation.decimalManage(value: total))"
           //let total = self.priceCT//totalAmt
            let calculations = Calculation().calculatePercentage(value: total, percentageVal: Double(self.lessPercentage) ?? 0.0)
            let lessAmt = total - calculations
//

            let finalAmt = lessAmt * (self.currncyVal)
            let calculatedAmt = Calculation().totalPriceFormatter(value: finalAmt)
          //  self.txtCurrncyAmount.text = "\(self.currencyType)\(" ") \(calculatedAmt)"
            
            self.lblCurrency.text = "\(self.currencyType)"
            self.lblCurrencySecond.text = "\(self.currencyType)"
            let totalPriceFormet = calculation.decimalManage(value: finalAmt)
            
            self.lblTotalPriceINR.text = calculation.totalPriceFormatter(value: Double(totalPriceFormet) ?? 0)
            
//            self.lblTotalPriceINR.text = "\(calculation.decimalManage(value: finalAmt))"//"\(calculatedAmt)"
            
           // self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: lessAmt))"//"\(lessAmt)"
            self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: lessAmt))"//"\(lessAmt)"
            
        }
        else if self.lessPercentage.isEmpty  && !self.taxPercentage.isEmpty{
          //  let total = self.priceCT //self.totalAmt
            var total = Double()
            if self.totalAmnt$.isNaN{
                total = self.priceCT
            } else {
                total = self.totalAmnt$
            }
            let currencyINR = self.currncyVal * total
            self.txtCurrncyAmount.text = "\(calculation.decimalManage(value: currencyINR))"
           // self.txt$Amount.text = "\(calculation.decimalManage(value: total))"
            
            let calculations = Calculation().calculatePercentage(value: total, percentageVal: Double(self.taxPercentage) ?? 0.0)
            let addAmt = total + calculations
            let finalAmt = addAmt * (self.currncyVal)
            let calculatedAmt = Calculation().totalPriceFormatter(value: finalAmt)
          //  self.txtCurrncyAmount.text = "\(self.currencyType)\(" ") \(calculatedAmt)"
            
            self.lblCurrency.text = "\(self.currencyType)"
            self.lblCurrencySecond.text = "\(self.currencyType)"

            let totalPriceFormet = calculation.decimalManage(value: finalAmt)
            
            self.lblTotalPriceINR.text = calculation.totalPriceFormatter(value: Double(totalPriceFormet) ?? 0)
            
//            self.lblTotalPriceINR.text = "\(calculation.decimalManage(value: finalAmt))"//"\(calculatedAmt)"
            //self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: addAmt))"//"\(addAmt)"
            self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: addAmt))"//"\(addAmt)"

            
        }
        
        else if !self.lessPercentage.isEmpty && !self.taxPercentage.isEmpty{
            
            self.manageLessAndTax(less: self.lessPercentage, tax: self.taxPercentage)
            
        }
        
    }
    
    
    func manageLessAndTax(less:String, tax:String){
        
        
        var total = Double()
        if self.totalAmnt$.isNaN{
            total = self.priceCT
        } else {
            total = self.totalAmnt$
        }
        
         let currencyINR = self.currncyVal * total
         self.txtCurrncyAmount.text = "\(calculation.decimalManage(value: currencyINR))"//"\(lessAmtTax)"
         //self.txt$Amount.text = "\(calculation.decimalManage(value: total))"//"\(lessAmtTax)"


        
//        let total = self.priceCT//totalAmt
        let calculations = Calculation().calculatePercentage(value: total, percentageVal: Double(less) ?? 0.0)
        let lessAmt = total - calculations
        
        let calculationTax = Calculation().calculatePercentage(value: total, percentageVal: Double(tax) ?? 0.0)
        let lessAmtTax = lessAmt + calculationTax
        let finalAmtTax = lessAmtTax * (self.currncyVal)
        
        let calculatedAmt = Calculation().totalPriceFormatter(value: finalAmtTax)
       // self.txtCurrncyAmount.text = "\(self.currencyType)\(" ") \(calculatedAmt)"
        self.lblCurrency.text = "\(self.currencyType)"
        self.lblCurrencySecond.text = "\(self.currencyType)"

        
        self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: lessAmtTax))"//"\(calculatedAmt)"
       // self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: lessAmtTax))"//"\(lessAmtTax)"
        let totalPriceFormet = calculation.decimalManage(value: finalAmtTax)
        
        self.lblTotalPriceINR.text = calculation.totalPriceFormatter(value: Double(totalPriceFormet) ?? 0)
       // self.lblTotalPriceINR.text = "\(calculation.decimalManage(value: finalAmtTax))"//"\(lessAmtTax)"

    }
    
    
    @IBAction func btnActionRefresh(_ sender: AnyObject) {
        self.getPriceListRoundData()
    }
    
    
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.btnDiscountPremium.setImage(UIImage(named: "dropup"), for: .normal)
        self.dropDown.show()
    }
    
    
    @objc func tapFunctionUSD(sender:UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyVC") as? CurrencyVC
        vc?.currencyVCDelegate = self
        vc?.currncyVal = self.currncyVal
        vc?.currencyType = self.currencyType
        vc?.isViewChanges = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //   print("While entering the characters this method gets called")
        
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        
        if textField.tag == 0{
            self.caratAmt = newString as String
            if newString == "" {
                self.defaultValues()
            }
            else{
                if newString != "0" {
                    self.filterData(textStoneWeight: newString as String )
                }
            }
            
        }
        else if textField.tag == 1{
            self.discountPremiumAmt = newString as String
            if newString == "" {
                self.defaultCalculation(priceVal: self.txtCarateOfDiamond.text ?? "")
            }
            else{
                if self.discountPremiumStr == "Discount"{
                    self.discountCalculation(textDiscount: Double(newString as String) ?? 0.0)
                }
                else{
                    self.premiumCalculation(textPrimum: Double(newString as String) ?? 0.0)
                }
            }
        }
        
        else if textField.tag == 2{
            self.lessPercentage = newString as String
            self.manageFinalAmtTaxAndLess(enterStr: newString as String)
        }
        else if textField.tag == 3{
            self.taxPercentage = newString as String
            self.manageFinalAmtTaxAndLess(enterStr: newString as String)
        }
        
        else if textField.tag == 4{
            //print("USD")
            self.txtgrandTotal$ = newString as String
            let newPrice = Double(self.txtgrandTotal$) ?? 0.0
            self.dolorAmtChangeCalculation(newAmt: newPrice)
                
        }
        else if textField.tag == 5{
           // print("USD")
            self.txtGrandCurrency = newString as String
            let newPrice = Double(self.txtGrandCurrency) ?? 0.0
            self.inrAmtChangeCalculation(newAmt: newPrice)
            
        }
        
        
        else{
            print(textField.tag)
        }
        
        
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
    func getPriceListRoundData(){
        self.btnRefresh.isEnabled = false
        self.showActivityIndicator()
        CalcAlamofireManager().alamofireApiCalling(shape: "round",OnResultBlock: { (response, status) in
            if status {
                let data = response as? Data
                do {
                    
                    if data != nil {
                        CalcUserDefaultManager().setPriceListRoundData(priceList: data!)
                        self.getPriceListPearData()
                        self.priceDataResponceRound = CalcUserDefaultManager().getPriceListRoundData()
                        CalcUserDefaultManager().setDatePriceSheet()
                    }
                } catch {
                    print("Error")
                    self.hideActivityIndicator()
                }
            }
            else{
                
            }
            
            
        })
    }
    
    func getPriceListPearData(){
        CalcAlamofireManager().alamofireApiCalling(shape:"pear",OnResultBlock: { (response, status) in
            if status {
                let data = response as? Data
                self.hideActivityIndicator()
                do {
                    if data != nil {
                        CalcUserDefaultManager().setPriceListPearData(priceList: data!)
                        self.priceDataResponcePear = CalcUserDefaultManager().getPriceListPearData()
                    }
                } catch {
                    print("Error")
                }
            }
            else{
                self.hideActivityIndicator()
            }
            self.btnRefresh.isEnabled = true
            
        })
    }
    
    func getINRCurrencyInfo(){
        CalcAlamofireManager().callAPiINRInfoJson(OnResultBlock: { (response, status) in
            if status {
                let data = response as? Data
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(INRCurrency.self, from: data!)
                    print(result)
                    if result.success ?? false{
                        
                        self.inrCurrencyVal = result.result ?? 0.0
                        let amtVal = self.calculation.decimalManageCurrency(value: result.result ?? 0.0)
                        self.lblDollorAmount.text = "INR \(amtVal)"
                        self.currencyRealValue = result.result ?? 0.0
                        
                        let inrTotal = self.priceCT * (Double(amtVal) ?? 0.0)
                        let finalV = self.calculation.totalPriceFormatter(value: inrTotal)
                        
                        
                        let amtCurrncy = self.calculation.decimalManage(value: inrTotal)

                        //self.txtCurrncyAmount.text = "INR \(finalV)"
                        self.lblCurrency.text = "INR"
                        self.lblCurrencySecond.text = "INR"

                        self.txtCurrncyAmount.text = amtCurrncy
                        
                        CalcUserDefaultManager().setCurrencyType(currencyValue: "INR")
                        CalcUserDefaultManager().setCurrencyValue(currencyValue: (Double(amtVal) ?? 0.0))
                        
                        
                        var currnyAmt = Double(amtVal) ?? 0.0
                        let desimalCurr = self.calculation.decimalManage(value: currnyAmt)
                        self.currncyVal = Double(desimalCurr) ?? 0
                        
                        self.currencyType = "INR"
                    }
                    else{
                        self.lblCurrency.text = "INR"
                        self.lblCurrencySecond.text = "INR"
                        self.txtCurrncyAmount.text = "00"
                        //self.txtCurrncyAmount.text = "INR 00"
                        
                        CalcUserDefaultManager().setCurrencyType(currencyValue: "INR")
                        CalcUserDefaultManager().setCurrencyValue(currencyValue:  0.0)
                    }
                    
                } catch {
                    print("Error")
                    self.lblCurrency.text = "INR"
                    self.lblCurrencySecond.text = "INR"
                    self.txtCurrncyAmount.text = "00"
                   // self.txtCurrncyAmount.text = "INR 00"
                }
            }
            else{
                self.lblCurrency.text = "INR"
                self.lblCurrencySecond.text = "INR"
                self.txtCurrncyAmount.text = "00"
               // self.txtCurrncyAmount.text = "INR 00"
            }
            
            
        })
    }
    
    // filter data roiund and pear
    func filterData(textStoneWeight : String){
        let stoneWeight = Double(textStoneWeight) ?? 0.0
        if stoneWeight > 5.99 {
            if self.shape == "Round"{
                let priceDataList = self.priceDataResponceRound.response?.body?.price
                let stoneWeight = Double(textStoneWeight ) ?? 0.0
//                print(stoneWeight)
//                print(self.color)
//                print(self.clarity)
                
//                let filteredValues = priceDataList?
//                    .filter { $0.high_size ?? 0.0 >= 5.99 } // First filter: filter out values less than 400
//                    .filter { $0.low_size ?? 0.0 <= 5.00 }
//                    .filter { $0.color?.lowercased() ?? "" == self.color.lowercased() }
//                    .filter { $0.clarity?.lowercased() ?? "" == self.clarity.lowercased() }
//
//                if let priceData = filteredValues {
//                    self.setUpDate(priceChart: priceData, priceVal: textStoneWeight)
//                }
                
                
                if isPriceWith10Ct{
                    let filteredValues = priceDataList?
                        .filter { $0.high_size ?? 0.0 >= 10.99 } // First filter: filter out values less than 400
                        .filter { $0.low_size ?? 0.0 <= 10.00 }
                        .filter { $0.color?.lowercased() ?? "" == self.color.lowercased() }
                        .filter { $0.clarity?.lowercased() ?? "" == self.clarity.lowercased() }
                    if let priceData = filteredValues {
                        self.setUpDate(priceChart: priceData,priceVal: textStoneWeight)
                    }
                }
                else{
                    let filteredValues = priceDataList?
                        .filter { $0.high_size ?? 0.0 >= 5.99 } // First filter: filter out values less than 400
                        .filter { $0.low_size ?? 0.0 <= 5.00 }
                        .filter { $0.color?.lowercased() ?? "" == self.color.lowercased() }
                        .filter { $0.clarity?.lowercased() ?? "" == self.clarity.lowercased() }
                    if let priceData = filteredValues {
                        self.setUpDate(priceChart: priceData,priceVal: textStoneWeight)
                    }
                }
                
                
            }
            
            else{
                let priceDataList = self.priceDataResponcePear.response?.body?.price
                let stoneWeight = Double(textStoneWeight) ?? 0.0
//                print(stoneWeight)
//                print(self.color)
//                print(self.clarity)
                
                
                
                if isPriceWith10Ct{
                    let filteredValues = priceDataList?
                        .filter { $0.high_size ?? 0.0 >= 10.99 } // First filter: filter out values less than 400
                        .filter { $0.low_size ?? 0.0 <= 10.00 }
                        .filter { $0.color?.lowercased() ?? "" == self.color.lowercased() }
                        .filter { $0.clarity?.lowercased() ?? "" == self.clarity.lowercased() }
                    if let priceData = filteredValues {
                        self.setUpDate(priceChart: priceData,priceVal: textStoneWeight)
                    }
                }
                else{
                    let filteredValues = priceDataList?
                        .filter { $0.high_size ?? 0.0 >= 5.99 } // First filter: filter out values less than 400
                        .filter { $0.low_size ?? 0.0 <= 5.00 }
                        .filter { $0.color?.lowercased() ?? "" == self.color.lowercased() }
                        .filter { $0.clarity?.lowercased() ?? "" == self.clarity.lowercased() }
                    if let priceData = filteredValues {
                        self.setUpDate(priceChart: priceData,priceVal: textStoneWeight)
                    }
                }
                
                
//                if let priceData = filteredValues {
//                    self.setUpDate(priceChart: priceData,priceVal: textStoneWeight)
//                }
                
                
            }
        }
        else{
            if self.shape == "Round"{
                let priceDataList = self.priceDataResponceRound.response?.body?.price
                let stoneWeight = Double(textStoneWeight ) ?? 0.0
//                print(stoneWeight)
//                print(self.color)
//                print(self.clarity)
                
                let filteredValues = priceDataList?
                    .filter { $0.high_size ?? 0.0 >= stoneWeight } // First filter: filter out values less than 400
                    .filter { $0.low_size ?? 0.0 <= stoneWeight }
                    .filter { $0.color?.lowercased() ?? "" == self.color.lowercased() }
                    .filter { $0.clarity?.lowercased() ?? "" == self.clarity.lowercased() }
                
                if let priceData = filteredValues {
                    self.setUpDate(priceChart: priceData, priceVal: textStoneWeight)
                }

                
            }
            
            else{
                let priceDataList = self.priceDataResponcePear.response?.body?.price
                let stoneWeight = Double(textStoneWeight) ?? 0.0
//                print(stoneWeight)
//                print(self.color)
//                print(self.clarity)
                
                let filteredValues = priceDataList?
                    .filter { $0.high_size ?? 0.0 >= stoneWeight } // First filter: filter out values less than 400
                    .filter { $0.low_size ?? 0.0 <= stoneWeight }
                    .filter { $0.color?.lowercased() ?? "" == self.color.lowercased() }
                    .filter { $0.clarity?.lowercased() ?? "" == self.clarity.lowercased() }
                
                if let priceData = filteredValues {
                    self.setUpDate(priceChart: priceData,priceVal: textStoneWeight)
                }
                

                
            }
        }
        
    }
    
    func setUpDate(priceChart:[Price], priceVal :String){
        let carateOFDiamnd = Double(priceVal)
        let marketPrice = priceChart.first?.caratprice ?? 0
        let tottalPrice = Double(marketPrice) * (carateOFDiamnd ?? 0.0)
        self.totalPriveCrt = tottalPrice
        self.lblMarketPriceCrt.text = "$\(marketPrice)"
        
        self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: tottalPrice))"
        self.marketPrice = Double(marketPrice)
        self.defaultCalculation(priceVal:priceVal)
        
        
        if !self.discountPremiumAmt.isEmpty{
            if self.discountPremiumStr == "Discount"{
                self.discountCalculation(textDiscount: Double(self.discountPremiumAmt as String) ?? 0.0)
            }
            else{
                self.premiumCalculation(textPrimum: Double(self.discountPremiumAmt as String) ?? 0.0)
            }
        }
        
       
    }
    
    func discountCalculation(textDiscount : Double){
        
        let carateOFDiamnd = Double(self.caratAmt)
        let percentage = calculation.calculatePercentage(value: self.marketPrice, percentageVal: textDiscount)
        let finalAmnt = self.marketPrice - percentage
        self.priceCT = finalAmnt * (carateOFDiamnd ?? 0.0)
        
        self.lblPriceCT.text = "$\(calculation.decimalManage(value: finalAmnt))"
        self.totalAmnt$ = finalAmnt * (carateOFDiamnd ?? 0.0)
        self.txt$Amount.text = "\(calculation.decimalManage(value: self.priceCT))"
        self.userCurrencyCalculation()
        
    }
    
    func premiumCalculation(textPrimum : Double){
        let carateOFDiamnd = Double(self.caratAmt)
        let percentage = calculation.calculatePercentage(value: self.marketPrice, percentageVal: textPrimum)
        let finalAmnt = self.marketPrice + percentage
        self.priceCT = finalAmnt * (carateOFDiamnd ?? 0.0)
        self.lblPriceCT.text = "$\(calculation.decimalManage(value: finalAmnt))"
        self.totalAmnt$ = finalAmnt * (carateOFDiamnd ?? 0.0)
        self.txt$Amount.text = "\(calculation.decimalManage(value: self.priceCT))"
        self.userCurrencyCalculation()
    }
    
    
    func dolorAmtChangeCalculation(newAmt:Double){
        let carateOFDiamnd = Double(self.caratAmt)

        let orignalAmt = self.totalPriveCrt
        let newpercentage = calculation.calculateAmountToPer(orignalAmt: orignalAmt, newAmnt: newAmt)
      //  print(newpercentage)
        self.totalAmnt$ = newAmt //* (carateOFDiamnd ?? 0.0)

        self.txtDiscountPremium.text = "\(calculation.decimalAmtWith4Digit(value: newpercentage))"
        self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: newpercentage))"
        
        
        let percentage = calculation.calculatePercentage(value: self.marketPrice, percentageVal: newpercentage)
        var finalAmnt = Double()
//        if  newpercentage <  0{
            
            if !self.discountPremiumAmt.isEmpty{
                if self.discountPremiumStr == "Discount"{
                    finalAmnt = self.marketPrice - percentage
                }
                else{
                    finalAmnt = self.marketPrice + percentage
                }
            }
        else{
            finalAmnt = self.marketPrice - percentage
        }
//            else{
//                self.txt$Amount.text = "\(calculation.decimalManage(value: self.priceCT))"
//            }
            
//
//              finalAmnt = self.marketPrice - percentage
//        }
//        else{
//              finalAmnt = self.marketPrice + percentage
//        }
       
       // self.priceCT = finalAmnt * (carateOFDiamnd ?? 0.0)
        self.lblPriceCT.text = "$\(calculation.decimalManage(value: finalAmnt))"
        

        self.userCurrencyCalculation()
    }
    
    
    func inrAmtChangeCalculation(newAmt:Double){
        let carateOFDiamnd = Double(self.caratAmt)
        
     //   let changeInr = newAmt / self.currncyVal //* (self.totalAmnt$)

        let orignalAmt = self.totalPriveCrt * self.currncyVal
        let newpercentage = calculation.calculateAmountToPer(orignalAmt: orignalAmt, newAmnt: newAmt)
      //  print(newpercentage)
         //* (carateOFDiamnd ?? 0.0)
        
        let finalAmt = newAmt / self.currncyVal //* (self.totalAmnt$)
        self.totalAmnt$ = finalAmt
        self.txt$Amount.text = "\(calculation.decimalManage(value: self.totalAmnt$))"
        self.txtDiscountPremium.text = "\(calculation.decimalAmtWith4Digit(value: newpercentage))"
        self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: self.totalAmnt$))"
        
        let totalPriceFormet = calculation.decimalManage(value: newAmt)
        
        self.lblTotalPriceINR.text = calculation.totalPriceFormatter(value: Double(totalPriceFormet) ?? 0)
       // self.lblTotalPriceINR.text = "\(calculation.decimalManage(value: newAmt))"
        
        
        let percentage = calculation.calculatePercentage(value: self.marketPrice, percentageVal: newpercentage)
        var finalAmnt = Double()
        if !self.discountPremiumAmt.isEmpty{
            if self.discountPremiumStr == "Discount"{
                finalAmnt = self.marketPrice - percentage
            }
            else{
                finalAmnt = self.marketPrice + percentage
            }
        }
        else{
            finalAmnt = self.marketPrice - percentage
        }
       
       // self.priceCT = finalAmnt * (carateOFDiamnd ?? 0.0)
        self.lblPriceCT.text = "$\(calculation.decimalManage(value: finalAmnt))"
        
        
        var total = Double()
        if self.totalAmnt$.isNaN{
            total = self.priceCT
        } else {
            total = self.totalAmnt$
        }
        
//         let currencyINR = self.currncyVal * total
//         self.txtCurrncyAmount.text = "\(calculation.decimalManage(value: currencyINR))"//"\(lessAmtTax)"
//         //self.txt$Amount.text = "\(calculation.decimalManage(value: total))"//"\(lessAmtTax)"
//

        var less = String()
        var tax = String()
        
        if !self.lessPercentage.isEmpty && self.taxPercentage.isEmpty {
            less = self.lessPercentage
         }
         else if self.lessPercentage.isEmpty && !self.taxPercentage.isEmpty {
             tax = self.taxPercentage
         }
         
         else if !self.lessPercentage.isEmpty  && !self.taxPercentage.isEmpty{
             tax = self.taxPercentage
             less = self.lessPercentage
         }
        
//        let total = self.priceCT//totalAmt
        let calculations = Calculation().calculatePercentage(value: total, percentageVal: Double(less) ?? 0.0)
        let lessAmt = total - calculations
        
        let calculationTax = Calculation().calculatePercentage(value: total, percentageVal: Double(tax) ?? 0.0)
        let lessAmtTax = lessAmt + calculationTax
        let finalAmtTax = lessAmtTax * (self.currncyVal)
        
        let calculatedAmt = Calculation().totalPriceFormatter(value: finalAmtTax)
       // self.txtCurrncyAmount.text = "\(self.currencyType)\(" ") \(calculatedAmt)"
        self.lblCurrency.text = "\(self.currencyType)"
        self.lblCurrencySecond.text = "\(self.currencyType)"

        
        self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: lessAmtTax))"//"\(calculatedAmt)"
       // self.lblTotalPriceCrt.text = "\(calculation.decimalManage(value: lessAmtTax))"//"\(lessAmtTax)"
        
        let totalPriceFormetNew = calculation.decimalManage(value: finalAmtTax)
        
        self.lblTotalPriceINR.text = calculation.totalPriceFormatter(value: Double(totalPriceFormetNew) ?? 0)
        
       // self.lblTotalPriceINR.text = "\(calculation.decimalManage(value: finalAmtTax))"//"\(lessAmtTax)"


//        self.userCurrencyCalculation()
    }
    
    
    
    
    func defaultCalculation(priceVal:String){
        let carateOFDiamnd = Double(priceVal)
        let finalAmnt = self.marketPrice
        self.priceCT = finalAmnt * (carateOFDiamnd ?? 0.0)
        self.lblPriceCT.text = "$\(calculation.decimalManage(value: finalAmnt))"
        self.totalAmnt$ = finalAmnt * (carateOFDiamnd ?? 0.0)
       
        
        if !self.discountPremiumAmt.isEmpty{
            if self.discountPremiumStr == "Discount"{
                self.discountCalculation(textDiscount: Double(self.discountPremiumAmt) ?? 0.0)
            }
            else{
                self.premiumCalculation(textPrimum: Double(self.discountPremiumAmt) ?? 0.0)
            }
        }
        else{
            self.txt$Amount.text = "\(calculation.decimalManage(value: self.priceCT))"
        }
        
        self.userCurrencyCalculation()
    }
    
    func defaultValues(){
        self.lblMarketPriceCrt.text = "$00"
        self.txt$Amount.text = ""
        self.lblTotalPriceCrt.text = "00"
        self.lblTotalPriceINR.text = "00"
        self.lblPriceCT.text = "$00"
      //  self.txtCurrncyAmount.text = "INR 00"
        
        self.lblCurrency.text = "INR"
        self.lblCurrencySecond.text = "INR"
        self.txtCurrncyAmount.text = ""
        
        self.txtLessPercentage.text = .none
        self.txtTaxPercentage.text = .none
        self.txtDiscountPremium.text = .none
        
        self.discountPremiumAmt = String()
        self.lessPercentage  = String()
        self.taxPercentage  = String()
        self.txtgrandTotal$  = String()
        self.txtGrandCurrency  = String()
    }
    
    
    func userCurrencyCalculation(){
        if self.currncyVal != 0.0 || !currencyType.isEmpty {
            
           if !self.lessPercentage.isEmpty && self.taxPercentage.isEmpty {
                 self.manageFinalAmtTaxAndLess(enterStr: self.lessPercentage)
            }
            else if self.lessPercentage.isEmpty && !self.taxPercentage.isEmpty {
                self.manageFinalAmtTaxAndLess(enterStr: self.taxPercentage)
            }
            
            else if !self.lessPercentage.isEmpty  && !self.taxPercentage.isEmpty{
                self.manageLessAndTax(less: self.lessPercentage, tax: self.taxPercentage)
            }
            else{
                print(self.currncyVal)
                print(self.totalAmnt$)
                let finalAmt = self.currncyVal * (self.totalAmnt$)
                let decimal2D = self.calculation.decimalManage(value: finalAmt)
               

                print(finalAmt)

                self.txtCurrncyAmount.text = "\(decimal2D)"

                //let amt = self.calculation.totalPriceFormatter(value: Double(decimal2D) ?? 0)
              //  self.txtCurrncyAmount.text = "\(currencyType)\(" ")\(amt)"
                

                self.lblCurrency.text = "\(currencyType)"
                self.lblCurrencySecond.text = "\(currencyType)"

                
                
                let currncyAmt = self.calculation.decimalManageCurrency(value: currncyVal)
                self.lblDollorAmount.text = "\(self.currencyType)\(" ")\(currncyAmt)"
                self.lblTotalPriceCrt.text = self.calculation.decimalManage(value: self.totalAmnt$)//"\(self.totalAmnt$)"
               // self.lblTotalPriceINR.text = "\(decimal2D)"
                self.lblTotalPriceINR.text = self.calculation.totalPriceFormatter(value: Double(decimal2D) ?? 0)
                
                
                if  self.txtTaxPercentage.text != "" &&  self.txtTaxPercentage.text?.count ?? 0 > 0{
                    self.lessPercentage = self.txtTaxPercentage.text  ?? ""
                    self.manageFinalAmtTaxAndLess(enterStr: self.lessPercentage as String)
                }
                
                
                if  self.txtLessPercentage.text != "" &&  self.txtLessPercentage.text?.count ?? 0 > 0{
                    self.taxPercentage = self.txtLessPercentage.text  ?? ""
                    self.manageFinalAmtTaxAndLess(enterStr: self.taxPercentage as String)
                }


            }
        }
        
        else{
            self.getINRCurrencyInfo()
        }
    }
    
    
    
    
    func dropDownSetup(){
        //dropDown.view
        dropDown.bottomOffset = CGPoint( x: 0, y: 35)
        dropDown.cellHeight = 40
        dropDown.width = 150
        dropDown.backgroundColor = .white
        dropDown.selectedTextColor = UIColor(named: "ThemeClr")!
        dropDown.dataSource = ["- Discount", "+ Premium"]
        dropDown.anchorView = self.lblDropeDown
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.discountPremiumIndex = index
            self.btnDiscountPremium.setImage(UIImage(named: "dropdown"), for: .normal)
            if index == 0{
                self.lblDropeDown.text = "-"
                self.lblDiscountPremium.text = "Discount"
                self.discountPremiumStr = "Discount"
                self.dropDown.hide()
                
                if self.txtDiscountPremium.text?.count ?? 0 > 0{
                    self.discountCalculation(textDiscount: Double(self.txtDiscountPremium.text ?? "") ?? 0.0)
                }
            }
            else{
                self.lblDropeDown.text = "+"
                self.lblDiscountPremium.text = "Premium"
                self.discountPremiumStr = "Premium"
                self.dropDown.hide()
                if self.txtDiscountPremium.text?.count ?? 0 > 0{
                    self.premiumCalculation(textPrimum: Double(self.txtDiscountPremium.text ?? "") ?? 0.0)
                }
            }
        }
        
    }
    
    
    
    @IBAction func btnActionCurrencyVC(_ sender: AnyObject) {
        let vc = UIStoryboard.init(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyVC") as? CurrencyVC
        vc?.currencyVCDelegate = self
        vc?.currncyVal = self.currncyVal
        vc?.currencyType = self.currencyType
        vc?.isViewChanges = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func showCenteredDropDown(_ sender: AnyObject) {
        // self.btnDiscountPremium.setImage(UIImage(named: "dropup"), for: .normal)
        self.dropDown.show()
    }
    
    
    @IBAction func btnActionMenu(_ sender: AnyObject) {
        let vc = UIStoryboard.init(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuVC") as? MenuVC
        vc?.currencyVCDelegate = self
        vc?.currncyVal = self.currncyVal
        vc?.switchButtonDelegate = self
        vc?.switchButtonState = self.isPriceWith10Ct
        vc?.currencyType = self.currencyType
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func setupPickerView(){
        shapePickerView.delegate = self
        shapePickerView.dataSource = self
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        clarityPickerView.delegate = self
        clarityPickerView.dataSource = self
        
        shapePickerView.tintColor = .red
        //        shapePickerView.selectRow(2, inComponent: 0, animated: true)
        //        colorPickerView.selectRow(2, inComponent: 0, animated: true)
        //        clarityPickerView.selectRow(2, inComponent: 0, animated: true)
        
    }
    
}

extension CalcDashboardVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return diamondShapes.count
        case 1:
            return diamondColor.count
        case 2:
            return diamondClarity.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.backgroundColor = .clear
         pickerLabel.font = UIFont(name:"AvenirNext-Medium", size: 16.0)
         pickerLabel.textColor = UIColor(named: "lblHeading")
        pickerLabel.layer.cornerRadius = pickerLabel.frame.height/2.0
        switch pickerView.tag {
        case 0:
            pickerLabel.text = diamondShapes[row]
            self.shape = diamondShapes[row]
        case 1:
            pickerLabel.text = diamondColor[row]
            self.color = diamondColor[row]
        case 2:
            pickerLabel.text = diamondClarity[row]
            self.clarity = diamondClarity[row]
        default:
            return pickerLabel
        }
        pickerView.subviews[0].subviews[0].subviews[2].backgroundColor = .clear
        
        
        
        return pickerLabel
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let textCT = self.txtCarateOfDiamond.text ?? ""
        switch pickerView.tag {
        case 0:
            self.shape = diamondShapes[row]
            if textCT != "0" && textCT.count > 0 {
                self.filterData(textStoneWeight: textCT)
            }
            
            if self.txtDiscountPremium.text?.count ?? 0 > 0{
                if self.discountPremiumStr == "Discount"{
                    self.discountCalculation(textDiscount: Double(self.txtDiscountPremium.text ?? "") ?? 0.0)
                }
                else{
                    self.premiumCalculation(textPrimum: Double(self.txtDiscountPremium.text ?? "") ?? 0.0)
                }
            }
            
        case 1:
            self.color = diamondColor[row]
            if textCT != "0" && textCT.count > 0 {
                self.filterData(textStoneWeight: textCT)
            }
            
            if self.txtDiscountPremium.text?.count ?? 0 > 0{
                if self.discountPremiumStr == "Discount"{
                    self.discountCalculation(textDiscount: Double(self.txtDiscountPremium.text ?? "") ?? 0.0)
                }
                else{
                    self.premiumCalculation(textPrimum: Double(self.txtDiscountPremium.text ?? "") ?? 0.0)
                }
            }
        case 2:
            self.clarity = diamondClarity[row]
            if textCT != "0" && textCT.count > 0 {
                self.filterData(textStoneWeight: textCT)
            }
            
            if self.txtDiscountPremium.text?.count ?? 0 > 0{
                if self.discountPremiumStr == "Discount"{
                    self.discountCalculation(textDiscount: Double(self.txtDiscountPremium.text ?? "") ?? 0.0)
                }
                else{
                    self.premiumCalculation(textPrimum: Double(self.txtDiscountPremium.text ?? "") ?? 0.0)
                }
            }
        default:
            print("")
        }
    }
    
}

extension CalcDashboardVC {
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = UIColor(named: "HeadingClr")
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
        
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
}


extension CalcDashboardVC : CurrencyVCDelegate, MenuVCSwitchCaseDelegate{
    func isSwitch(isPriceWith10Ct: Bool) {
        self.isPriceWith10Ct = isPriceWith10Ct
        if self.txtCarateOfDiamond.text != "" && self.txtCarateOfDiamond.text?.count ?? 0 > 0{
            self.filterData(textStoneWeight: self.txtCarateOfDiamond.text ?? "")
        }
        
    }
    
    
    func getCurrency(currencyType: String, currencyVal: Double) {
        let desimalCurr = self.calculation.decimalManage(value: currencyVal)
        self.currncyVal = Double(desimalCurr) ?? 0//currencyVal
        self.currencyType = currencyType
        let balnceAmt = self.calculation.decimalManageCurrency(value: currencyVal)
        self.lblDollorAmount.text = "\(currencyType)\(" ")\(balnceAmt)"
        let finalAmt = currencyVal * (self.priceCT)
        let amt = self.calculation.totalPriceFormatter(value: finalAmt)
        //self.txtCurrncyAmount.text = "\(currencyType)\(" ")\(amt)"
        
        
       

        self.lblCurrency.text = "\(currencyType)"
        self.lblCurrencySecond.text = "\(currencyType)"
        
        if self.txtCarateOfDiamond.text != "" && self.txtCarateOfDiamond.text?.count ?? 0 > 0{
            var desimalINR = self.calculation.decimalManage(value: finalAmt)
            self.txtCurrncyAmount.text = "\(desimalINR)"
            self.userCurrencyCalculation()
        }
        
        
    }
    
}


extension Date {

 public func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: Date())

    }
}





extension UIView {
    func CalcshowToast(message: String) {
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            UIView.animate(withDuration: 1, animations: {
                messageLbl.alpha = 0
            }) { (_) in
                messageLbl.removeFromSuperview()
            }
        }
    }
    
    func CalcaddShadow(view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor =  UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 20.0
        view.layer.shadowOpacity = 0.4
        view.layer.cornerRadius = 20.0
    }
    
}
