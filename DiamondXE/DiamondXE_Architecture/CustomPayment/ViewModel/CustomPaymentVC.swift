//
//  CustomPaymentVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/08/24.
//

import UIKit
import DropDown
import SDWebImage

class CustomPaymentVC: BaseViewController {
    
    @IBOutlet var customPaymentTV:UITableView!
    var isCellExpandedPaymentOption = false
    var isCellExpandedPaymentOption2 = false
    var isCellExpandedTag = 0
    
    
    @IBOutlet var btnCustomPayment:UIButton!
    @IBOutlet var btnCustomPaymentHistory:UIButton!
    
    @IBOutlet var btnProceadPayment:UIButton!
    @IBOutlet var lblTotalAmount:UILabel!
    
    @IBOutlet var viewFooter:UIView!
    @IBOutlet var viewFooterHeight:NSLayoutConstraint!
    
    private var isLoading = true {
        didSet {
            customPaymentTV.isUserInteractionEnabled = !isLoading
            customPaymentTV.reloadData()
        }
    }
    
    
    var name = String()
    var companyName = String()
    var amount = String()
    var remark = String()
    
    var seletedBankInt = 0
    
    var checkNum = String()
    var paymentMode = String()
    var selectedDate = String()
    
    var paymentModeSelected = String()
    var amountTotal = String()
    
    var pageLimit = 12
    var page = 1
    
    var selectedBankID = String()
    
    var selectedUPIName = String()
    var selectedUPIBundl = String()
    
    var refreshControl = UIRefreshControl()


    
    var bankInfoStruct = BankInfoDataStruct()
    var bankChargesInfoStruct = BankChargesStruct()
    var paymentModeStruct = PaymentModeDataStruct()
    var bankingInfoStruct = PaymentModeDataStruct()
    var customDatePicker = CustomDatePicker()
    var customPaymentStruct = CustomPaymentDataStruct()
    var paymentINProcessStruct = PaymentINProcessStruct()
    var paymentStatusDataStruct = PaymentStatusStruct()
    
    var isCustomPaymentHistory = false

    override func viewDidLoad() {
        super.viewDidLoad()

        customPaymentTV.register(UINib(nibName: CustomInfoTVC.cellIdentifierCustomInfoTVC, bundle: nil), forCellReuseIdentifier: CustomInfoTVC.cellIdentifierCustomInfoTVC)
        customPaymentTV.register(UINib(nibName: PaymentOptionTVC.cellIdentifierPaymentOptionTVC, bundle: nil), forCellReuseIdentifier: PaymentOptionTVC.cellIdentifierPaymentOptionTVC)
        customPaymentTV.register(UINib(nibName: UPITVC.cellIdentifierUPITVC, bundle: nil), forCellReuseIdentifier: UPITVC.cellIdentifierUPITVC)
        customPaymentTV.register(UINib(nibName: OrderSummaryTVC.cellIdentifierOrderSummary, bundle: nil), forCellReuseIdentifier: OrderSummaryTVC.cellIdentifierOrderSummary)
        
        customPaymentTV.register(UINib(nibName: HistoryTVC.cellIdentifierHistoryTVC, bundle: nil), forCellReuseIdentifier: HistoryTVC.cellIdentifierHistoryTVC)
        
        btnCustomPayment.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        btnProceadPayment.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        self.getBankInfo()
        self.getPaymentModeInfo()
        self.configureRefreshControl()
        self.getBankChargesInfo()
        self.getNetBankingInfo()
    }
    
    
    // pull to refresh
    func configureRefreshControl() {
            // Add the refresh control to your table view
        customPaymentTV.refreshControl = refreshControl
            
            //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        }

    @objc private func refreshData(_ sender: Any) {
        // Refresh your data here
        if isCustomPaymentHistory{
            self.callAPIHistoryPayment()
        }
    }
    
    
    
    
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
       // backDelegate?.didBackAction(vc: self)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActionPayment_History(_ sender: UIButton) {
        if sender.tag < 1{
            btnCustomPayment.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnCustomPaymentHistory.clearGradient()
            self.btnCustomPaymentHistory.backgroundColor = .whitClr
            self.btnCustomPaymentHistory.setTitleColor(.themeClr, for: .normal)
            self.btnCustomPayment.setTitleColor(.whitClr, for: .normal)
            isCustomPaymentHistory = false
            customPaymentTV.reloadData()
            self.viewFooter.isHidden = false
            self.viewFooterHeight.constant = 100
            
        }
        else{
            
            btnCustomPaymentHistory.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnCustomPayment.clearGradient()
            self.btnCustomPayment.backgroundColor = .whitClr
            self.btnCustomPayment.setTitleColor(.themeClr, for: .normal)
            self.btnCustomPaymentHistory.setTitleColor(.whitClr, for: .normal)
            isCustomPaymentHistory = true
            callAPIHistoryPayment()
            //customPaymentTV.reloadData()
            
            self.viewFooter.isHidden = true
            self.viewFooterHeight.constant = 0
        }
    }
    
    func getBankInfo(){
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let url = APIs().getBankInfo_API
      
            
        CustomPaymentModel.shareInstence.getBankInfoData(url: url, completion: { data, msg in
                if data.status == 1{
                    self.bankInfoStruct = data
                    self.customPaymentTV.reloadData()
                }
                else{
                   // self.toastMessage(msg ?? "")
                    
                }
              //  CustomActivityIndicator2.shared.hide()
                
            })
    }
    
    func getBankChargesInfo(){
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let url = APIs().getBankCharges_API
      
            
        CustomPaymentModel.shareInstence.getBankChargesInfoData(url: url, completion: { data, msg in
                if data.status == 1{
                    self.bankChargesInfoStruct = data
                }
                else{
                    
                }
              //  CustomActivityIndicator2.shared.hide()
                
            })
    }
    
    func getPaymentModeInfo(){
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let url = APIs().getBankInfo_API
      
            
        CustomPaymentModel.shareInstence.getPaymentModeData(url: url, completion: { data, msg in
                if data.status == 1{
                    self.paymentModeStruct = data
                }
                else{
                   // self.toastMessage(msg ?? "")
                    
                }
               // CustomActivityIndicator2.shared.hide()
                
            })
    }
    
    
    
    func getNetBankingInfo(){
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let url = APIs().getPaymentMode_API
      
            
        CustomPaymentModel.shareInstence.getPaymentModeData(url: url, completion: { data, msg in
                if data.status == 1{
                    self.bankingInfoStruct = data
                    
                    let indexPath = IndexPath(row: 0, section: 1)
                    if let cell = self.customPaymentTV.cellForRow(at: indexPath) as? PaymentOptionTVC {
                        if let netBankInfo = self.bankingInfoStruct.details?.netBanking {
                            cell.netBankingData = netBankInfo
                            cell.banksCollectionView.reloadData()
                        }
                    }

                    
                }
                else{
                   // self.toastMessage(msg ?? "")
                    
                }
               // CustomActivityIndicator2.shared.hide()
                
            })
    }
    
    
    
    func openDropDown(dataArr:[String], anchorView:UIView, txtField : UITextField){
       var dropDown = DropDown()
        dropDown.anchorView = anchorView
        dropDown.dataSource = dataArr
        dropDown.backgroundColor = UIColor.whitClr
        dropDown.selectionBackgroundColor = UIColor.themeClr.withAlphaComponent(0.2)
        dropDown.shadowColor = UIColor(white: 0.6, alpha: 1)
        dropDown.shadowOpacity = 0.7
        dropDown.shadowRadius = 15
        dropDown.cellHeight = 40
        dropDown.height = 250
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
       

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            txtField.text = item

            if let bnkID = self.bankingInfoStruct.details?.netBanking?.allBanks?[index].bankID {
                self.selectedBankID  = bnkID
            }
          
            let indexPath = IndexPath(row: 0, section: 1)

            if let cell = self.customPaymentTV.cellForRow(at: indexPath) as? PaymentOptionTVC {
                if index < 2{
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    cell.selectedIndex(index: indexPath)
                    
                }
                else{
                    cell.selectedIndexPath = IndexPath()
                    cell.banksCollectionView.reloadData()
                }
                
            }
            
            dropDown.hide()

        }
        dropDown.show()
    }
    
    
    
    
    @IBAction func btnActionProceedPayment(_ sender:UIButton){
        
        switch self.paymentModeSelected {
        case "NEFT":
            var isDataCollect = false
            let indexPath = IndexPath(row: 0, section: 0)
            if let cell = self.customPaymentTV.cellForRow(at: indexPath) as? CustomInfoTVC {
                cell.customPymnt = self
                isDataCollect = cell.dataCollect()
                
            }
            
            
            let indexPath1 = IndexPath(row: 0, section: 1)
            if let cell = self.customPaymentTV.cellForRow(at: indexPath1) as? PaymentOptionTVC {
                cell.customPymnt = self
                isDataCollect =  cell.dataCollect()
                
            }
            
            if isDataCollect{
                callAPIProceedPayment()
            }
        case "CreditCard":
            PaymentManager.shared.upiName = name.uppercased()
            PaymentManager.shared.paymentType = "CreditCard"
            PaymentManager.shared.delegate = self
//            PaymentManager.shared.initiatePhonePeTransaction(from: self)
            self.callAPIWithPhonePeProceedPayment()
        case "NetBanking":
            PaymentManager.shared.paymentType = "NetBanking"
            PaymentManager.shared.paymentInstrumentbnkID = self.selectedBankID
            PaymentManager.shared.delegate = self
//            PaymentManager.shared.initiatePhonePeTransaction(from: self)
            self.callAPIWithPhonePeProceedPayment()
            
        case "UPI":
            
            PaymentManager.shared.upiName = self.selectedUPIName.uppercased()
            PaymentManager.shared.paymentType = "UPI"
            PaymentManager.shared.upiPackageName = self.selectedUPIBundl
            self.callAPIWithPhonePeProceedPayment()
            
        default:
           print("")
        }
        
        
        
    }
    
    
    func callAPIWithPhonePeProceedPayment(){
        var dataCollect = false
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.customPaymentTV.cellForRow(at: indexPath) as? CustomInfoTVC {
            cell.customPymnt = self
            self.remark = cell.textView.text
            self.amount = cell.txtAmount.text ?? ""
            
        }
      
        let url = APIs().proceedPayment_API
        let param :[String:Any] = [
            "amount": self.amount,
            "paymentMode": paymentModeSelected,
            "remark": self.remark,
            "submit": 1
        
        ]
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        CustomPaymentModel.shareInstence.proceedPaymentAPI(url: url, requestParam: param, completion: { data, msg in
            CustomActivityIndicator2.shared.hide()
            if data.status == 1{
                self.paymentINProcessStruct = data
                PaymentManager.shared.paymentINProcessStruct = data
                PaymentManager.shared.initiatePhonePeTransaction(from: self)
            }
            else{
                self.toastMessage(msg ?? "")
            }
           
            
        })
        
        
        
    }
    
    func callAPIProceedPayment(){
      
        let url = APIs().proceedPayment_API
        let param :[String:Any] = [
            "amount": self.amount,
            "paymentMode": paymentModeSelected, //'NEFT','DebitCard','CreditCard','NetBanking','UPI'
            "bankPaymentMethod": self.paymentMode,
            "bankUTRNo": self.checkNum,
            "bankPaymentDate": self.selectedDate,
            "bankNeftId": self.bankInfoStruct.details?[self.seletedBankInt].bankID ?? 0,
                // "currencyCode":"INR",
                // "currency":"₹",
                // "currencyExRate":"1",
            "remark": self.remark,
            "submit": 1 // 0 Or 1 for submission
        
        
        ]
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        CustomPaymentModel.shareInstence.proceedPaymentAPI(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.paymentINProcessStruct = data
                let storyBoard: UIStoryboard = UIStoryboard(name: "CustomPayment", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentInProgressVC") as! PaymentInProgressVC
                vc.checqNum = self.checkNum
                vc.paymentINProcessStruct = self.paymentINProcessStruct
                self.navigationController?.pushViewController(vc, animated: true)
                //self.navigationController?.popViewController(animated: true)
            }
            else{
                self.toastMessage(msg ?? "")
                //                self.isLoading = false
            }
            CustomActivityIndicator2.shared.hide()
            
        })
        
        
        
    }
    
    
    func callAPIHistoryPayment(){
        isLoading = true
        let url = APIs().historyPayment_API
        let param :[String:Any] = [
            "limit":self.pageLimit,
            "page":self.page
        ]
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        CustomPaymentModel.shareInstence.historyPaymentAPI(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
              //  print(data)
                self.isLoading = false
                self.customPaymentStruct = data
                self.customPaymentTV.reloadData()
                
                
                if self.customPaymentStruct.details?.history?.count ?? 0 > 11 {
                     self.page += 1
                 }
                
            }
            else{
                self.toastMessage(msg ?? "")
                self.isLoading = false
            }
            self.refreshControl.endRefreshing()
            CustomActivityIndicator2.shared.hide()
            
        })
        
        
        
    }
    


}



extension CustomPaymentVC : TransactionIDDelegate{
    func paymentTransactionID(transectionID: String, paymentStatus: String) {
        
        //print(paymentStatus)
        if let extractedMessage = extractMessage(from: paymentStatus) {
            print("Extracted message: \(extractedMessage)")
            
            if extractedMessage == "Request failed."{
                toastMessage(extractedMessage)
            }
            else{
                self.getPaymentStatus(orderID: transectionID)
            }
            
        } else {
            toastMessage("Request failed.")
        }
        
       
    }
    
  
    func getPaymentStatus(orderID : String){
      
        let url = APIs().customPayment_Status_API
        let param :[String:Any] = [
            "orderId": orderID
        ]
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        CustomPaymentModel.shareInstence.getpaymentStatusApi(url: url, requestParam: param, completion: { data, msg in
            CustomActivityIndicator2.shared.hide()
            if data.status == 1{
                self.paymentStatusDataStruct = data
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "CustomPayment", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentStatusVC") as! PaymentStatusVC
                vc.paymentStatusDataStruct = self.paymentStatusDataStruct
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self.toastMessage(msg ?? "")
            }
           
            
        })
        
        
        
    }
    
    func extractMessage(from input: String) -> String? {
        let pattern = #"message: \"(.*?)\""# // Regular expression pattern to find the message
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let nsString = input as NSString
            let results = regex.matches(in: input, options: [], range: NSRange(location: 0, length: nsString.length))
            
            if let match = results.first {
                return nsString.substring(with: match.range(at: 1))
            }
        }
        return nil
    }
    
    
}

extension CustomPaymentVC : UITableViewDataSource, UITableViewDelegate, CustomCellInfoDelegate, SingleSelectionButtonGroupDelegate{
  
    func didSelectButton(withTag tag: Int?) {
        
        //'NEFT','DebitCard','CreditCard','NetBanking','UPI'
        switch tag {
        case 0:
            self.paymentModeSelected = "NEFT"
        case 1:
            self.paymentModeSelected = "CreditCard"
        case 2:
            self.paymentModeSelected = "NetBanking"
        default:
            self.paymentModeSelected = String()
        }
        
        amountCalculation()
        //print(tag)
    }
    
    
    
    func textFieldDidEndEditing(cell: CustomInfoTVC, text: String) {
          print(text)
        self.amountTotal = text
        self.lblTotalAmount.text = "₹\(self.amountTotal)"
       }
    
    
    
    func amountCalculation(){
        let baseAmount: Double = Double(self.amountTotal) ?? 0
       
        switch self.paymentModeSelected {
        case "CreditCard":
           let percentage = self.bankChargesInfoStruct.details?.creditCard
            let calculatedAmount = baseAmount + (baseAmount * (percentage ?? 0)  / 100)
            
            self.lblTotalAmount.text = "₹\(calculatedAmount)"
        case "NetBanking":
            let percentage = self.bankChargesInfoStruct.details?.netBanking
            let calculatedAmount = baseAmount + (baseAmount * (percentage ?? 0) / 100)
            self.lblTotalAmount.text = "₹\(calculatedAmount)"
        case "UPI":
            let percentage = self.bankChargesInfoStruct.details?.upi
            let  calculatedAmount = baseAmount + (baseAmount * Double((percentage ?? 0 )) / 100)
            self.lblTotalAmount.text = "₹\(calculatedAmount)"
        default:
            self.lblTotalAmount.text = "₹\(self.amountTotal)"
        }
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isCustomPaymentHistory{
            return 1
        }
        else{
            
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCustomPaymentHistory{
            return self.customPaymentStruct.details?.history?.count ?? 0
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isCustomPaymentHistory{
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CustomInfoTVC.cellIdentifierCustomInfoTVC, for: indexPath) as! CustomInfoTVC
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: PaymentOptionTVC.cellIdentifierPaymentOptionTVC, for: indexPath) as! PaymentOptionTVC
                cell.selectionStyle = .none
                cell.buttonGroup.delegate = self
                
                cell.selectBankAction = {
                    if let allBnks = self.bankingInfoStruct.details?.netBanking?.allBanks {
                        var bankArr = [String]()
                        allBnks.enumerated().forEach{ (index, bank) in
                            bankArr.append(bank.bankName ?? "")
                        }
                        self.openDropDown(dataArr: bankArr, anchorView: cell.txtSelectedBnk, txtField: cell.txtSelectedBnk)
                    }
                  
                }
                
                cell.bnkCellTap = { tag in
                   
                        if let netBankInfo = self.bankingInfoStruct.details?.netBanking?.popularBanks {
                            // var selectedIndex = netBankInfo.popularBanks?[indexPath.row].img
                            self.selectedBankID  = netBankInfo[tag].bankID ?? ""
                            cell.txtSelectedBnk.text = netBankInfo[tag].bankName
                        }
                    
                }
                
                cell.btnAction = { tag in
                    self.isCellExpandedTag = tag
                  
                    if tag == 0 {
                        
                        self.isCellExpandedPaymentOption.toggle()
                        cell.paymentOptionViewHideShow(isShow: self.isCellExpandedPaymentOption)
                        cell.banksViewBG.isHidden = true
                        self.customPaymentTV.reloadData()
                        
                    }
                    else if tag == 2{
                        cell.paymentOptionBG.isHidden = true
                        self.isCellExpandedPaymentOption = false
                        self.isCellExpandedPaymentOption2.toggle()
                        cell.bnkViewHideShow(isShow: self.isCellExpandedPaymentOption2)
//                        if let netBankInfo = self.bankingInfoStruct.details?.netBanking {
//                            cell.netBankingData = netBankInfo
//                            cell.banksCollectionView.reloadData()
//                        }
                        
                       
                        self.customPaymentTV.reloadData()
                    }
                    else{
                        
                        cell.paymentOptionBG.isHidden = true
                        self.isCellExpandedPaymentOption = false
                        self.isCellExpandedPaymentOption2 = false
                       
                        cell.banksViewBG.isHidden = true
                        self.customPaymentTV.reloadData()
                    }
                    
                    let UPIIndexPath = IndexPath(row: 0, section: 2)
                    if let cell = self.customPaymentTV.cellForRow(at: UPIIndexPath) as? UPITVC {
                        cell.selectedIndexPath = nil
                        cell.collectionUPIApps.reloadData()
                    }
                }
                
                cell.lblIFSC.text = self.bankInfoStruct.details?.first?.ifsc
                cell.lblSWIFT.text = self.bankInfoStruct.details?.first?.swift
                cell.lblBranchName.text = self.bankInfoStruct.details?.first?.branchName
                cell.lblBankName.text = self.bankInfoStruct.details?.first?.bankName
                cell.lblAccountNum.text = self.bankInfoStruct.details?.first?.accountNumber
                
                cell.lblTitle1.text = self.bankInfoStruct.details?.first?.bank?.uppercased()
                cell.lblTitle2.text = self.bankInfoStruct.details?.last?.bank?.uppercased()
                
                
                cell.btnActionBanks = { tag in
                    self.seletedBankInt = tag
                    if tag == 0{
                        cell.lblIFSC.text = self.bankInfoStruct.details?.first?.ifsc
                        cell.lblSWIFT.text = self.bankInfoStruct.details?.first?.swift
                        cell.lblBranchName.text = self.bankInfoStruct.details?.first?.branchName
                        cell.lblBankName.text = self.bankInfoStruct.details?.first?.bankName
                        cell.lblAccountNum.text = self.bankInfoStruct.details?.first?.accountNumber
                    }
                    else{
                        cell.lblIFSC.text = self.bankInfoStruct.details?.last?.ifsc
                        cell.lblSWIFT.text = self.bankInfoStruct.details?.last?.swift
                        cell.lblBranchName.text = self.bankInfoStruct.details?.last?.branchName
                        cell.lblBankName.text = self.bankInfoStruct.details?.last?.bankName
                        cell.lblAccountNum.text = self.bankInfoStruct.details?.last?.accountNumber
                    }
                }
                
                cell.btnDate = {
                    self.customDatePicker.delegate = self
                    self.customDatePicker.showDatePicker(in: self)
                    
                }
                
                
                
                if  let imageURLfst = URL(string: self.bankInfoStruct.details?.first?.image ?? "") {
                    cell.btnBank1SBG.applyVerticalGradientBackgroundWithImageURL(colors: [UIColor.btnGradient1, UIColor.btnGradient2], imageURL: imageURLfst)
                    cell.imgViewBnk1.sd_setImage(with: imageURLfst, placeholderImage: nil, options: .highPriority, completed: nil)
                }
                
                
                if  let imageURLlst = URL(string: self.bankInfoStruct.details?.last?.image ?? "") {
                    cell.btnBank2BG.applyVerticalGradientBackgroundWithImageURL(colors: [UIColor.btnGradient1, UIColor.btnGradient2], imageURL: imageURLlst)
                    
                    cell.imgViewBnk2.sd_setImage(with: imageURLlst, placeholderImage: nil, options: .highPriority, completed: nil)
                    
                }
                
                cell.paymentModeAction = {
                    self.openDropDown(dataArr: ["Cheque","NEFT","RTGS","Wire Transfer", "Other"], anchorView: cell.txtPaymentMode, txtField: cell.txtPaymentMode)
                }
                
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: UPITVC.cellIdentifierUPITVC, for: indexPath) as! UPITVC
                cell.selectionStyle = .none
                cell.tapAction = { name, package in
                    self.lblTotalAmount.text = self.amount
                    
                    let payIndexPath = IndexPath(row: 0, section: 1)
                    if let cell = self.customPaymentTV.cellForRow(at: payIndexPath) as? PaymentOptionTVC {
                        cell.buttonGroup.clearSelection()
                        cell.btnNetBankSBG.borderColor = .clear
                        cell.btnRTGSBG.borderColor = .clear
                        cell.btnDebitCSBG.borderColor = .clear
                        cell.paymentOptionBG.isHidden = true
                        cell.banksViewBG.isHidden = true
                        self.isCellExpandedPaymentOption = false
                        self.isCellExpandedPaymentOption2 = false
                        self.customPaymentTV.reloadData()
                        
                       // self.customPaymentTV.reloadRows(at: [payIndexPath], with: .none)
                    }
                    
                    ///
                    self.paymentModeSelected = "UPI"
                    self.selectedUPIName = name
                    self.selectedUPIBundl = package
                    self.amountCalculation()
                    
                    if name == ""{
                        
                        self.lblTotalAmount.text = self.amount
                        self.customPaymentTV.reloadData()
                        // self.customPaymentTV.reloadRows(at: [payIndexPath], with: .none)
                    }
                }
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: OrderSummaryTVC.cellIdentifierOrderSummary, for: indexPath) as! OrderSummaryTVC
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTVC.cellIdentifierHistoryTVC, for: indexPath) as! HistoryTVC
            cell.selectionStyle = .none
            
            if let formattedDateString = convertDateString(self.customPaymentStruct.details?.history?[indexPath.row].createdAt ?? "") {
                cell.lblDateTime.text = formattedDateString
            }
            cell.lblTransactionID.text = self.customPaymentStruct.details?.history?[indexPath.row].transactionID ?? ""
            
            cell.lblStatus.text = self.customPaymentStruct.details?.history?[indexPath.row].paymentStatus ?? ""
            cell.lblAmount.text = self.customPaymentStruct.details?.history?[indexPath.row].amount ?? ""
            cell.lblMode.text = self.customPaymentStruct.details?.history?[indexPath.row].paymentMode ?? ""
            cell.lblNarration.text = self.customPaymentStruct.details?.history?[indexPath.row].description ?? ""
           
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isCustomPaymentHistory{
            
            switch indexPath.section {
            case 0:
                return 290
                
            case 1:
                
                switch self.isCellExpandedTag {
                case 0:
                    return isCellExpandedPaymentOption ? 650 : 190
                case 2:
                    return isCellExpandedPaymentOption2 ? 330 : 190
                default:
                    return 190
                }
                
                
            case 2:
                return 130
                
            case 3:
                return 358
                
            default:
                return 0
            }
        }
        else{
            return 180
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.customPaymentStruct.details?.history?.count ?? 0 > 11{
            
            if indexPath.row == self.customPaymentStruct.details?.history?.count ?? 0 - 1 && !isLoading {
                
                self.callAPIHistoryPayment()
                //fetchDamondData(page: self.page, limit: self.pageLimit, param: self.param)
            }
            
        }
    }
    
    
    
    func convertDateString(_ dateString: String) -> String? {
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
     
        dateFormatter.dateFormat = "yyyy/MM/dd, hh:mm:ss a"
      
        let formattedDateString = dateFormatter.string(from: date)
        
        return formattedDateString
    }
    
}


extension CustomPaymentVC : CustomDatePickerDelegate{
    func didSelectDate(date: String) {
            let indexPath = IndexPath(row: 0, section: 1)
            if let cell = self.customPaymentTV.cellForRow(at: indexPath) as? PaymentOptionTVC {
                cell.txtChecqDate.text = date
                
            }
     
    }
    
    
}
