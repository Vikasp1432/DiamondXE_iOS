//
//  WalletHistoryVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 08/11/24.
//

import UIKit
import UIView_Shimmer

class WalletHistoryVC: BaseViewController {
    
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnCredit: UIButton!
    @IBOutlet weak var btnDebit: UIButton!
    @IBOutlet weak var lblWalletPoint: UILabel!

    @IBOutlet weak var tableWalletHistoryLisst: UITableView!
    
    private var isLoading = true {
        didSet {
            tableWalletHistoryLisst.isUserInteractionEnabled = !isLoading
            tableWalletHistoryLisst.reloadData()
        }
    }
    
    let refreshControl = UIRefreshControl()
    var walletHistryStruct = WalletHistoryStruct()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableWalletHistoryLisst.register(UINib(nibName: WalletHistoryTVC.cellIdentifierWalletHistoryTVC, bundle: nil), forCellReuseIdentifier: WalletHistoryTVC.cellIdentifierWalletHistoryTVC)
        btnAll.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        btnAll.setTitleColor(UIColor.whitClr, for: .normal)
        
        getOrderListAPI(transType: "")
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        walletHistryStruct = WalletHistoryStruct()
        switch sender.tag {
        case 0:
            btnCredit.clearGradient()
            btnDebit.clearGradient()
            btnCredit.setTitleColor(UIColor.themeClr, for: .normal)
            btnDebit.setTitleColor(UIColor.themeClr, for: .normal)
            btnAll.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnAll.setTitleColor(UIColor.whitClr, for: .normal)
            getOrderListAPI(transType: "")
        case 1 :
            btnCredit.clearGradient()
            btnAll.clearGradient()
            btnCredit.setTitleColor(UIColor.themeClr, for: .normal)
            btnAll.setTitleColor(UIColor.themeClr, for: .normal)
            btnDebit.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnDebit.setTitleColor(UIColor.whitClr, for: .normal)
            getOrderListAPI(transType: "debit")
        case 2 :
            btnAll.clearGradient()
            btnDebit.clearGradient()
            btnAll.setTitleColor(UIColor.themeClr, for: .normal)
            btnDebit.setTitleColor(UIColor.themeClr, for: .normal)

            btnCredit.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnCredit.setTitleColor(UIColor.whitClr, for: .normal)
            getOrderListAPI(transType: "credit")

        default :
            print(sender.tag)
        }
    }
    
    
    
    func getOrderListAPI(transType:String){

        self.isLoading = true
        let param : [String : Any] = [
            "limit": "15",
            "page" : self.page,
            "transType" : transType
            
        ]
        
        let url = APIs().getWalletHistory_API
        
        HomeDataModel().getWalletHistory(param: param, url: url,  completion: { data, msg in
            if data.status == 1 {
                self.walletHistryStruct = data
                self.isLoading = false
                self.tableWalletHistoryLisst.reloadData()
                
//                if self.walletHistryStruct.details?.count ?? 0 < 1 {
//                    self.imgNoDataFnd.isHidden = false
//                }
//                else{
//                    self.imgNoDataFnd.isHidden = true
//                }
                
                self.lblWalletPoint.text = "Available Wallet Points: \(self.walletHistryStruct.details?.walletPoints ?? 0)"
                if self.walletHistryStruct.details?.history?.count ?? 0 > 14 {
                     self.page += 1
                 }
            }
            else{
                self.isLoading = false
                self.toastMessage(msg ?? "")
                
            }
            
        })
        
        
    }


}

extension WalletHistoryVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //return self.walletHistryStruct.details?.history?.count ?? 0
        if let  count = self.walletHistryStruct.details?.history {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: WalletHistoryTVC.cellIdentifierWalletHistoryTVC, for: indexPath) as! WalletHistoryTVC
        cell.selectionStyle = .none
        cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .viewBGClr)
        
        if let localDateString = convertUTCToLocal(dateString: self.walletHistryStruct.details?.history?[indexPath.row].createdAt ?? "") {
            cell.lblDateTime.text = localDateString
        } else {
            print("Conversion failed")
        }
     
        cell.lblTransactionID.text = self.walletHistryStruct.details?.history?[indexPath.row].orderID ?? ""
        
        cell.lblStatus.text = self.walletHistryStruct.details?.history?[indexPath.row].status ?? ""
       
        cell.lblMode.text = "\(self.walletHistryStruct.details?.history?[indexPath.row].walletPoints ?? 0)"
        cell.lblNarration.text = self.walletHistryStruct.details?.history?[indexPath.row].remark ?? ""
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.walletHistryStruct.details?.history?.count ?? 0 > 13{
            
            if indexPath.row == self.walletHistryStruct.details?.history?.count ?? 0 - 1 && !isLoading {
                self.getOrderListAPI(transType: "" )
            }
            
        }
    }
    
}
