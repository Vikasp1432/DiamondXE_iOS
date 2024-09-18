//
//  ItemsSummaryVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/09/24.
//

import UIKit
import UIView_Shimmer

class ItemsSummaryVC: BaseViewController, DataReceiver {
    
    func receiveData(_ data: [Int : [MyOrderDiamond]]) {
        // Use the received data here
        orderDIC = data
    }
    
    @IBOutlet var tableViewItemSummary:UITableView!
    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    
    private var isLoading = true {
        didSet {
            tableViewItemSummary.isUserInteractionEnabled = !isLoading
            tableViewItemSummary.reloadData()
        }
    }
    
    var orderSummryData = OrderSummaryStruct()
    var orderDIC : [Int : [MyOrderDiamond]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableViewItemSummary.register(UINib(nibName: ItemSummaryDiamondsList.cellIdentifierItemSummaryDiamondsList, bundle: nil), forCellReuseIdentifier: ItemSummaryDiamondsList.cellIdentifierItemSummaryDiamondsList)
        
        tableViewItemSummary.register(UINib(nibName: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC)
        
        tableViewItemSummary.register(UINib(nibName: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC)
        
        tableViewItemSummary.register(UINib(nibName: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC, bundle: nil), forCellReuseIdentifier: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC)
        
      
        self.getOrderListAPI(orderId: self.orderDIC.keys.first ?? 0)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func getOrderListAPI(orderId:Int){
        
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        self.isLoading = true
        let param : [String : Any] = [
            "orderId": orderId
            
        ]
        
        let url = APIs().getOrderSummery_API
        
        MyOrderDataModel.shareInstence.getOrderSummaryAPI(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1 {
                self.orderSummryData = data
                self.isLoading = false
                self.tableViewItemSummary.reloadData()
                
              
            }
            else{
                self.isLoading = false
                self.toastMessage(msg ?? "")
                
            }
            
            //CustomActivityIndicator2.shared.hide()
            
        })
        
        
    }
    

}

extension ItemsSummaryVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemSummaryDiamondsList.cellIdentifierItemSummaryDiamondsList, for: indexPath) as! ItemSummaryDiamondsList
            cell.selectionStyle = .none
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
            
            if let dataArr = self.orderDIC.values.first{
                cell.reloadData(diamonds: dataArr)
            }
           
           
            cell.lblOrderID.text = "Order ID : \(self.orderSummryData.details?.orderID ?? 0)"
            cell.lblDateTime.text = self.orderSummryData.details?.createdAt

            
            return cell
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryPriceTVC.cellIdentifierItemsSummaryPriceTVC, for: indexPath) as! ItemsSummaryPriceTVC
//            cell.selectionStyle = .none
//            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAllInfoTVC.cellIdentifierItemsSummaryAllInfoTVC, for: indexPath) as! ItemsSummaryAllInfoTVC
            cell.selectionStyle = .none
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
            
            
            if let currencySymbol = self.currencyRateDetailObj?.currencySymbol {
                // Set all labels with formatted values using the provided currency symbol
                cell.lblDiamondPrice.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                cell.lblCouponDiscount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                cell.lblShippingHandling.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                cell.lblPlatformFee.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                cell.lblTotalCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                cell.lblOtherTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalChargeTax ?? "") ?? 0))"
                cell.lblDiamondsTAX.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.crTotalTax ?? "") ?? 0))"
                cell.lblTotalTaxes.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                cell.lblSubTotal.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                cell.lblBNKCharges.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                cell.lblFinalAmount.text = "\(currencySymbol)\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
                
            } else {
                // Set all labels with formatted values using default currency symbol "₹"
                cell.lblDiamondPrice.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalAmount ?? "") ?? 0))"
                cell.lblCouponDiscount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.couponDiscount ?? "") ?? 0))"
                cell.lblShippingHandling.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.shippingCharge ?? "") ?? 0))"
                cell.lblPlatformFee.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.platformFee ?? "") ?? 0))"
                cell.lblTotalCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalCharge ?? "") ?? 0))"
                cell.lblOtherTaxes.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalChargeTax ?? "") ?? 0))"
                cell.lblDiamondsTAX.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.crTotalTax ?? "") ?? 0))"
                cell.lblTotalTaxes.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.totalTaxes ?? "") ?? 0))"
                cell.lblSubTotal.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.subTotal ?? "") ?? 0))"
                cell.lblWalletPoints.text = "\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.walletPoints ?? "") ?? 0))"
                cell.lblBNKCharges.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.bankCharge ?? "") ?? 0))"
                cell.lblFinalAmount.text = "₹\(formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0))"
            }

            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsSummaryAddressesInfoTVC.cellIdentifierItemsSummaryAddressesInfoTVC, for: indexPath) as! ItemsSummaryAddressesInfoTVC
            cell.selectionStyle = .none
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
            cell.lblUTRCheckNo.text = self.orderSummryData.details?.specialInstruction
            cell.lblOrderStatus.text = self.orderSummryData.details?.orderStatus
           
            if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
                let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0)
                cell.lblAmount.text = "\(currncySimbol)\(formattedNumber)"
                
            }
            else{
                let formattedNumber = formatNumberWithoutDeciml(Double(self.orderSummryData.details?.finalAmount ?? "") ?? 0)
                cell.lblAmount.text = "₹\(formattedNumber)"
            }
            
            cell.lblOrderPlaced.text = self.orderSummryData.details?.paymentReceivedDate
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
