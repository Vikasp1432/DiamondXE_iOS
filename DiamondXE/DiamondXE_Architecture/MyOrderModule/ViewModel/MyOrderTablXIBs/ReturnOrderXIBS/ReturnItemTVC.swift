//
//  ReturnItemTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/09/24.
//

import UIKit
import UIView_Shimmer

class ReturnItemTVC: UITableViewCell ,ShimmeringViewProtocol{
    
    static let cellIdentifierReturnItemTVC = String(describing: ReturnItemTVC.self)
    
    @IBOutlet var tableViewMultiItem: UITableView!
    @IBOutlet var tableViewMultiItemContraint: NSLayoutConstraint!
    @IBOutlet var viewDataBG : UIView!
    @IBOutlet var viewCerNoTime : UIView!
    
    @IBOutlet var viewDetails : UIView!
    @IBOutlet var viewSummary : UIView!
    @IBOutlet var viewTrackOrder : UIView!
    @IBOutlet var viewCancelOrder : UIView!
    
    
    @IBOutlet var lblOrderID : UILabel!
    @IBOutlet var lblDateTime : UILabel!
    @IBOutlet var lblOrderCnclTime : UILabel!
    
    @IBOutlet var lblDeliveryDate : UILabel!
    @IBOutlet var lblEligibleReturnDate : UILabel!
    
    @IBOutlet var btnViewPolicy : UIButton!

    var btnActionsManage : ((Int) -> Void) = { _ in}
    
    var diamondsInfo = [MyOrderDiamond]()
    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    
    var shimmeringAnimatedItems: [UIView] {
           [
            lblOrderID,
            lblDateTime,
            lblOrderCnclTime,
            viewDetails,
            viewSummary,
            viewTrackOrder,
            viewCancelOrder,
            tableViewMultiItem,
            lblDeliveryDate,
            lblEligibleReturnDate
          
            
           ]
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        viewDataBG.applyShadow()
        tableViewMultiItem.delegate = self
        tableViewMultiItem.dataSource = self
        // Initialization code
        tableViewMultiItem.register(UINib(nibName: CellMultiItemTV.cellIdentifierCellMultiItemTV, bundle: nil), forCellReuseIdentifier: CellMultiItemTV.cellIdentifierCellMultiItemTV)
        roundTopCorners(of: self.viewCerNoTime, radius: 10.0)
     
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
    
    func reloadData(diamonds : [MyOrderDiamond]){
        self.diamondsInfo = diamonds
        self.tableViewMultiItemContraint.constant = CGFloat(138 * diamonds.count)
        self.tableViewMultiItem.reloadData()
    }
    
    @IBAction func btnactionsInfo(_ sender : UIButton){
        self.btnActionsManage(sender.tag)
    }
    
}


extension ReturnItemTVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5//self.diamondsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellMultiItemTV.cellIdentifierCellMultiItemTV, for: indexPath) as! CellMultiItemTV
        cell.selectionStyle = .none
        
//        cell.imgDiamond.sd_setImage(with: URL(string: diamondsInfo[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
//      
//        cell.lblOrderStatus.text = diamondsInfo[indexPath.row].status
//        cell.lblShape.text = diamondsInfo[indexPath.row].shape
//        cell.lblCarat.text = diamondsInfo[indexPath.row].carat
//        cell.lblColor.text = diamondsInfo[indexPath.row].color
//        cell.lblClarity.text = diamondsInfo[indexPath.row].clarity
//        if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
//            let formattedNumber = formatNumberWithoutDeciml(Double(diamondsInfo[indexPath.row].totalPrice ?? "") ?? 0)
//            cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
//            
//        }
//        else{
//            let formattedNumber = formatNumberWithoutDeciml(Double(diamondsInfo[indexPath.row].totalPrice ?? "") ?? 0)
//            cell.lblPrice.text = "₹\(formattedNumber)"
//        }
//        cell.lblCertificateNo.text = "StockID : \(diamondsInfo[indexPath.row].stockID ?? "")"
//        if diamondsInfo[indexPath.row].category == "Natural"{
//            cell.lblDiaType.text = diamondsInfo[indexPath.row].category
//            cell.viewDiaType.backgroundColor = UIColor.goldenClr
//        }
//        else{
//            cell.lblDiaType.text = diamondsInfo[indexPath.row].category
//            cell.viewDiaType.backgroundColor = UIColor.green2
//        }
//        
        
        
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
