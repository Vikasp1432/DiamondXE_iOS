//
//  JewelleryCalcVC.swift
//  DXE Price
//
//  Created by Genie Talk on 09/04/24.
//

import UIKit
import DropDown

class JewelleryCalcVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtProducName: UITextField!
    @IBOutlet weak var lblPurity: UILabel!
    
    @IBOutlet weak var lblNaturalTxt: UILabel!
    @IBOutlet weak var lblLabGrown: UILabel!

    
    @IBOutlet weak var txtMetalWt : UITextField!
    @IBOutlet weak var txtMetalRatePG: UITextField!
    @IBOutlet weak var txtMetalTotalAmt: UITextField!
    
    @IBOutlet weak var txtLabour: UITextField!
    @IBOutlet weak var txtLabourRatePG: UITextField!
    @IBOutlet weak var txtLabourTotalAmt: UITextField!
    
    @IBOutlet weak var txtSolitairWt: UITextField!
    @IBOutlet weak var txtSolitairRatePC: UITextField!
    @IBOutlet weak var txtSolitairTatoalAmt: UITextField!
    
    @IBOutlet weak var txtSideDIA: UITextField!
    @IBOutlet weak var txtSideDIARatePC: UITextField!
    @IBOutlet weak var txtSideDIATotalAmt: UITextField!
    
    @IBOutlet weak var txtColStoneWt: UITextField!
    @IBOutlet weak var txtColStoneWtPC: UITextField!
    @IBOutlet weak var txtColStoneTotalAmt: UITextField!
    
    @IBOutlet weak var txtExtraCharges: UITextField!
    @IBOutlet weak var txtTaxCharges: UITextField!
    
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!

    
    
    @IBOutlet weak var btnNatural: UIButton!
    @IBOutlet weak var btnLabGrown: UIButton!
    
    //var and constent
    let dropDown = DropDown()
    var purityType  = "22K"
    let calculation = Calculation()
    var natualOrLabGrown = String()
    
    var rate22K = 75.0
    var rate18K = 0.0
    var rate14K = 58.5
    var rate9K = 37.5
//    var rateOtherK = 0.0

    
    //Var of txtFields
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

    
    var isNatural = true
    var solitaierNotes = String()
    var sideDiaNotes = String()
    var otherCharges = String()
    
    var productName = String()
    var grandTotal = String()
    var priceWitCurr = String()
    var isEditQuatation = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dropDownSetup()
        
//        let curencyType = UserDefaultManager().getCurrencyType()
//        self.currencyType = curencyType
        self.lblCurrency.text = "Total Price (\(self.currencyType))"


        
        // Do any additional setup after loading the view.
        let tapUSD = UITapGestureRecognizer(target: self, action: #selector(JewelleryCalcVC.tapFunction))
        lblPurity.isUserInteractionEnabled = true
        lblPurity.addGestureRecognizer(tapUSD)
        
        let tapNatual = UITapGestureRecognizer(target: self, action: #selector(JewelleryCalcVC.tapNatual))
        lblNaturalTxt.isUserInteractionEnabled = true
        lblNaturalTxt.addGestureRecognizer(tapNatual)
        
        let tapLabgrown = UITapGestureRecognizer(target: self, action: #selector(JewelleryCalcVC.tapNatual))
        lblLabGrown.isUserInteractionEnabled = true
        lblLabGrown.addGestureRecognizer(tapLabgrown)
        
        txtProducName.delegate = self

        self.txtMetalWt.delegate = self
        self.txtMetalRatePG.delegate = self
        self.txtMetalTotalAmt.delegate = self
        
        self.txtLabour.delegate = self
        self.txtLabourRatePG.delegate = self
        self.txtLabourTotalAmt.delegate = self
        
        self.txtSolitairWt.delegate = self
        self.txtSolitairRatePC.delegate = self
        self.txtSolitairTatoalAmt.delegate = self
        
        self.txtSideDIA.delegate = self
        self.txtSideDIARatePC.delegate = self
        self.txtSideDIATotalAmt.delegate = self
        
        self.txtColStoneWt.delegate = self
        self.txtColStoneWtPC.delegate = self
        self.txtColStoneTotalAmt.delegate = self
        
        self.txtExtraCharges.delegate = self
        self.txtTaxCharges.delegate = self
        
        // setDefault
        
        
        if isEditQuatation{
            setDataForEditQuatation()
            
        }
        else{
            self.natualOrLabGrown = "Natural Diamond"
            setDefaultValue()
        }
       
    }
    
    
    func setDataForEditQuatation(){
     
        self.txtProducName.text = self.productName
        
        self.txtMetalWt.text = "\(self.metalwt)"
        self.txtMetalRatePG.text = "\(self.metalRatePGm)"
        self.txtMetalTotalAmt.text = "\(self.metalwtTotal)"
      
        self.txtLabour.text = "\(self.labourChar)"
        self.txtLabourRatePG.text = "\(self.labourCharRatePGm)"
        self.txtLabourTotalAmt.text = "\(self.labourCharTotal)"
        
        self.txtSolitairWt.text = "\(self.solitairwt)"
        self.txtSolitairRatePC.text = "\(self.solitairRatePCt)"
        self.txtSolitairTatoalAmt.text = "\(self.solitairTotal)"
    
        self.txtSideDIA.text = "\(self.sideDIA)"
        self.txtSideDIARatePC.text = "\(self.sideDIARatePCt)"
        self.txtSideDIATotalAmt.text = "\(self.sideDIATotal)"
        
        self.txtColStoneWt.text = "\(self.colStoneWt)"
        self.txtColStoneWtPC.text = "\(self.colStonePCt)"
        self.txtColStoneTotalAmt.text = "\(self.colStoneTotal)"
        
        self.txtExtraCharges.text = "\(self.extraCharges)"
        self.txtTaxCharges.text = "\(self.taxCharges)"
        
        self.lblGrandTotal.text = "\(self.grandTotal)"
        
        if self.natualOrLabGrown ==  "Lab Grown Diamond"{
           // self.natualOrLabGrown =  "Lab Grown Diamond"
            isNatural = false
            self.btnNatural.setImage(UIImage(named: "RadioOff"), for: .normal)
            self.btnLabGrown.setImage(UIImage(named: "RadioOn"), for: .normal)
        }else{
            //self.natualOrLabGrown = "Natural Diamond"
            isNatural = true
            self.btnNatural.setImage(UIImage(named: "RadioOn"), for: .normal)
            self.btnLabGrown.setImage(UIImage(named: "RadioOff"), for: .normal)
        }
      
    }
    
    
    
    
    // textfieldDetegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Hide the keyboard when the "Done" button is tapped
        if textField.tag == 0{
            textField.resignFirstResponder()
        }
            return true
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //   print("While entering the characters this method gets called")
        
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        
        if textField.tag == 1{
            if newString == "" {
                self.metalwt = 0 
                self.labourChar = 0
                self.txtLabour.text = "0"
                let metalTotal = self.calculation.calculateByMultiplyLogic(paramA: self.metalwt, paramB: self.metalRatePGm)
                
                self.metalwtTotal = metalTotal
                self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)//"\(self.metalwtTotal.rounded())"
                
                let labourTotal = self.calculation.calculateByMultiplyLogic(paramA: self.labourChar, paramB: self.labourCharRatePGm)
                self.labourCharTotal = labourTotal
                self.txtLabourTotalAmt.text = calculation.decimalRoundOf(value: self.labourCharTotal) //"\(self.labourCharTotal.rounded())"
                grandTotalCalculation()

            }
            else{
                if newString != "0" {
                    //self.txtMetalWt.text = newString as String
                    self.txtLabour.text = newString as String
                    self.labourChar = Double(newString as String) ?? 0
                    self.metalwt = Double(newString as String) ?? 0
                    
                    let metalTotal = self.calculation.calculateByMultiplyLogic(paramA: self.metalwt, paramB: self.metalRatePGm)
                  
                    self.metalwtTotal = metalTotal
                    let sumRoundOfMetalWt = calculation.decimalRoundOf(value: self.metalwtTotal)
                    self.txtMetalTotalAmt.text = "\(sumRoundOfMetalWt)"
                    
                    let labourTotal = self.calculation.calculateByMultiplyLogic(paramA: self.labourChar, paramB: self.labourCharRatePGm)
                    self.labourCharTotal = labourTotal
                    let sumRoundOflabour = calculation.decimalRoundOf(value: self.labourCharTotal)
                    self.txtLabourTotalAmt.text = "\(sumRoundOflabour)"
                    grandTotalCalculation()

                }
            }
            
        }
        else if textField.tag == 2{
            if newString == "" {
                self.metalRatePGm = 0  
                self.metalwtTotal = 0
                self.txtMetalTotalAmt.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtMetalRatePG.text = newString as String
                    self.metalRatePGm = Double(newString as String) ?? 0
                    let metalTotal = self.calculation.calculateByMultiplyLogic(paramA: self.metalwt, paramB: self.metalRatePGm)
                     self.metalwtTotal = metalTotal
                    let sumRoundOfMetalWt = calculation.decimalRoundOf(value: self.metalwtTotal)
                    self.txtMetalTotalAmt.text = "\(sumRoundOfMetalWt)"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 3{
            if newString == "" {
                self.metalwtTotal = 0  
                self.metalRatePGm = 0
                self.txtMetalRatePG.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                  //  self.txtMetalTotalAmt.text = newString as String
                    self.metalwtTotal = Double(newString as String) ?? 0
                    let metalPGm = self.calculation.calculateByDevideLogic(devidedBy: self.metalwt, totalAmnt: self.metalwtTotal)
                    
                    self.txtMetalRatePG.text = self.calculation.decimalManage(value: metalPGm)//"\(metalPGm)"
                    
                    self.metalRatePGm = metalPGm

                    grandTotalCalculation()

                }
            }
        }
        else if textField.tag == 4{
            if newString == "" {
                self.labourChar = 0 
                self.metalwt = 0
                self.txtMetalWt.text = "0"
                let labourTotal = self.calculation.calculateByMultiplyLogic(paramA: self.labourChar, paramB: self.labourCharRatePGm)
                self.labourCharTotal = labourTotal
                self.txtLabourTotalAmt.text = calculation.decimalRoundOf(value: self.labourCharTotal)// "\(self.labourCharTotal.rounded())"
                
                let metalTotal = self.calculation.calculateByMultiplyLogic(paramA: self.metalwt, paramB: self.metalRatePGm)
                
                self.metalwtTotal = metalTotal
                self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)//"\(self.metalwtTotal.rounded())"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                    self.txtMetalWt.text = newString as String
                    self.labourChar = Double(newString as String) ?? 0
                    self.metalwt = Double(newString as String) ?? 0
                    let labourTotal = self.calculation.calculateByMultiplyLogic(paramA: self.labourChar, paramB: self.labourCharRatePGm)
                    self.labourCharTotal = labourTotal
                    self.txtLabourTotalAmt.text = calculation.decimalRoundOf(value: self.labourCharTotal)// "\(self.labourCharTotal.rounded())"
                    
                    let metalTotal = self.calculation.calculateByMultiplyLogic(paramA: self.metalwt, paramB: self.metalRatePGm)
                    
                    self.metalwtTotal = metalTotal
                    self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)// "\(self.metalwtTotal.rounded())"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 5{
            if newString == "" {
                self.labourCharRatePGm = 0  
                self.labourCharTotal = 0
                self.txtLabourTotalAmt.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtLabourRatePG.text = newString as String
                    self.labourCharRatePGm = Double(newString as String) ?? 0
                    let labourTotal = self.calculation.calculateByMultiplyLogic(paramA: self.labourChar, paramB: self.labourCharRatePGm)
                     self.labourCharTotal = labourTotal
                    self.txtLabourTotalAmt.text = calculation.decimalRoundOf(value: self.labourCharTotal)//"\(self.labourCharTotal)"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 6 {
            if newString == "" {
                self.labourCharTotal = 0
                self.labourCharRatePGm = 0
                self.txtLabourRatePG.text = "0"
                self.grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtLabourTotalAmt.text = newString as String
                    self.labourCharTotal = Double(newString as String) ?? 0
                    let labourPGm = self.calculation.calculateByDevideLogic(devidedBy: self.labourChar, totalAmnt: self.labourCharTotal)
                    
                    let manageDecimal = calculation.decimalManage(value: labourPGm)
                    self.txtLabourRatePG.text = "\(manageDecimal)"
                    self.labourCharRatePGm = labourPGm
                    
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 7{
            if newString == "" {
                self.solitairwt = 0 
                self.solitairRatePCt = 0
                self.solitairTotal = 0
                self.txtSolitairRatePC.text = "0"
                self.txtSolitairTatoalAmt.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                    //self.txtSolitairWt.text = newString as String
                    self.solitairwt = Double(newString as String) ?? 0
                    let solitairTotal = self.calculation.calculateByMultiplyLogic(paramA: self.solitairwt, paramB: self.solitairRatePCt)
                    self.solitairTotal = solitairTotal
                    self.txtSolitairTatoalAmt.text = calculation.decimalRoundOf(value: self.solitairTotal)//"\(self.solitairTotal)"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 8{
            if newString == "" {
                self.solitairRatePCt = 0 
                self.solitairTotal = 0
                self.txtSolitairTatoalAmt.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                    //self.txtSolitairRatePC.text = newString as String
                    self.solitairRatePCt = Double(newString as String) ?? 0
                    let solitairTotal = self.calculation.calculateByMultiplyLogic(paramA: self.solitairwt, paramB: self.solitairRatePCt)
                     self.solitairTotal = solitairTotal
                    self.txtSolitairTatoalAmt.text = calculation.decimalRoundOf(value: self.solitairTotal)//"\(self.solitairTotal)"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 9 {
            if newString == "" {
                self.solitairTotal = 0 
                self.solitairRatePCt = 0
                self.txtSolitairRatePC.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtSolitairTatoalAmt.text = newString as String
                    self.solitairTotal = Double(newString as String) ?? 0
                    let solitairPGm = self.calculation.calculateByDevideLogic(devidedBy: self.solitairwt, totalAmnt: self.solitairTotal)
                    self.txtSolitairRatePC.text = calculation.decimalManage(value: solitairPGm)//"\(solitairPGm)"
                    self.solitairRatePCt = solitairPGm
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 10{
            if newString == "" {
                self.sideDIA = 0
                self.sideDIARatePCt = 0
                self.sideDIATotal = 0
                self.txtSideDIARatePC.text = "0"
                self.txtSideDIATotalAmt.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                  //  self.txtSideDIA.text = newString as String
                    self.sideDIA = Double(newString as String) ?? 0
                    let sideTotal = self.calculation.calculateByMultiplyLogic(paramA: self.sideDIA, paramB: self.sideDIARatePCt)
                    self.sideDIATotal = sideTotal
                    self.txtSideDIATotalAmt.text = calculation.decimalRoundOf(value: self.sideDIATotal)//"\(self.sideDIATotal)"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 11{
            if newString == "" {
                self.sideDIARatePCt = 0 
                self.sideDIATotal = 0
                self.txtSideDIATotalAmt.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                    //self.txtSideDIARatePC.text = newString as String
                    self.sideDIARatePCt = Double(newString as String) ?? 0
                    let sideTotal = self.calculation.calculateByMultiplyLogic(paramA: self.sideDIA, paramB: self.sideDIARatePCt)
                    self.sideDIATotal = sideTotal
                    self.txtSideDIATotalAmt.text = calculation.decimalRoundOf(value: self.sideDIATotal)//"\(self.sideDIATotal)"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 12 {
            if newString == "" {
                self.sideDIATotal = 0  
                self.sideDIARatePCt = 0
                self.txtSideDIARatePC.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtSideDIATotalAmt.text = newString as String
                    self.sideDIATotal = Double(newString as String) ?? 0
                    let sidePGm = self.calculation.calculateByDevideLogic(devidedBy: self.sideDIA, totalAmnt: self.sideDIATotal)
                    self.txtSideDIARatePC.text = calculation.decimalManage(value: sidePGm)//"\(sidePGm)"
                    self.sideDIARatePCt = sidePGm
                    
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 13{
            if newString == "" {
                self.colStoneWt = 0
                self.colStonePCt = 0
                self.colStoneTotal = 0
                self.txtColStoneWtPC.text = "0"
                self.txtColStoneTotalAmt.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtColStoneWt.text = newString as String
                    self.colStoneWt = Double(newString as String) ?? 0
                    let colStoreTotal = self.calculation.calculateByMultiplyLogic(paramA: self.colStoneWt, paramB: self.colStonePCt)
                    self.colStoneTotal = colStoreTotal
                    self.txtColStoneTotalAmt.text = calculation.decimalRoundOf(value: self.colStoneTotal)//"\(self.colStoneTotal)"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 14{
            if newString == "" {
                self.colStonePCt = 0
                self.colStoneTotal = 0
                self.txtColStoneTotalAmt.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtColStoneWtPC.text = newString as String
                    self.colStonePCt = Double(newString as String) ?? 0
                    let colStoreTotal = self.calculation.calculateByMultiplyLogic(paramA: self.colStoneWt, paramB: self.colStonePCt)
                    self.colStoneTotal = colStoreTotal
                    self.txtColStoneTotalAmt.text = calculation.decimalRoundOf(value: self.colStoneTotal)//"\(self.colStoneTotal)"
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 15{
            if newString == "" {
                self.colStoneTotal = 0
                self.colStonePCt = 0
                self.txtColStoneWtPC.text = "0"
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtColStoneTotalAmt.text = newString as String
                    self.colStoneTotal = Double(newString as String) ?? 0
                    let sidePGm = self.calculation.calculateByDevideLogic(devidedBy: self.colStoneWt, totalAmnt: self.colStoneTotal)
                    self.txtColStoneWtPC.text = calculation.decimalManage(value: sidePGm)//"\(sidePGm)"
                    self.colStonePCt = sidePGm
                    grandTotalCalculation()
                    
                    self.grandTotalCalculation()
                    

                }
            }
        }
        else if textField.tag == 16{
            if newString == "" {
                self.extraCharges = 0
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                   // self.txtExtraCharges.text = newString as String
                    self.extraCharges = Double(newString as String) ?? 0
                    grandTotalCalculation()
                }
            }
        }
        else if textField.tag == 17{
            if newString == "" {
                self.taxCharges = 0
                grandTotalCalculation()
            }
            else{
                if newString != "0" {
                    
                    //self.txtTaxCharges.text = newString as String
                    self.taxCharges = Double(newString as String) ?? 0
                    
                    self.grandTotalCalculation()
                    
                }
            }
        }
        else{
            print(textField.tag)
        }
        
        
        return true;
    }
    
    
    
    
    // set default value
    func setDefaultValue(){
        let metalWtPricePG = CalcUserDefaultManager().getMetalRateValue()
        let labourPricePG = CalcUserDefaultManager().getLabourChargesValueValue()
        let extraCharges = CalcUserDefaultManager().getExtChargesValue()
        let tax = CalcUserDefaultManager().getTaxValue()
        self.taxCharges = tax
        self.extraCharges = extraCharges
        self.txtExtraCharges.text = "\(extraCharges)"
        self.txtTaxCharges.text = "\(tax)"
        
        
        if let ct22K = CalcUserDefaultManager().get22KValue() {
            rate22K = ct22K
        }
        if let ct14K = CalcUserDefaultManager().get14KValue(){
            rate14K = ct14K
        }
        if let ct18K = CalcUserDefaultManager().get18KValue(){
            rate18K = ct18K
        }
        if let ct9K = CalcUserDefaultManager().get9KValue(){
            rate9K = ct9K
        }
//        if  let ctOtherK = UserDefaultManager().getOtherKValue(){
//            rateOtherK = ctOtherK
//        }

        self.grandTotalCalculation()
        
        if !metalWtPricePG.isNaN{
            
            switch self.purityType {
            case "22K":
                let calculateRatePGm = self.calculation.calculatePercentage(value: metalWtPricePG, percentageVal: rate22K)
                self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
                self.metalRatePGm =  calculateRatePGm
                
            case "18K":
                let calculateRatePGm = self.calculation.calculatePercentage(value: metalWtPricePG, percentageVal: rate18K)
                self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
                self.metalRatePGm =  calculateRatePGm
            case "14K":
                let calculateRatePGm = self.calculation.calculatePercentage(value: metalWtPricePG, percentageVal: rate14K)
                self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
                self.metalRatePGm =  calculateRatePGm

            case "9K":
                let calculateRatePGm = self.calculation.calculatePercentage(value: metalWtPricePG, percentageVal: rate9K)
                self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
                self.metalRatePGm =  calculateRatePGm

            default:
                self.metalRatePGm =  metalWtPricePG
                self.txtMetalRatePG.text = calculation.decimalManage(value: metalWtPricePG)//"\(metalWtPricePG)"
                
//                let calculateRatePGm = self.calculation.calculatePercentage(value: metalWtPricePG, percentageVal: rateOtherK)
//                self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
//                self.metalRatePGm =  calculateRatePGm
            }
        }
        
        if !labourPricePG.isNaN{
            self.txtLabourRatePG.text = calculation.decimalManage(value: labourPricePG)//"\(labourPricePG)"
            self.labourCharRatePGm = labourPricePG
        }
    }
    
    
  
    
    
    func setCalculationWithPurityK() {
        let baseMetalPgm = CalcUserDefaultManager().getMetalRateValue()
        
        switch self.purityType {
        case "22K":
            let baseMetalPgm = CalcUserDefaultManager().getMetalRateValue()
            let calculateRatePGm = self.calculation.calculatePercentage(value: baseMetalPgm, percentageVal: rate22K)
            self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
            self.metalRatePGm =  calculateRatePGm
            self.metalwtTotal = self.metalwt * self.metalRatePGm
            self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)
            
            self.grandTotalCalculation()
        case "18K":
            let baseMetalPgm = CalcUserDefaultManager().getMetalRateValue()
            let calculateRatePGm = self.calculation.calculatePercentage(value: baseMetalPgm, percentageVal: rate18K)
            self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
            self.metalRatePGm =  calculateRatePGm
            self.metalwtTotal = self.metalwt * self.metalRatePGm
            self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)
            
            self.grandTotalCalculation()
        case "14K":
            let calculateRatePGm = self.calculation.calculatePercentage(value: baseMetalPgm, percentageVal: rate14K)
            self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
            self.metalRatePGm =  calculateRatePGm
            self.metalwtTotal = self.metalwt * self.metalRatePGm
            self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)
            self.grandTotalCalculation()

        case "9K":
            let calculateRatePGm = self.calculation.calculatePercentage(value: baseMetalPgm, percentageVal: rate9K)
            self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
            self.metalRatePGm =  calculateRatePGm
            self.metalwtTotal = self.metalwt * self.metalRatePGm
            self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)
            self.grandTotalCalculation()

        default:
            self.txtMetalRatePG.text = "\(self.metalRatePGm)"
            self.metalwtTotal = self.metalwt * self.metalRatePGm
            //self.grandTotalCalculation()
            self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)
            self.setDefaultValue()
            
            
//            let calculateRatePGm = self.calculation.calculatePercentage(value: baseMetalPgm, percentageVal: rateOtherK)
//            self.txtMetalRatePG.text = calculation.decimalManage(value: calculateRatePGm)//"\(calculateRatePGm)"
//            self.metalRatePGm =  calculateRatePGm
//            self.metalwtTotal = self.metalwt * self.metalRatePGm
//            self.txtMetalTotalAmt.text = calculation.decimalRoundOf(value: self.metalwtTotal)
//            self.grandTotalCalculation()

        }
    }
    
    func grandTotalCalculation(){
                
        let SumOfAllAmt = self.metalwtTotal + self.labourCharTotal + self.solitairTotal + self.sideDIATotal + self.colStoneTotal + extraCharges
        
        let applyTax = self.calculation.calculatePercentage(value: SumOfAllAmt, percentageVal: self.taxCharges)
        self.taxCalculation = applyTax
        let grandTotal = SumOfAllAmt + applyTax
        let roundOffPrice = self.calculation.decimalRoundOf(value: grandTotal)
        self.lblGrandTotal.text = self.calculation.totalPriceFormatter(value: Double(roundOffPrice) ?? 0)//"\(grandTotal)"
        self.lblCurrency.text = "Total Price (\(self.currencyType))"
    }
    
    
    func clearAll(){
        self.txtMetalWt.text = String()
        self.txtMetalRatePG.text = String()
        self.txtMetalTotalAmt.text = String()
        
        self.txtLabour.text = String()
        self.txtLabourRatePG.text = String()
        self.txtLabourTotalAmt.text = String()
        
        self.txtSolitairWt.text = String()
        self.txtSolitairRatePC.text = String()
        self.txtSolitairTatoalAmt.text = String()
        
        self.txtSideDIA.text = String()
        self.txtSideDIARatePC.text = String()
        self.txtSideDIATotalAmt.text = String()
        
        self.txtColStoneWt.text = String()
        self.txtColStoneWtPC.text = String()
        self.txtColStoneTotalAmt.text = String()
        
        self.txtExtraCharges.text = String()
        self.txtTaxCharges.text = String()
        
        self.lblGrandTotal.text = "00"
        
        self.metalwt = Double()
        self.labourChar = Double()
        self.solitairwt = Double()
        self.sideDIA = Double()
        self.colStoneWt = Double()
        
        self.metalRatePGm = Double()
        self.labourCharRatePGm = Double()
        self.solitairRatePCt = Double()
        self.sideDIARatePCt = Double()
        self.colStonePCt = Double()
        
        self.metalwtTotal  = Double()
        self.labourCharTotal = Double()
        self.solitairTotal = Double()
        self.sideDIATotal = Double()
        self.colStoneTotal = Double()
        self.setDefaultValue()
    }
    
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.dropDown.show()
    }
    
    @IBAction func tapPurity(_ sender:UIButton) {
        self.dropDown.show()
    }
    
    
    @objc func tapNatual(sender:UITapGestureRecognizer) {
        self.setDiamondType()
    }
  
    
    //Dropdown setup
    func dropDownSetup(){
        //dropDown.view
        DispatchQueue.main.async {
            
            self.dropDown.bottomOffset = CGPoint( x: 10, y: 35)
            self.dropDown.cellHeight = 40
            self.dropDown.width = 150
            self.dropDown.backgroundColor = .white
            self.dropDown.selectedTextColor = UIColor(named: "ThemeClr")!
            self.dropDown.dataSource = ["22K","18K", "14K", "9K", "Other"]
            self.dropDown.anchorView = self.lblPurity
            
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.purityType = item
                self.lblPurity.text = item
                self.setCalculationWithPurityK()
                
            }
        }
        
    }
    
    
    // get current Date
    func getCurrentDateInIndianFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd, hh:mm:ss a"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        return dateString
    }
    
    @IBAction func btnActionBack(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionDropDown(_ sender : UIButton){
        self.dropDown.show()
    }
    
    
    @IBAction func btnActionQuotation(_ sender : UIButton){
//        DispatchQueue.main.async {
//            let vc = UIStoryboard.init(name: "JewelleryCalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuotatiosVC") as? QuotatiosVC
//            vc?.metalwt = self.metalwt
//            vc?.metalRatePGm = self.metalRatePGm
//            vc?.metalwtTotal = self.metalwtTotal
//            
//            vc?.labourChar = self.labourChar
//            vc?.labourCharRatePGm = self.labourCharRatePGm
//            vc?.labourCharTotal = self.labourCharTotal
//            
//            vc?.solitairwt = self.solitairwt
//            vc?.solitairRatePCt = self.solitairRatePCt
//            vc?.solitairTotal = self.solitairTotal
//            
//            vc?.sideDIA = self.sideDIA
//            vc?.sideDIARatePCt = self.sideDIARatePCt
//            vc?.sideDIATotal = self.sideDIATotal
//            
//            vc?.colStoneWt = self.colStoneWt
//            vc?.colStonePCt = self.colStonePCt
//            vc?.colStoneTotal = self.colStoneTotal
//            
//            vc?.extraCharges = self.extraCharges
//            vc?.taxCharges = self.taxCharges
//            vc?.taxCalculation = self.taxCalculation
//            vc?.currncyVal  = self.currncyVal
//            vc?.currencyType  = self.currencyType
//            
//            vc?.natualOrLabGrown = self.natualOrLabGrown
//            vc?.solitaierNotes = self.solitaierNotes
//            vc?.sideDiaNotes = self.sideDiaNotes
//            vc?.otherCharges = self.otherCharges
//            vc?.productName = self.txtProducName.text ?? ""
//            vc?.purityType = self.purityType
//            
//            
//            vc?.grandTotal = self.lblGrandTotal.text ?? ""
//            vc?.priceWitCurr = self.lblCurrency.text ?? ""
//            
//            
//            
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
        
        if let grandTotalText = self.lblGrandTotal.text, !grandTotalText.isEmpty, grandTotalText != "0" {
        
        let currentQuotation = Quotationstruct(
                metalwt: self.metalwt,
                metalRatePGm: self.metalRatePGm,
                metalwtTotal: self.metalwtTotal,
                labourChar: self.labourChar,
                labourCharRatePGm: self.labourCharRatePGm,
                labourCharTotal: self.labourCharTotal,
                solitairwt: self.solitairwt,
                solitairRatePCt: self.solitairRatePCt,
                solitairTotal: self.solitairTotal,
                sideDIA: self.sideDIA,
                sideDIARatePCt: self.sideDIARatePCt,
                sideDIATotal: self.sideDIATotal,
                colStoneWt: self.colStoneWt,
                colStonePCt: self.colStonePCt,
                colStoneTotal: self.colStoneTotal,
                extraCharges: self.extraCharges,
                taxCharges: self.taxCharges,
                taxCalculation: self.taxCalculation,
                currncyVal: self.currncyVal,
                currencyType: self.currencyType,
                natualOrLabGrown: self.natualOrLabGrown,
                solitaierNotes: self.solitaierNotes,
                sideDiaNotes: self.sideDiaNotes,
                otherCharges: self.otherCharges,
                productName: self.txtProducName.text ?? "",
                purityType: self.purityType,
                grandTotal: self.lblGrandTotal.text ?? "",
                priceWitCurr: self.lblCurrency.text ?? "",
                dateStr: self.getCurrentDateInIndianFormat()
            )
            
        CalcUserDefaultManager().saveQuotationData(currentQuotation)
            // Push to the next view controller
            DispatchQueue.main.async {
                let vc = UIStoryboard(name: "JewelleryCalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuotatiosVC") as? QuotatiosVC
                
                // Fetch the latest quotation and pass it to the next VC
                if let latestQuotation =  CalcUserDefaultManager().getSavedQuotations().last {
                    vc?.metalwt = latestQuotation.metalwt ?? 0
                    vc?.metalRatePGm = latestQuotation.metalRatePGm ?? 0
                    vc?.metalwtTotal = latestQuotation.metalwtTotal ?? 0
                    vc?.labourChar = latestQuotation.labourChar ?? 0
                    vc?.labourCharRatePGm = latestQuotation.labourCharRatePGm ?? 0
                    vc?.labourCharTotal = latestQuotation.labourCharTotal ?? 0
                    vc?.solitairwt = latestQuotation.solitairwt ?? 0
                    vc?.solitairRatePCt = latestQuotation.solitairRatePCt ?? 0
                    vc?.solitairTotal = latestQuotation.solitairTotal ?? 0
                    vc?.sideDIA = latestQuotation.sideDIA ?? 0
                    vc?.sideDIARatePCt = latestQuotation.sideDIARatePCt ?? 0
                    vc?.sideDIATotal = latestQuotation.sideDIATotal ?? 0
                    vc?.colStoneWt = latestQuotation.colStoneWt ?? 0
                    vc?.colStonePCt = latestQuotation.colStonePCt ?? 0
                    vc?.colStoneTotal = latestQuotation.colStoneTotal ?? 0
                    vc?.extraCharges = latestQuotation.extraCharges ?? 0
                    vc?.taxCharges = latestQuotation.taxCharges ?? 0
                    vc?.taxCalculation = latestQuotation.taxCalculation ?? 0
                    vc?.currncyVal = latestQuotation.currncyVal ?? 0
                    vc?.currencyType = latestQuotation.currencyType ?? ""
                    vc?.natualOrLabGrown = latestQuotation.natualOrLabGrown ?? ""
                    vc?.solitaierNotes = latestQuotation.solitaierNotes ?? ""
                    vc?.sideDiaNotes = latestQuotation.sideDiaNotes ?? ""
                    vc?.otherCharges = latestQuotation.otherCharges ?? ""
                    vc?.productName = latestQuotation.productName ?? ""
                    vc?.purityType = latestQuotation.purityType ?? ""
                    vc?.grandTotal = latestQuotation.grandTotal ?? ""
                    vc?.priceWitCurr = latestQuotation.priceWitCurr ?? ""
                    vc?.date = latestQuotation.dateStr ?? ""
                }
                
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        } else {
            self.toastMessage("Please add some data")
        }
        
    }
    
    @IBAction func btnActionNaturalVSLabGrown(_ sender : UIButton){
        self.setDiamondType()
        
    }
    
    func setDiamondType(){
        if isNatural{
            self.natualOrLabGrown =  "Lab Grown Diamond"
            isNatural = false
            self.btnNatural.setImage(UIImage(named: "RadioOff"), for: .normal)
            self.btnLabGrown.setImage(UIImage(named: "RadioOn"), for: .normal)
        }else{
            self.natualOrLabGrown = "Natural Diamond"
            isNatural = true
            self.btnNatural.setImage(UIImage(named: "RadioOn"), for: .normal)
            self.btnLabGrown.setImage(UIImage(named: "RadioOff"), for: .normal)
        }
    }
    
   
    
    @IBAction func btnActionClearAll(_ sender : UIButton){
        self.clearAll()
    }
    
    @IBAction func btnActionMenu(_ sender: AnyObject) {
        DispatchQueue.main.async {
            let vc = UIStoryboard.init(name: "DXECalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuVC") as? MenuVC
            vc?.currencyVCDelegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func btnActionAddNotes(_ sender : UIButton){
        if sender.tag == 1{
            self.openBottomSheet(heading: "Side Diamond Notes", noteTag: sender.tag)
        }
        else if sender.tag == 3{
            self.openBottomSheet(heading: "Other Charges Notes", noteTag: sender.tag)
        }
        else{
            self.openBottomSheet(heading: "Main Solitaire Notes", noteTag: sender.tag)
        }
      
    }
    
    func openBottomSheet(heading:String, noteTag:Int){
        if let bottomSheet = UIStoryboard.init(name: "JewelleryCalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotesBottomSheet") as? NotesBottomSheet{
            if #available(iOS 15.0, *) {
                if let sheet = bottomSheet.sheetPresentationController{
                   sheet.detents = [.medium()]

                }
            } else {
            }
                bottomSheet.modalPresentationStyle = .pageSheet
                 bottomSheet.heading = heading
                 bottomSheet.noteTag = noteTag
            if noteTag == 1{
                bottomSheet.note = self.sideDiaNotes
            }
            else if noteTag == 3{
                bottomSheet.note = self.otherCharges
            }
            else{
                bottomSheet.note = self.solitaierNotes

            }
                bottomSheet.notesDelegate = self
                self.present(bottomSheet, animated: true)
            }
        
      
        
    }
    
    
}

extension JewelleryCalcVC : CurrencyVCDelegate, NotesAddDelegate{
    func notesAdd(notes: String, noteTag: Int) {
        if noteTag == 1{
            self.sideDiaNotes = notes
        }
        else  if noteTag == 3{
            self.otherCharges = notes
        }
        else{
            self.solitaierNotes = notes
        }
    }
    
    func getCurrency(currencyType: String, currencyVal: Double) {
        
        if !currencyVal.isNaN && currencyVal > 0{
            self.currncyVal = currencyVal
        }
        if !currencyType.isEmpty && currencyType != ""{
            self.currencyType = currencyType
        }
        self.setDefaultValue()
    }
    
}
