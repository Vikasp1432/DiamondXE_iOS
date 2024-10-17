//
//  CancelOrderWithResionViewController.swift
//  DiamondXE
//
//  Created by iOS Developer on 20/09/24.
//

import UIKit
import UIView_Shimmer

class CancelOrderWithResionViewController: BaseViewController, DataReceiver{
    
    func receiveData(_ data: [Int : [MyOrderDiamond]]) {
        // Use the received data here
        orderDIC = data
    }
    
    var orderID = Int()
    var cancellationType = "full"
    var cnDiamonsList = [String]()
    var indexPath : IndexPath?
    var reloadIND = true
    
    @IBOutlet var tableViewItemSummary:UITableView!
    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    
    private var isLoading = true {
        didSet {
            tableViewItemSummary.isUserInteractionEnabled = !isLoading
            tableViewItemSummary.reloadData()
        }
    }
    
    var orderSummryData = CancelOrderPriceManageStruct()
    var resionsStruct = ResionsDataStruct()
    var orderDIC : [Int : [MyOrderDiamond]] = [:]
    var selectedItemsArray: [MyOrderDiamond] = []
    var selectedState: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableViewItemSummary.register(UINib(nibName: CancelOrderItemListTVC.cellIdentifierCancelOrderItemListTVC, bundle: nil), forCellReuseIdentifier: CancelOrderItemListTVC.cellIdentifierCancelOrderItemListTVC)
        
        tableViewItemSummary.register(UINib(nibName: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC)
        
        tableViewItemSummary.register(UINib(nibName: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC)
        
        tableViewItemSummary.register(UINib(nibName: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC)
        
//        print(DiamondXEEnvironment.marchantID)
//        print(DiamondXEEnvironment.saltKey)
        
        self.orderID = self.orderDIC.keys.first ?? 0
        self.getCancelOrderSummaryDetailsAPI()
       // self.getOrderListAPI(orderId: self.orderDIC.keys.first ?? 0)
        self.getCancelResionAPI()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
//    func getOrderListAPI(orderId:Int){
//        
//        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
//        self.isLoading = true
//        let param : [String : Any] = [
//            "orderId": orderId
//            
//        ]
//        
//        let url = APIs().getOrderSummery_API
//        
//        MyOrderDataModel.shareInstence.getCancelOrderSummaryManageAPI(url: url, requestParam: param, completion: { data, msg in
//            if data.status == 1 {
//                self.orderSummryData = data
//                self.isLoading = false
//                self.tableViewItemSummary.reloadData()
//              
//            }
//            else{
//                self.isLoading = false
//                self.toastMessage(msg ?? "")
//                
//            }
//            
//            //CustomActivityIndicator2.shared.hide()
//            
//        })
//        
//        
//    }
    
    func getCancelResionAPI(){
        let url = APIs().getCancelResion_API
        MyOrderDataModel.shareInstence.getResionsAPI(url: url, requestParam: [:], completion: { data, msg in
            if data.status == 1 {
                self.resionsStruct = data
            }

        })
    }
    
    
    
    func getCancelOrderSummaryDetailsAPI(){
    
        self.isLoading = true
        let param : [String : Any] = [
            "orderId":self.orderID,
            "type":self.cancellationType,  // full, partial
            "diamonds": cnDiamonsList.joined(separator: ",")
            
        ]
        
        let url = APIs().canceleOrdrSubmit_API
        
        MyOrderDataModel.shareInstence.getCancelOrderSummaryManageAPI(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1 {
              //  self.orderSummryData = CancelOrderPriceManageStruct()
                self.orderSummryData = data
                self.isLoading = false
               //self.tableViewItemSummary.reloadData()
                
                let totalSections = 4  // Assuming there are 4 sections in the table view
                var indexSet = IndexSet()

                // Add sections 1, 2, and 3 to the IndexSet (excluding section 0)
                for section in 1..<totalSections {
                    indexSet.insert(section)
                }

                // Reload all sections except the first one
                self.tableViewItemSummary.reloadSections(indexSet, with: .automatic)
                
               
//                
//                if let indexPath = self.indexPath{
//                    if let cell = self.tableViewItemSummary.cellForRow(at: indexPath) as? CancelOrderItemListTVC {
//                        cell.selectedItemsArray = self.selectedItemsArray
//                        cell.selectedState = self.selectedState
//                        self.tableViewItemSummary.reloadRows(at: [indexPath], with: .none)
//
//                    }
//
//                }
//                else{
//                    self.tableViewItemSummary.reloadData()
//                }
                
                
              
            }
            else{
                self.isLoading = false
                self.toastMessage(msg ?? "")
                
            }
            
            //CustomActivityIndicator2.shared.hide()
            
        })
        
        
    }
    

}

extension CancelOrderWithResionViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CancelOrderItemListTVC.cellIdentifierCancelOrderItemListTVC, for: indexPath) as! CancelOrderItemListTVC
            cell.selectionStyle = .none
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
           
            if let dataArr = self.orderDIC.values.first{
                if reloadIND{
                    cell.reloadData(diamonds: dataArr)
                  }
            }
            
            cell.btnActionsProcesses = { tag in
                if tag  == 0{
                    self.reloadIND = true
                    self.cancellationType = "full"
                    self.getCancelOrderSummaryDetailsAPI()
                }
                else if tag  == 1{
                    self.reloadIND = false
                    self.cancellationType = "partial"
                    
                }
                if tag  == 2{
                    
                }
                else if  tag == 3{
                    let showView = CancellationAlertView()
                    showView.navController = self
                    showView.resionsStruct = self.resionsStruct
                    showView.cancellationType = self.cancellationType
                    showView.cnDiamonsList = self.cnDiamonsList
                    showView.orderID = self.orderSummryData.details?.orderID ?? 0
                    showView.appear(sender: self, tag: 1)
                }
            }
            
            
            cell.btnActionsCancel = { data, selectedBool in
                print(data)
                self.reloadIND = false
                self.cnDiamonsList.removeAll()
                data.enumerated().forEach{ index, value in
                   
                    self.cnDiamonsList.append(value.certificateNo ?? "")
                        
//                        self.selectedState = selectedBool
//                        self.selectedItemsArray = data
//                        self.indexPath = indexPath
//                        cell.selectedItemsArray = data
//                        cell.selectedState = selectedBool
                    
                }
                
                self.getCancelOrderSummaryDetailsAPI()
               
            }
           
            cell.lblOrderID.text = "Order ID : \(self.orderSummryData.details?.orderID ?? 0)"
            
            if let localDateString = convertUTCToLocal(dateString: self.orderSummryData.details?.orderDate ?? "") {
                cell.lblDateTime.text = localDateString
            } else {
                print("Conversion failed")
            }
           // cell.lblDateTime.text = self.orderSummryData.details?.orderDate

            
            return cell
        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC, for: indexPath) as! ItemsSummaryPriceTVC
//            cell.selectionStyle = .none
//            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
//            
//            cell.lblDiaPrice.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
//            cell.lblGrandTotal.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
//            cell.lblSubTotal.text = "\(self.orderSummryData.details?.currencySymbol ?? "")\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
//          
//            return cell
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, for: indexPath) as! ItemsSummaryAllInfoTVC
            cell.selectionStyle = .none
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
            cell.lblTitle.text = "Cancel Order Summary"

            if let currencySymbol = self.currencyRateDetailObj?.currencySymbol {
                // Set all labels with formatted values using the provided currency symbol
                cell.lblDiamondPrice.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["sub_total"] ?? 0)))"
                cell.lblCouponDiscount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["coupon_discount"] ?? 0)))"
                cell.lblShippingHandling.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["shipping_charge"] ?? 0)))"
                cell.lblPlatformFee.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["platform_fee"] ?? 0)))"
                cell.lblTotalCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["total_charges"] ?? 0)))"
                cell.lblOtherTaxes.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["total_charge_tax"] ?? 0)))"
                cell.lblDiamondsTAX.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["tax"] ?? 0)))"
                cell.lblTotalTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["total_taxes"] ?? 0)))"
                cell.lblSubTotal.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["total_amount"] ?? 0)))"
                cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["wallet_points"] ?? 0)))"
                cell.lblBNKCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["bank_charge"] ?? 0)))"
                cell.lblFinalAmount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["final_amount"] ?? 0)))"
                
            } else {
                // Set all labels with formatted values using default currency symbol "₹"
                if let currencySymbol = self.orderSummryData.details?.currencySymbol{
                    cell.lblDiamondPrice.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["sub_total"] ?? 0)))"
                    cell.lblCouponDiscount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["coupon_discount"] ?? 0)))"
                    cell.lblShippingHandling.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["shipping_charge"] ?? 0)))"
                    cell.lblPlatformFee.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["platform_fee"] ?? 0)))"
                    cell.lblTotalCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["total_charges"] ?? 0)))"
                    cell.lblOtherTaxes.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["total_charge_tax"] ?? 0)))"
                    cell.lblDiamondsTAX.text = "-"//"\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["tax"] ?? 0)))"
                    cell.lblTotalTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["total_taxes"] ?? 0)))"
                    cell.lblSubTotal.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["total_amount"] ?? 0)))"
                    cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["wallet_points"] ?? 0)))"
                    cell.lblBNKCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["bank_charge"] ?? 0)))"
                    cell.lblFinalAmount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.cancelOrderSummery?["final_amount"] ?? 0)))"
                }
            }

            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, for: indexPath) as! ItemsSummaryAllInfoTVC
            cell.selectionStyle = .none
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
            
            cell.lblTitle.text = "Order Summary"
            if let currencySymbol = self.currencyRateDetailObj?.currencySymbol {
                // Set all labels with formatted values using the provided currency symbol
                cell.lblDiamondPrice.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                cell.lblCouponDiscount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                cell.lblShippingHandling.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                cell.lblPlatformFee.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                cell.lblTotalCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                cell.lblOtherTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalChargeTax ?? "") ?? 0))"
                cell.lblDiamondsTAX.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.tax ?? "") ?? 0))"
                cell.lblTotalTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                cell.lblSubTotal.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                cell.lblBNKCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                cell.lblFinalAmount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                
            } else {
                // Set all labels with formatted values using default currency symbol "₹"
                cell.lblDiamondPrice.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                cell.lblCouponDiscount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                cell.lblShippingHandling.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                cell.lblPlatformFee.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                cell.lblTotalCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                cell.lblOtherTaxes.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalChargeTax ?? "") ?? 0))"
                cell.lblDiamondsTAX.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.tax ?? "") ?? 0))"
                cell.lblTotalTaxes.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                cell.lblSubTotal.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                cell.lblBNKCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                cell.lblFinalAmount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
            }

            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC, for: indexPath) as! ItemsSummaryAddressesInfoTVC
            cell.selectionStyle = .none
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
            cell.lblUTRCheckNo.text = self.orderSummryData.details?.totalCharge
            cell.lblOrderStatus.text = self.orderSummryData.details?.orderStatus
           
            if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
                let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0)
                cell.lblAmount.text = "\(currncySimbol)\(formattedNumber)"
                
            }
            else{
                let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0)
                cell.lblAmount.text = "₹\(formattedNumber)"
            }
            
            cell.lblOrderPlaced.text = self.orderSummryData.details?.orderDate
            cell.lblDeliveryDate.text = self.orderSummryData.details?.deliveryDate
            cell.lblPaymentMode.text = self.orderSummryData.details?.paymentMode
            cell.lblShippingAddress.text = self.orderSummryData.details?.userDetails?.shippingAddress
            cell.lblBillingAddress.text = self.orderSummryData.details?.userDetails?.billingAddress
            cell.lblContactNo.text = "Contact no. - \(self.orderSummryData.details?.userDetails?.userMobile ?? "")"
            cell.lblEmail.text = "Email : \(self.orderSummryData.details?.userDetails?.userEmail ?? "")"
            
            return cell
        }
       
    }
    
    


}
