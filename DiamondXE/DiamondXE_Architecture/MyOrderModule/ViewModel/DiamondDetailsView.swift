//
//  DiamondDetailsView.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/09/24.
//

import UIKit
import UIView_Shimmer

class DiamondDetailsView: BaseViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
    @IBOutlet var tableViewItems : UITableView!
    @IBOutlet var tableViewItemsHeightContraint : NSLayoutConstraint!
    @IBOutlet var imgDiamond : UIImageView!
    @IBOutlet var iblTitle : UILabel!
    
    @IBOutlet var lblOrderID : UILabel!
    @IBOutlet var lblDateTime : UILabel!
    
    var count = Int()
    
    var orderDetails = OrderDetailsStruct()
    var currencyRateDetailObj = UserDefaultManager.shareInstence.retrieveCurrencyData()
    
    private var isLoading = true {
        didSet {
            tableViewItems.isUserInteractionEnabled = !isLoading
            tableViewItems.reloadData()
        }
    }
    
  
    init() {
        super.init(nibName: "DiamondDetailsView", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backViewTapped))
            backView.addGestureRecognizer(tapGesture)
        
        self.tableViewItems.delegate = self
        self.tableViewItems.dataSource = self
        
        tableViewItems.register(UINib(nibName: DiamondDetailsViewTVC.cellIdentifierDiamondDetailsViewTVC, bundle: nil), forCellReuseIdentifier: DiamondDetailsViewTVC.cellIdentifierDiamondDetailsViewTVC)
       
    }
    
    @objc private func backViewTapped() {
        hide()
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        
        // Set contentView's corner radius
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Round top corners only
        
        // Initially, move contentView off the screen (bottom)
        self.contentView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
    }
    
 
    func appear(sender: UIViewController, tag:Int) {
        sender.present(self, animated: false) {
            self.show()
            
            self.getOrderDetailsAPI(orderID: tag)
            //self.tableViewItems.isScrollEnabled = false
            self.tableViewItemsHeightContraint.constant = 250
          
            
        }
    }
    

    private func show() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
            self.backView.alpha = 1
            // Slide up the contentView from the bottom
            self.contentView.transform = .identity
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            // Slide down the contentView back to the bottom
            self.contentView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    
    
    func getOrderDetailsAPI(orderID : Int){
        
       // CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        self.isLoading = true
        let param : [String : Any] = [
            "orderId": orderID
            
        ]
        
        let url = APIs().getOrderDetails_API
        
        MyOrderDataModel.shareInstence.getOrderDetailsAPI(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
                self.orderDetails = data
                self.isLoading = false
               
                if self.orderDetails.details?.diamonds?.count == 1{
                    self.tableViewItems.isScrollEnabled = false
                    self.tableViewItemsHeightContraint.constant = 250
                }
                else if self.orderDetails.details?.diamonds?.count ?? 0 > 1{
                    self.tableViewItems.isScrollEnabled = true
                    self.tableViewItemsHeightContraint.constant = 500
                }
                self.tableViewItems.reloadData()
            }
            else{
                self.isLoading = false
                self.toastMessage(msg ?? "")
                
            }
            
            //CustomActivityIndicator2.shared.hide()
            
        })
        
        
    }
    


}


extension DiamondDetailsView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let  count = self.orderDetails.details?.diamonds {
            return count.count
        }
        else{
            if isLoading{
                return 1
            }
            else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiamondDetailsViewTVC.cellIdentifierDiamondDetailsViewTVC, for: indexPath) as! DiamondDetailsViewTVC
        cell.selectionStyle = .none
        cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
        
        let diamndInfo = self.orderDetails.details?.diamonds?[indexPath.row]
        
        cell.imgDiamond.sd_setImage(with: URL(string: diamndInfo?.diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
        
        self.lblOrderID.text = "Order-ID : \(self.orderDetails.details?.orderID ?? Int())"
        self.lblDateTime.text = self.orderDetails.details?.createdAt
        cell.lblShape.text = diamndInfo?.shape
        cell.lblShapeTop.text = diamndInfo?.shape
        cell.lblCarat.text = diamndInfo?.carat
        cell.lblColor.text = diamndInfo?.color
        cell.lblClarity.text = diamndInfo?.clarity
        cell.lblCertificateNo.text = diamndInfo?.stockID
        
        if diamndInfo?.category == "Natural"{
            cell.lblDiaType.text = diamndInfo?.category
            cell.viewDiaType.backgroundColor = UIColor.goldenClr
        }
        else{
            cell.lblDiaType.text = diamndInfo?.category
            cell.viewDiaType.backgroundColor = UIColor.green2
        }
        
        
        cell.lblType.text = diamndInfo?.growthType
        cell.lblCut.text = diamndInfo?.cutGrade
        cell.lblPolish.text = diamndInfo?.polish
        cell.lblSYM.text = diamndInfo?.symmetry
        cell.lblFLR.text = diamndInfo?.fluorescenceIntensity
        cell.lblLAB.text = diamndInfo?.certificateName
        cell.lblTable.text = diamndInfo?.tablePerc
        cell.lblDepth.text = diamndInfo?.depthPerc
        cell.lblLAB.text = diamndInfo?.certificateName

        if let currncySimbol = self.currencyRateDetailObj?.currencySymbol{
            let formattedNumber = formatNumberWithoutDeciml(Double(diamndInfo?.totalPrice ?? "") ?? 0)
            cell.lblTotalAmnt.text = "\(currncySimbol)\(formattedNumber)"
            
        }
        else{
            let formattedNumber = formatNumberWithoutDeciml(Double(diamndInfo?.totalPrice ?? "") ?? 0)
            cell.lblTotalAmnt.text = "₹\(formattedNumber)"
        }

        
        return cell
    }
    
    
}
