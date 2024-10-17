//
//  ReturnOrderItemReasionsTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 04/10/24.
//

import UIKit
import UIView_Shimmer
import DTTextField

class ReturnOrderItemReasionsTVC: UITableViewCell  , ShimmeringViewProtocol{
    
    static let cellIdentifierReturnOrderItemReasionsTVC = String(describing: ReturnOrderItemReasionsTVC.self)
    
    @IBOutlet var tableViewMultiItem: UITableView!
    @IBOutlet var tableViewMultiItemContraint: NSLayoutConstraint!
    @IBOutlet var viewDataBG : UIView!
    
  
    
    @IBOutlet var btnWallet : UIButton!
    @IBOutlet var btnPaymentSource : UIButton!
  
    
  
    var cancelletionTag = 0
    
    var btnActionsManageSelectionItem : ((Int) -> Void) = { _ in}
    
    var btnActionsManage : ((Int, Int, DTTextField) -> Void) = { _,_,_   in}
    
    var btnActionsCancel : (([MyOrderDiamond], [Bool]) -> Void) = { _,_  in}
    
    var btnActionsProcesses : ((Int) -> Void) = { _ in}

    
    var diamondsInfo = [ReturnOrderCheckoutDiamond]()
    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    
    
    var selectedItemsArray: [ReturnOrderCheckoutDiamond] = []
    var selectedState: [Bool] = []
    
    var shimmeringAnimatedItems: [UIView] {
           [
//            lblOrderID,
//            lblDateTime
           // tableViewMultiItem
            
           ]
       }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        viewDataBG.applyShadow()
    
        tableViewMultiItem.delegate = self
        tableViewMultiItem.dataSource = self
        // Initialization code
        tableViewMultiItem.register(UINib(nibName: ReturnItemImgVideoTVC.cellIdentifierReturnItemImgVideoTVC, bundle: nil), forCellReuseIdentifier: ReturnItemImgVideoTVC.cellIdentifierReturnItemImgVideoTVC)
       // roundTopCorners(of: self.viewCerNoTime, radius: 10.0)
     
    }
    
    
    func roundTopCorners(of view: UIView, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func reloadData(){
//        self.tableViewMultiItemContraint.constant = CGFloat(430 * 2)
//        self.tableViewMultiItem.reloadData()
//    }
    
    func reloadData(diamonds : [ReturnOrderCheckoutDiamond]){
        self.diamondsInfo = diamonds

        selectedState = Array(repeating: true, count: diamonds.count)
        selectedItemsArray = diamonds

        self.tableViewMultiItemContraint.constant = CGFloat(430 * diamonds.count)

        self.tableViewMultiItem.reloadData()
    }
    

    
    @IBAction func btnactionsInfo(_ sender : UIButton){
       // self.btnActionsManage(sender.tag)
    }
    
    @IBAction func btnactionsReturnType(_ sender : UIButton){
        
        if sender.tag == 0{
            cancelletionTag = 0
            self.btnWallet.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            self.btnPaymentSource.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
           // self.btnActionsCancel(selectedItemsArray)
        }
        else if sender.tag == 1{
            cancelletionTag = 1
            self.btnWallet.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
            self.btnPaymentSource.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            
        }
//        else{
//            self.btnActionsProcesses(sender.tag)
//        }
        self.btnActionsProcesses(sender.tag)
      
       
    }
    
}


extension ReturnOrderItemReasionsTVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.diamondsInfo.count
//        return 2//self.diamondsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReturnItemImgVideoTVC.cellIdentifierReturnItemImgVideoTVC, for: indexPath) as! ReturnItemImgVideoTVC
        cell.selectionStyle = .none
        cell.imgDia.sd_setImage(with: URL(string: diamondsInfo[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
         
        cell.lblShape.text = diamondsInfo[indexPath.row].shape
        cell.lblCarat.text = "\(diamondsInfo[indexPath.row].carat ?? "")ct"
        cell.lblClr.text = diamondsInfo[indexPath.row].color
        cell.lblClarity.text = diamondsInfo[indexPath.row].clarity
        
//
//
        cell.tapAction  = { tag in
            self.btnActionsManage(indexPath.row, tag, cell.txtResion)
        }
     
        
        return cell
    }
    

    
    
    func formatNumberWithoutDeciml(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
}
