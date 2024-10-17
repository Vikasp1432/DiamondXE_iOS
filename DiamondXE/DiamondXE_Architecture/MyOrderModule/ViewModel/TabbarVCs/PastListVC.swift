//
//  PastListVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 11/09/24.
//

import UIKit
import XLPagerTabStrip

class PastListVC: BaseViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        //return itemInfo
        return IndicatorInfo(title: "Past")
    }
   
    @IBOutlet var tableViewPast: UITableView!
    @IBOutlet var imgNoDataFnd: UIImageView!

    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    private var isLoading = true {
        didSet {
            tableViewPast.isUserInteractionEnabled = !isLoading
            tableViewPast.reloadData()
        }
    }
    var orderListData  = MyOrderDataStruct()
    var page = 1
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPast.register(UINib(nibName: ReturnItemTVC.cellIdentifierReturnItemTVC, bundle: nil), forCellReuseIdentifier: ReturnItemTVC.cellIdentifierReturnItemTVC)
        
        tableViewPast.register(UINib(nibName: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC, bundle: nil), forCellReuseIdentifier: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC)
        tableViewPast.register(UINib(nibName: MultiItemListTVC.cellIdentifierMultiItemListTVC, bundle: nil), forCellReuseIdentifier: MultiItemListTVC.cellIdentifierMultiItemListTVC)
        self.imgNoDataFnd.isHidden = true
        getOrderListAPI()
        self.configureRefreshControl()
    }
    
    
    // pull to refresh
    func configureRefreshControl() {
            // Add the refresh control to your table view
            tableViewPast.refreshControl = refreshControl
        self.page = 1
            //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        }
    
    @objc private func refreshData(_ sender: Any) {
        // Refresh your data here
        getOrderListAPI()
    }
    
    func getOrderListAPI(){
        
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        self.isLoading = true
        let param : [String : Any] = [
            "limit": "15",
            "page" : self.page,
            "orderType" : "Past"
            
        ]
        
        let url = APIs().getOrderList_API
        
        MyOrderDataModel.shareInstence.getOrderListAPI(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1 {
                self.orderListData = data
                self.isLoading = false
                self.tableViewPast.reloadData()
                if self.orderListData.details?.count ?? 0 < 1 {
                    self.imgNoDataFnd.isHidden = false
                }
                else{
                    self.imgNoDataFnd.isHidden = true
                }
                if self.orderListData.details?.count ?? 0 > 14 {
                     self.page += 1
                 }
            }
            else{
                self.isLoading = false
                self.toastMessage(msg ?? "")
                
            }
            
            //CustomActivityIndicator2.shared.hide()
            self.refreshControl.endRefreshing()
        })
        
        
    }
 

}

extension PastListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let  count = self.orderListData.details {
            return count.count
        }
        else{
            if isLoading{
                return 15
            }
            else{
                return 0
            }
        }
       // return 3
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//     
//        if let diamonds = self.orderListData.details?[indexPath.row].diamonds{
//            if diamonds.count > 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: MultiItemListTVC.cellIdentifierMultiItemListTVC, for: indexPath) as! MultiItemListTVC
//                cell.selectionStyle = .none
//                cell.lblCnclBy.isHidden = true
//                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
//                
//                let diamndInfo = self.orderListData.details?[indexPath.row]
//                cell.lblOrderID.text = "Order-ID : \(diamndInfo?.orderID ?? Int())"
//                if let localDateString = convertUTCToLocal(dateString: diamndInfo?.createdAt ?? "") {
//                    cell.lblDateTime.text = localDateString
//                } else {
//                    print("Conversion failed")
//                }
//                //cell.lblDateTime.text = diamndInfo?.createdAt
//                
//                
//                if (diamndInfo?.timeLeftForCancel) == nil || diamndInfo?.timeLeftForCancel == ""{
//                    cell.lblOrderCnclTime.isHidden = true
//                    cell.viewCancelOrder.isHidden = true
//                }
//                else{
////                    self.timerManager = TimerForCancelItem(timeString: diamndInfo?.timeLeftForCancel ?? "", label: cell.lblOrderCnclTime)
////                    self.timerManager?.delegate = self
////                    cell.lblOrderCnclTime.isHidden = false
//                    
//                    cell.lblOrderCnclTime.isHidden = false
//                    cell.lblOrderCnclTime.text = diamndInfo?.timeLeftForCancel ?? ""
//                    cell.viewCancelOrder.isHidden = false
//                   
//                    
//                }
//                
//                cell.viewCancelOrder.isHidden = true
//                cell.viewTrackOrder.isHidden = true
//                
//                cell.btnActionsManage = { tag in
//                    switch tag {
//                    case 0:
//                        let bottomSheetVC = DiamondDetailsView()
//                        bottomSheetVC.appear(sender: self, tag: diamndInfo?.orderID ?? Int())
//                    case 1:
//                      
//                        if let diamonds = diamndInfo?.diamonds{
//                            self.navigationManager(ItemsSummaryVC.self, storyboardName: "MyOrder", storyboardID: "ItemsSummaryVC", data: 
//                                                    [diamndInfo?.orderID ?? Int() : diamonds])
//                        }
//                        
//                   
//                    default:
//                        print(tag)
//                    }
//                }
//                
//                if let diamndArr = diamndInfo?.diamonds{
//                    cell.reloadData(diamonds: diamndArr)
//                }
//              
//               
//                return cell
//            }
//            else{
//                let cell = tableView.dequeueReusableCell(withIdentifier: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC, for: indexPath) as! BuyItemInfoTVC
//                cell.selectionStyle = .none
//                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
//                let diamndInfo = self.orderListData.details?[indexPath.row]
//                cell.lblCnclBy.isHidden = true
//                cell.imgDiamond.sd_setImage(with: URL(string: diamndInfo?.diamonds?.first?.diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
//                
//                cell.lblOrderID.text = "Order-ID : \(diamndInfo?.orderID ?? Int())"
//                
//                if let localDateString = convertUTCToLocal(dateString: diamndInfo?.createdAt ?? "") {
//                    cell.lblDateTime.text = localDateString
//                } else {
//                    print("Conversion failed")
//                }
//                
//              //  cell.lblDateTime.text = diamndInfo?.createdAt
//                cell.lblOrderStatus.text = diamndInfo?.orderStatus
//                cell.lblShape.text = diamndInfo?.diamonds?.first?.shape
//                cell.lblCarat.text = diamndInfo?.diamonds?.first?.carat
//               
//                cell.lblColor.text = diamndInfo?.diamonds?.first?.color
//                cell.lblClarity.text = diamndInfo?.diamonds?.first?.clarity
//                cell.lblCertificateNo.text = "Certificate No : \(diamndInfo?.diamonds?.first?.certificateNo ?? "")"
//                
//                if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
//                    let formattedNumber = formatNumberWithoutDeciml(Double(diamndInfo?.diamonds?.first?.subTotal ?? "") ?? 0)
//                    cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
//                    
//                }
//                else{
//                    let formattedNumber = formatNumberWithoutDeciml(Double(diamndInfo?.diamonds?.first?.subTotal ?? "") ?? 0)
//                    cell.lblPrice.text = "₹\(formattedNumber)"
//                }
//                
//                
//                
//                if diamndInfo?.diamonds?.first?.category == "Natural"{
//                    cell.lblDiaType.text = diamndInfo?.diamonds?.first?.category
//                    cell.viewDiaType.backgroundColor = UIColor.goldenClr
//                }
//                else{
//                    cell.lblDiaType.text = diamndInfo?.diamonds?.first?.category
//                    cell.viewDiaType.backgroundColor = UIColor.green2
//                }
//
//                
//                if (diamndInfo?.timeLeftForCancel) == nil || diamndInfo?.timeLeftForCancel == ""{
//                    cell.lblOrderCnclTime.isHidden = true
//                    cell.viewCancelOrder.isHidden = true
//                }
//                else{
//
//                    cell.lblOrderCnclTime.isHidden = false
//                    cell.lblOrderCnclTime.text = diamndInfo?.timeLeftForCancel ?? ""
//                    
//                    cell.viewCancelOrder.isHidden = false
//                  
//                    
//                }
//                
//                cell.viewCancelOrder.isHidden = true
//                cell.viewTrackOrder.isHidden = true
//                cell.btnActionsManage = { tag in
//                    switch tag {
//                    case 0:
//                        let bottomSheetVC = DiamondDetailsView()
//                        bottomSheetVC.appear(sender: self, tag: diamndInfo?.orderID ?? Int())
//                    case 1:
//                        //self.navigationManager(storybordName: "MyOrder", storyboardID: "ItemsSummaryVC", controller: ItemsSummaryVC())
//                        if let diamonds = diamndInfo?.diamonds{
//                            self.navigationManager(ItemsSummaryVC.self, storyboardName: "MyOrder", storyboardID: "ItemsSummaryVC", data: [diamndInfo?.orderID ?? Int() : diamonds])
//                        }
//                        
//                        
//                   
//                    default:
//                        print(tag)
//                    }
//                }
//                return cell
//            }
//            
//        }
//        else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC, for: indexPath) as! BuyItemInfoTVC
//            cell.selectionStyle = .none
//            cell.contentView.isUserInteractionEnabled = true
//            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
//            return cell
//        }
//        
//      
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.orderListData.details?.count ?? 0 > 14{
            
            if indexPath.row == self.orderListData.details?.count ?? 0 - 1 && !isLoading {
                getOrderListAPI()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReturnItemTVC.cellIdentifierReturnItemTVC, for: indexPath) as! ReturnItemTVC
        cell.selectionStyle = .none
        cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
        
        let diamndInfo = self.orderListData.details?[indexPath.row]
        cell.lblOrderID.text = "Order-ID : \(diamndInfo?.orderID ?? Int())"
        if let localDateString = convertUTCToLocal(dateString: diamndInfo?.createdAt ?? "") {
            cell.lblDateTime.text = localDateString
        } else {
            print("Conversion failed")
        }
        if let deliveryDate = convertUTCToLocal(dateString: diamndInfo?.deliveryDate ?? "") {
            cell.lblDeliveryDate.text = "Delivery Date : \(deliveryDate)"
        } else {
            print("Conversion failed")
        }
        
        if diamndInfo?.isReturnable == 1{
            cell.viewTrackOrder.isHidden = false
        }
        else{
            cell.viewTrackOrder.isHidden = true
        }
        
        
        
        if let elgblRetrunDate = convertUTCToLocal(dateString: diamndInfo?.returnEligbleDate ?? "") {
           
            cell.lblEligibleReturnDate.text = "Eligible for return till : \(elgblRetrunDate)"
        } else {
           // cell.viewTrackOrder.isHidden = true
            cell.lblEligibleReturnDate.text = "Eligible for return till : --"
        }
        
        cell.btnActionsPolicy = { tag in
            var tagV = VCTags()
            tagV.tagVC = 21
            self.navigationManager(WKWebViewVC.self, storyboardName: "Dashboard", storyboardID: "WKWebViewVC", data: tagV)
        }
        
        cell.btnActionsManage = { tag in
            switch tag {
            case 0:
                print("")
                let bottomSheetVC = DiamondDetailsView()
                bottomSheetVC.appear(sender: self, tag: diamndInfo?.orderID ?? Int())
            case 1:
                print("")
                if let diamonds = diamndInfo?.diamonds{
                    self.navigationManager(ItemsSummaryVC.self, storyboardName: "MyOrder", storyboardID: "ItemsSummaryVC", data:
                                            [diamndInfo?.orderID ?? Int() : diamonds])
                }
                
                
            default:
                if let diamonds = diamndInfo?.diamonds{
                    self.navigationManager(ReturnOderderVC.self, storyboardName: "MyOrder", storyboardID: "ReturnOderderVC", data: [diamndInfo?.orderID ?? Int() : diamonds])
                }
                
                
               // self.navigationManager(storybordName: "MyOrder", storyboardID: "ReturnOderderVC", controller: ReturnOderderVC())
                
            }
        }
        //        cell.reloadData()
        if let diamndArr = diamndInfo?.diamonds{
            cell.reloadData(diamonds: diamndArr)
        }
        //
        
        return cell
        
        
    }
}
