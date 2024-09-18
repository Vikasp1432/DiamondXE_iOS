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
    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    private var isLoading = true {
        didSet {
            tableViewPast.isUserInteractionEnabled = !isLoading
            tableViewPast.reloadData()
        }
    }
    var orderListData  = MyOrderDataStruct()
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
      //  tableViewPast.register(UINib(nibName: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC, bundle: nil), forCellReuseIdentifier: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC)
        
        tableViewPast.register(UINib(nibName: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC, bundle: nil), forCellReuseIdentifier: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC)
        tableViewPast.register(UINib(nibName: MultiItemListTVC.cellIdentifierMultiItemListTVC, bundle: nil), forCellReuseIdentifier: MultiItemListTVC.cellIdentifierMultiItemListTVC)
        
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
                
                if self.orderListData.details?.count ?? 0 > 14 {
                     self.page += 1
                 }
            }
            else{
                self.isLoading = false
                self.toastMessage(msg ?? "")
                
            }
            
            //CustomActivityIndicator2.shared.hide()
            
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
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if let diamonds = self.orderListData.details?[indexPath.row].diamonds{
            if diamonds.count > 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: MultiItemListTVC.cellIdentifierMultiItemListTVC, for: indexPath) as! MultiItemListTVC
                cell.selectionStyle = .none
                
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
                
                let diamndInfo = self.orderListData.details?[indexPath.row]
                cell.lblOrderID.text = "Order-ID : \(diamndInfo?.orderID ?? Int())"
                cell.lblDateTime.text = diamndInfo?.createdAt
                
                
                if (diamndInfo?.timeLeftForCancel) == nil || diamndInfo?.timeLeftForCancel == ""{
                    cell.lblOrderCnclTime.isHidden = true
                    cell.viewCancelOrder.isHidden = true
                }
                else{
//                    self.timerManager = TimerForCancelItem(timeString: diamndInfo?.timeLeftForCancel ?? "", label: cell.lblOrderCnclTime)
//                    self.timerManager?.delegate = self
//                    cell.lblOrderCnclTime.isHidden = false
                    
                    cell.lblOrderCnclTime.isHidden = false
                    cell.lblOrderCnclTime.text = diamndInfo?.timeLeftForCancel ?? ""
                    cell.viewCancelOrder.isHidden = false
                   
                    
                }
                
                cell.btnActionsManage = { tag in
                    switch tag {
                    case 0:
                        let bottomSheetVC = DiamondDetailsView()
                        bottomSheetVC.appear(sender: self, tag: diamndInfo?.orderID ?? Int())
                    case 1:
                      
                        if let diamonds = diamndInfo?.diamonds{
                            self.navigationManager(ItemsSummaryVC.self, storyboardName: "MyOrder", storyboardID: "ItemsSummaryVC", data: [diamndInfo?.orderID ?? Int() : diamonds])
                        }
                        
                   
                    default:
                        print(tag)
                    }
                }
                
                if let diamndArr = diamndInfo?.diamonds{
                    cell.reloadData(diamonds: diamndArr)
                }
              
               
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC, for: indexPath) as! BuyItemInfoTVC
                cell.selectionStyle = .none
                cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
                let diamndInfo = self.orderListData.details?[indexPath.row]
                
                cell.imgDiamond.sd_setImage(with: URL(string: diamndInfo?.diamonds?.first?.diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
                
                cell.lblOrderID.text = "Order-ID : \(diamndInfo?.orderID ?? Int())"
                cell.lblDateTime.text = diamndInfo?.createdAt
                cell.lblOrderStatus.text = diamndInfo?.orderStatus
                cell.lblShape.text = diamndInfo?.diamonds?.first?.shape
                cell.lblCarat.text = diamndInfo?.diamonds?.first?.carat
               
                cell.lblColor.text = diamndInfo?.diamonds?.first?.color
                cell.lblClarity.text = diamndInfo?.diamonds?.first?.clarity
                cell.lblCertificateNo.text = diamndInfo?.diamonds?.first?.stockID
                
                if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
                    let formattedNumber = formatNumberWithoutDeciml(Double(diamndInfo?.diamonds?.first?.totalPrice ?? "") ?? 0)
                    cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
                    
                }
                else{
                    let formattedNumber = formatNumberWithoutDeciml(Double(diamndInfo?.diamonds?.first?.totalPrice ?? "") ?? 0)
                    cell.lblPrice.text = "₹\(formattedNumber)"
                }
                
                
                
                if diamndInfo?.diamonds?.first?.category == "Natural"{
                    cell.lblDiaType.text = diamndInfo?.diamonds?.first?.category
                    cell.viewDiaType.backgroundColor = UIColor.goldenClr
                }
                else{
                    cell.lblDiaType.text = diamndInfo?.diamonds?.first?.category
                    cell.viewDiaType.backgroundColor = UIColor.green2
                }

                
                if (diamndInfo?.timeLeftForCancel) == nil || diamndInfo?.timeLeftForCancel == ""{
                    cell.lblOrderCnclTime.isHidden = true
                    cell.viewCancelOrder.isHidden = true
                }
                else{

                    cell.lblOrderCnclTime.isHidden = false
                    cell.lblOrderCnclTime.text = diamndInfo?.timeLeftForCancel ?? ""
                    
                    cell.viewCancelOrder.isHidden = false
                  
                    
                }
                
                
                cell.btnActionsManage = { tag in
                    switch tag {
                    case 0:
                        let bottomSheetVC = DiamondDetailsView()
                        bottomSheetVC.appear(sender: self, tag: diamndInfo?.orderID ?? Int())
                    case 1:
                        //self.navigationManager(storybordName: "MyOrder", storyboardID: "ItemsSummaryVC", controller: ItemsSummaryVC())
                        if let diamonds = diamndInfo?.diamonds{
                            self.navigationManager(ItemsSummaryVC.self, storyboardName: "MyOrder", storyboardID: "ItemsSummaryVC", data: [diamndInfo?.orderID ?? Int() : diamonds])
                        }
                        
                        
                   
                    default:
                        print(tag)
                    }
                }
                return cell
            }
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyItemInfoTVC.cellIdentifierBuyItemInfoTVC, for: indexPath) as! BuyItemInfoTVC
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = true
            cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
            return cell
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.orderListData.details?.count ?? 0 > 14{
            
            if indexPath.row == self.orderListData.details?.count ?? 0 - 1 && !isLoading {
                getOrderListAPI()
            }
            
        }
    }
}
