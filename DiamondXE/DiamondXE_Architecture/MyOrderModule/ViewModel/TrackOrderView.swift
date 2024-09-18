//
//  TrackOrderView.swift
//  DiamondXE
//
//  Created by iOS Developer on 16/09/24.
//

import UIKit



class TrackOrderView: BaseViewController {
   
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
    var orderID = Int()
    
    @IBOutlet var tableViewItems : UITableView!
    @IBOutlet var tableViewItemsHeightContraint : NSLayoutConstraint!
//    @IBOutlet var imgDiamond : UIImageView!
    @IBOutlet var viewDashLine : UIView!
    
    
    @IBOutlet var lblOrderID : UILabel!
    @IBOutlet var lblDateTime : UILabel!
    @IBOutlet weak var imgPlaceOrder: UIImageView!
    @IBOutlet weak var imgConfirmOrder: UIImageView!
    @IBOutlet weak var imgReadyShipment: UIImageView!
    @IBOutlet weak var imgShipmentPickedUp: UIImageView!
    @IBOutlet weak var imgProductDispatch: UIImageView!
    @IBOutlet weak var imgDeliverd: UIImageView!
    
    @IBOutlet weak var viewOrderPlacedView: UIView!
    @IBOutlet weak var lblOrderPlacedTitle: UILabel!
    @IBOutlet weak var lblOrderPlacedSubTitle: UILabel!
    @IBOutlet weak var viewConfirmdPlacedView: UIView!
    @IBOutlet weak var lblConfirmdPlacedTitle: UILabel!
    @IBOutlet weak var lblConfirmdPlacedSubTitle: UILabel!
    @IBOutlet weak var viewReadyShipPlacedView: UIView!
    @IBOutlet weak var lblReadyShipPlacedTitle: UILabel!
    @IBOutlet weak var lblReadyShipPlacedSubTitle: UILabel!
    @IBOutlet weak var viewShipmentPickupPlacedView: UIView!
    @IBOutlet weak var lblShipmentPickupPlacedTitle: UILabel!
    @IBOutlet weak var lblShipmentPickupPlacedSubTitle: UILabel!
    @IBOutlet weak var viewProductDispatchedPlacedView: UIView!
    @IBOutlet weak var lblProductDispatchedPlacedTitle: UILabel!
    @IBOutlet weak var lblProductDispatchedPlacedSubTitle: UILabel!
    @IBOutlet weak var viewDeliverdPlacedView: UIView!
    @IBOutlet weak var lblDeliverdPlacedTitle: UILabel!
    @IBOutlet weak var lblDeliverdPlacedSubTitle: UILabel!
    
    
    
    @IBOutlet weak var lblPlacedDate: UILabel!
    @IBOutlet weak var lblInProgressDate: UILabel!
    @IBOutlet weak var lblOutOfDelDate: UILabel!
    @IBOutlet weak var lblDeliverdDate: UILabel!
    @IBOutlet weak var lblReturnDate: UILabel!
    
    var trackOrderInfo = TrackOrderStruct()
    
    
    init() {
        super.init(nibName: "TrackOrderView", bundle: nil)
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
        
   
        self.createDashedLine(view: viewDashLine)
      

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
    
    
    func appear(sender: UIViewController, orderID:Int) {
        sender.present(self, animated: false) {
            self.show()
            //self.count = tag
            self.createDashedLine(view: self.viewDashLine, lineColor: .red, lineWidth: 2, dashPattern: [5, 3])
            self.getTrackOrderInfoAPI(orderID: orderID)
            
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
    
    
    func getTrackOrderInfoAPI(orderID : Int){
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
       
        let param : [String : Any] = [
            "orderId": orderID
            
        ]
        
        let url = APIs().getORderTracking_API
        
        MyOrderDataModel.shareInstence.getOrderTrackingAPI(url: url, requestParam: param, completion: { data, msg in
            if data.status == 1{
                self.trackOrderInfo = data
                self.setupData()
               
            }
            else{
             
                self.toastMessage(msg ?? "")
                
            }
            
            CustomActivityIndicator2.shared.hide()
            
        })
        
        
    }
    
    //
    func createDashedLine(view: UIView, lineColor: UIColor = .black, lineWidth: CGFloat = 1, dashPattern: [NSNumber] = [6, 3]) {
        let dashedLayer = CAShapeLayer()
        dashedLayer.strokeColor = lineColor.cgColor
        dashedLayer.lineWidth = lineWidth
        dashedLayer.lineDashPattern = dashPattern
        dashedLayer.fillColor = nil
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: view.bounds.height / 2), CGPoint(x: view.bounds.width, y: view.bounds.height / 2)])
        dashedLayer.path = path
        
        view.layer.addSublayer(dashedLayer)
    }
    
    
    func setupData(){
        
        self.lblOrderID.text = "Order ID : \(self.trackOrderInfo.details?.orderID ?? 0)"
        self.lblDateTime.text = self.trackOrderInfo.details?.trackingDetails?.date ?? ""
        self.lblOrderPlacedTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[0].status
        self.lblOrderPlacedSubTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[0].note
        
        self.lblPlacedDate.text = self.trackOrderInfo.details?.trackingDetails?.history?[0].datetime
        
        self.lblReadyShipPlacedTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[1].status
        self.lblReadyShipPlacedSubTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[1].note
        
        self.lblInProgressDate.text = self.trackOrderInfo.details?.trackingDetails?.history?[1].datetime
       
        self.lblShipmentPickupPlacedTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[2].status
        self.lblShipmentPickupPlacedSubTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[2].note
        
        self.lblOutOfDelDate.text = self.trackOrderInfo.details?.trackingDetails?.history?[2].datetime
        
        self.lblProductDispatchedPlacedTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[3].status
        self.lblProductDispatchedPlacedSubTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[3].note
        
        self.lblDeliverdDate.text = self.trackOrderInfo.details?.trackingDetails?.history?[3].datetime
        
        self.lblDeliverdPlacedTitle.text = self.trackOrderInfo.details?.trackingDetails?.history?[4].status
        self.lblReturnDate.text = self.trackOrderInfo.details?.trackingDetails?.history?[4].note
        
        self.lblDeliverdDate.text = self.trackOrderInfo.details?.trackingDetails?.history?[4].datetime
        
        switch self.trackOrderInfo.details?.trackingDetails?.currentStatusCode {
        case 1:
            
            self.lblOrderPlacedTitle.textColor = UIColor.lblHeading
            self.lblOrderPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblPlacedDate.textColor = UIColor.lblHeading
            
            self.lblReadyShipPlacedTitle.textColor = UIColor.clrGray
            self.lblReadyShipPlacedSubTitle.isHidden = true
            self.lblInProgressDate.isHidden = true
           
            self.lblShipmentPickupPlacedTitle.textColor = UIColor.clrGray
            self.lblShipmentPickupPlacedSubTitle.isHidden = true
            self.lblOutOfDelDate.isHidden = true
            
            self.lblProductDispatchedPlacedTitle.textColor = UIColor.clrGray
            self.lblProductDispatchedPlacedSubTitle.isHidden = true
            self.lblDeliverdDate.isHidden = true
            
            self.lblDeliverdPlacedTitle.textColor = UIColor.clrGray
            self.lblReturnDate.isHidden = true
            self.lblDeliverdPlacedSubTitle.isHidden = true
            
            
            self.imgPlaceOrder.tintColor = UIColor.whitClr
            self.imgPlaceOrder.backgroundColor = UIColor.tabSelectClr
            
//            self.imgConfirmOrder.tintColor = UIColor.clrGray
//            self.imgConfirmOrder.backgroundColor = UIColor.whitClr
            self.imgReadyShipment.tintColor = UIColor.clrGray
            self.imgReadyShipment.backgroundColor = UIColor.whitClr
            self.imgShipmentPickedUp.tintColor = UIColor.clrGray
            self.imgShipmentPickedUp.backgroundColor = UIColor.whitClr
            self.imgProductDispatch.tintColor = UIColor.clrGray
            self.imgProductDispatch.backgroundColor = UIColor.whitClr
            self.imgDeliverd.tintColor = UIColor.clrGray
            self.imgDeliverd.backgroundColor = UIColor.whitClr

        case 2:
            
            self.lblOrderPlacedTitle.textColor = UIColor.lblHeading
            self.lblOrderPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblPlacedDate.textColor = UIColor.lblHeading
            
            self.lblReadyShipPlacedTitle.textColor = UIColor.lblHeading
            self.lblReadyShipPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblInProgressDate.textColor = UIColor.lblHeading
            
            
           
            self.lblShipmentPickupPlacedTitle.textColor = UIColor.clrGray
            self.lblShipmentPickupPlacedSubTitle.isHidden = true
            self.lblOutOfDelDate.isHidden = true
            
            self.lblProductDispatchedPlacedTitle.textColor = UIColor.clrGray
            self.lblProductDispatchedPlacedSubTitle.isHidden = true
            self.lblDeliverdDate.isHidden = true
            
            self.lblDeliverdPlacedTitle.textColor = UIColor.clrGray
            self.lblReturnDate.isHidden = true
            self.lblDeliverdDate.isHidden = true
            
            
            self.imgPlaceOrder.tintColor = UIColor.clrGray
            self.imgPlaceOrder.backgroundColor = UIColor.whitClr
//            self.imgConfirmOrder.tintColor = UIColor.clrGray
//            self.imgConfirmOrder.backgroundColor = UIColor.whitClr
            self.imgReadyShipment.tintColor = UIColor.whitClr
            self.imgReadyShipment.backgroundColor = UIColor.tabSelectClr
            
            self.imgShipmentPickedUp.tintColor = UIColor.clrGray
            self.imgShipmentPickedUp.backgroundColor = UIColor.whitClr
            self.imgProductDispatch.tintColor = UIColor.clrGray
            self.imgProductDispatch.backgroundColor = UIColor.whitClr
            self.imgDeliverd.tintColor = UIColor.clrGray
            self.imgDeliverd.backgroundColor = UIColor.whitClr
        case 3:
            
            self.lblOrderPlacedTitle.textColor = UIColor.lblHeading
            self.lblOrderPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblPlacedDate.textColor = UIColor.lblHeading
            
            self.lblReadyShipPlacedTitle.textColor = UIColor.lblHeading
            self.lblReadyShipPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblInProgressDate.textColor = UIColor.lblHeading
            
            
           
            self.lblShipmentPickupPlacedTitle.textColor = UIColor.lblHeading
            self.lblShipmentPickupPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblOutOfDelDate.textColor = UIColor.lblHeading
            
            self.lblProductDispatchedPlacedTitle.textColor = UIColor.clrGray
            self.lblProductDispatchedPlacedSubTitle.isHidden = true
            self.lblDeliverdDate.isHidden = true
            
            self.lblDeliverdPlacedTitle.textColor = UIColor.clrGray
            self.lblReturnDate.isHidden = true
            self.lblDeliverdDate.isHidden = true
            
            self.imgPlaceOrder.tintColor = UIColor.clrGray
            self.imgPlaceOrder.backgroundColor = UIColor.whitClr
//            self.imgConfirmOrder.tintColor = UIColor.clrGray
//            self.imgConfirmOrder.backgroundColor = UIColor.whitClr
            self.imgReadyShipment.tintColor = UIColor.clrGray
            self.imgReadyShipment.backgroundColor = UIColor.whitClr
            self.imgShipmentPickedUp.tintColor = UIColor.whitClr
            self.imgShipmentPickedUp.backgroundColor = UIColor.tabSelectClr
            
            self.imgProductDispatch.tintColor = UIColor.clrGray
            self.imgProductDispatch.backgroundColor = UIColor.whitClr
            self.imgDeliverd.tintColor = UIColor.clrGray
            self.imgDeliverd.backgroundColor = UIColor.whitClr
        case 4:
            self.lblOrderPlacedTitle.textColor = UIColor.lblHeading
            self.lblOrderPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblPlacedDate.textColor = UIColor.lblHeading
            
            self.lblReadyShipPlacedTitle.textColor = UIColor.lblHeading
            self.lblReadyShipPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblInProgressDate.textColor = UIColor.lblHeading
            
            
           
            self.lblShipmentPickupPlacedTitle.textColor = UIColor.lblHeading
            self.lblShipmentPickupPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblOutOfDelDate.textColor = UIColor.lblHeading
            
            self.lblProductDispatchedPlacedTitle.textColor = UIColor.lblHeading
            self.lblProductDispatchedPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblDeliverdDate.textColor = UIColor.lblHeading
            
            self.lblDeliverdPlacedTitle.textColor = UIColor.clrGray
            self.lblReturnDate.isHidden = true
            self.lblDeliverdDate.isHidden = true
            
            self.imgPlaceOrder.tintColor = UIColor.clrGray
            self.imgPlaceOrder.backgroundColor = UIColor.whitClr
//            self.imgConfirmOrder.tintColor = UIColor.clrGray
//            self.imgConfirmOrder.backgroundColor = UIColor.whitClr
            self.imgReadyShipment.tintColor = UIColor.clrGray
            self.imgReadyShipment.backgroundColor = UIColor.whitClr
            self.imgShipmentPickedUp.tintColor = UIColor.clrGray
            self.imgShipmentPickedUp.backgroundColor = UIColor.whitClr
            self.imgProductDispatch.tintColor = UIColor.whitClr
            self.imgProductDispatch.backgroundColor = UIColor.tabSelectClr
            
            self.imgDeliverd.tintColor = UIColor.clrGray
            self.imgDeliverd.backgroundColor = UIColor.whitClr
        case 5:
            
            self.lblOrderPlacedTitle.textColor = UIColor.lblHeading
            self.lblOrderPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblPlacedDate.textColor = UIColor.lblHeading
            
            self.lblReadyShipPlacedTitle.textColor = UIColor.lblHeading
            self.lblReadyShipPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblInProgressDate.textColor = UIColor.lblHeading
            
            
           
            self.lblShipmentPickupPlacedTitle.textColor = UIColor.lblHeading
            self.lblShipmentPickupPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblOutOfDelDate.textColor = UIColor.lblHeading
            
            self.lblProductDispatchedPlacedTitle.textColor = UIColor.lblHeading
            self.lblProductDispatchedPlacedSubTitle.textColor = UIColor.lblHeading
            self.lblDeliverdDate.textColor = UIColor.lblHeading
            
            self.lblDeliverdPlacedTitle.textColor = UIColor.lblHeading
            self.lblReturnDate.textColor = UIColor.lblHeading
            self.lblDeliverdDate.textColor = UIColor.lblHeading
            
            self.imgPlaceOrder.tintColor = UIColor.clrGray
            self.imgPlaceOrder.backgroundColor = UIColor.tabSelectClr
//            self.imgConfirmOrder.tintColor = UIColor.clrGray
//            self.imgConfirmOrder.backgroundColor = UIColor.whitClr
            self.imgReadyShipment.tintColor = UIColor.clrGray
            self.imgReadyShipment.backgroundColor = UIColor.whitClr
            self.imgShipmentPickedUp.tintColor = UIColor.clrGray
            self.imgShipmentPickedUp.backgroundColor = UIColor.whitClr
            self.imgProductDispatch.tintColor = UIColor.clrGray
            self.imgProductDispatch.backgroundColor = UIColor.whitClr
            self.imgDeliverd.tintColor = UIColor.whitClr
            self.imgDeliverd.backgroundColor = UIColor.tabSelectClr
            
            
        default:
            print("")
        }
    }
    
    
}
