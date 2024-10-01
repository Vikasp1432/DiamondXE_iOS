//
//  CancelOrderItemListTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 18/09/24.
//

import UIKit
import UIView_Shimmer

class CancelOrderItemListTVC: UITableViewCell , ShimmeringViewProtocol{
    
    static let cellIdentifierCancelOrderItemListTVC = String(describing: CancelOrderItemListTVC.self)
    
    @IBOutlet var tableViewMultiItem: UITableView!
    @IBOutlet var tableViewMultiItemContraint: NSLayoutConstraint!
    @IBOutlet var viewDataBG : UIView!
    @IBOutlet var viewCerNoTime : UIView!
    
    @IBOutlet var lblOrderID : UILabel!
    @IBOutlet var lblDateTime : UILabel!
    
    @IBOutlet var btnFullCancel : UIButton!
    @IBOutlet var btnPartialCancel : UIButton!
    @IBOutlet var btnCancel : UIButton!
    @IBOutlet var btnProcessed : UIButton!
    
    @IBOutlet var viewCancllnType : UIView!
    @IBOutlet var viewCancllnTypeHeight : NSLayoutConstraint!
    
    var cancelletionTag = 0
    
    var btnActionsManageSelectionItem : ((Int) -> Void) = { _ in}
    
    var btnActionsManage : ((Int) -> Void) = { _ in}
    
    var btnActionsCancel : (([MyOrderDiamond], [Bool]) -> Void) = { _,_  in}
    
    var btnActionsProcesses : ((Int) -> Void) = { _ in}

    
    var diamondsInfo = [MyOrderDiamond]()
    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    
    
    var selectedItemsArray: [MyOrderDiamond] = []
    var selectedState: [Bool] = []
    
    var shimmeringAnimatedItems: [UIView] {
           [
            lblOrderID,
            lblDateTime
           // tableViewMultiItem
            
           ]
       }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        viewDataBG.applyShadow()
        btnProcessed.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
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
        
        
        selectedState = Array(repeating: true, count: diamonds.count)
        selectedItemsArray = diamonds
        
        self.tableViewMultiItemContraint.constant = CGFloat(138 * diamonds.count)
        
        if self.diamondsInfo.count <= 1{
            self.viewCancllnType.isHidden = true
            self.viewCancllnTypeHeight.constant = 0
            
        }
        else{
            self.viewCancllnType.isHidden = false
            self.viewCancllnTypeHeight.constant = 50
        }
        
        self.tableViewMultiItem.reloadData()
    }
    

    
    @IBAction func btnactionsInfo(_ sender : UIButton){
        self.btnActionsManage(sender.tag)
    }
    
    @IBAction func btnactionsCancleTypeAndProcessed(_ sender : UIButton){
        
        if sender.tag == 0{
            cancelletionTag = 0
            self.btnFullCancel.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            self.btnPartialCancel.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
           // self.btnActionsCancel(selectedItemsArray)
        }
        else if sender.tag == 1{
            cancelletionTag = 1
            self.btnFullCancel.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
            self.btnPartialCancel.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            
        }
//        else{
//            self.btnActionsProcesses(sender.tag)
//        }
        self.btnActionsProcesses(sender.tag)
      
        tableViewMultiItem.reloadData()
       
    }
    
}


extension CancelOrderItemListTVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.diamondsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellMultiItemTV.cellIdentifierCellMultiItemTV, for: indexPath) as! CellMultiItemTV
        cell.selectionStyle = .none
        cell.imgDiamond.sd_setImage(with: URL(string: diamondsInfo[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
      
        cell.lblOrderStatus.text = diamondsInfo[indexPath.row].status
        cell.lblShape.text = diamondsInfo[indexPath.row].shape
        cell.lblCarat.text = diamondsInfo[indexPath.row].carat
        cell.lblColor.text = diamondsInfo[indexPath.row].color
        cell.lblClarity.text = diamondsInfo[indexPath.row].clarity
        if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
            let formattedNumber = formatNumberWithoutDeciml(Double(diamondsInfo[indexPath.row].totalPrice ?? "") ?? 0)
            cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
            
        }
        else{
            let formattedNumber = formatNumberWithoutDeciml(Double(diamondsInfo[indexPath.row].totalPrice ?? "") ?? 0)
            cell.lblPrice.text = "₹\(formattedNumber)"
        }
        cell.lblCertificateNo.text = diamondsInfo[indexPath.row].stockID
        if diamondsInfo[indexPath.row].category == "Natural"{
            cell.lblDiaType.text = diamondsInfo[indexPath.row].category
            cell.viewDiaType.backgroundColor = UIColor.goldenClr
        }
        else{
            cell.lblDiaType.text = diamondsInfo[indexPath.row].category
            cell.viewDiaType.backgroundColor = UIColor.green2
        }
        
        
        if cancelletionTag == 0{
            cell.btnSelected.isHidden = true
        }
        else{
            cell.btnSelected.isHidden = false
        }
        
        let isSelected = selectedState[indexPath.row]
        cell.configure( isSelected: isSelected)


        cell.checkboxButtonAction = { [weak self] in
            guard let self = self else { return }
            self.toggleSelection(at: indexPath)
            self.btnActionsCancel(selectedItemsArray, self.selectedState)
        }
        
     
        
        return cell
    }
    
    
    func toggleSelection(at indexPath: IndexPath) {
        let isSelected = selectedState[indexPath.row]
        selectedState[indexPath.row] = !isSelected
        
        let item = self.diamondsInfo[indexPath.row]
        if selectedState[indexPath.row] {
            selectedItemsArray.append(item) // Add item if selected
        } else {
            selectedItemsArray.removeAll { $0.stockID == item.stockID }
        }
        
        tableViewMultiItem.reloadRows(at: [indexPath], with: .none)
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
