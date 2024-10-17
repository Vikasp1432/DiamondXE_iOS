//
//  OrderSummeryWithItemTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/09/24.
//

import UIKit

class OrderSummeryWithItemTVC: UITableViewCell {
    
    static let cellIdentifierOrderSummeryWithItemTVC = String(describing: OrderSummeryWithItemTVC.self)
    
    @IBOutlet var ordersCollectionView: UICollectionView!
    @IBOutlet var pageView: UIPageControl!
    
    @IBOutlet var lblShippingHandling :UILabel!
    @IBOutlet var lblPlatformFee :UILabel!
    @IBOutlet var lblTotalCharges :UILabel!
    @IBOutlet var lblOtherTaxes :UILabel!
    @IBOutlet var lblDiamondTaxes :UILabel!
    @IBOutlet var lblTotalTaxes :UILabel!
    @IBOutlet var lblSubTotal :UILabel!
    @IBOutlet var lblGrandTotal :UILabel!
    
    
    @IBOutlet var lblCouponP :UILabel!
    @IBOutlet var lblWallertPoint :UILabel!
    @IBOutlet var lblBankCHarges :UILabel!
    
    @IBOutlet var lblDiamondPrice :UILabel!
    
    @IBOutlet var viewCouponP :UIStackView!
    @IBOutlet var viewWallertPoint :UIStackView!
    @IBOutlet var viewBankCHarges :UIStackView!
    
    
    var checkOutDetails = CheckOutDataStruct()

    var timer = Timer()
    var counter = 0
    
    var productArr = [String]()
    
    var diamondDetailsOBJ = DiamondDetails()
    var CartDataObj = [CardDataDetail]()
    var isFromCart = -1
    var currencyRateDetailObj = CurrencyRateDetail()
    
    var baseVC : ShippingModuleVC?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pageView.numberOfPages = 0
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        
        ordersCollectionView.delegate = self
        ordersCollectionView.dataSource = self
        ordersCollectionView.register(UINib(nibName: OrderSummeryItemsCVC.cellIdentifierOrderSummeryItemsCVC, bundle: nil), forCellWithReuseIdentifier: OrderSummeryItemsCVC.cellIdentifierOrderSummeryItemsCVC)
        
//        if let layout = sliderCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                    layout.scrollDirection = .horizontal
//                    layout.minimumLineSpacing = 0
//                }
//
//        sliderCollectionView.isPagingEnabled = true
        
        ordersCollectionView.showsHorizontalScrollIndicator = false
        ordersCollectionView.showsVerticalScrollIndicator = false
        
    }
    
    
    func reloadCollection(cartData: [CardDataDetail], singleDimd: DiamondDetails){
        self.diamondDetailsOBJ = singleDimd
        self.CartDataObj = cartData
        if cartData.count > 0{
            isFromCart = 1
            pageView.numberOfPages = cartData.count
        }
        else{
            pageView.numberOfPages = 1
            isFromCart = 0
        }
        
        ordersCollectionView.reloadData()
    }
    
    func getCurrencySymbol(for countryCode: String) -> String? {
        let localeIdentifier = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: countryCode])
        
        let locale = Locale(identifier: localeIdentifier)
        
        // Get the currency symbol for the given country code
        return locale.currencySymbol
    }
    
    
    func setupData(checkOutData :CheckOutDataStruct, isPaymentSection : Int){
        var getCurrncyObj = CurrencyRatesManager.shareInstence.currencyRateDetailObj
        print(getCurrncyObj)
        self.checkOutDetails = checkOutData
        
        if isPaymentSection == 2{
            self.viewCouponP.isHidden = false
            self.viewWallertPoint.isHidden = false
        }
        else{
            self.viewCouponP.isHidden = true
            self.viewWallertPoint.isHidden = true
        }
        
        var currency = String()
        
        if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
            currency = currncySimbol
        }
        else{
            currency = "₹"
        }
        
        if checkOutData.shippingCharge ?? 0 == 0 {
            
            self.lblShippingHandling.text = "Free Shipping"
        }
        else{
           // self.lblShippingHandling.textColor = .green2
            
            let shippngFee = formatNumberWithoutDeciml(Double(checkOutData.shippingCharge ?? 0))
            self.lblShippingHandling.text = "\(currency)\(shippngFee)"
        }
        
        let platFmFee = formatNumberWithoutDeciml(Double(checkOutData.platformFee ?? 0))
        self.lblPlatformFee.text = "\(currency)\(platFmFee)"
        
        let totalChrgs = formatNumberWithoutDeciml(Double(checkOutData.totalCharge ?? 0))
        self.lblTotalCharges.text = "\(currency)\(totalChrgs)"
        
        let otherChrgs = formatNumberWithoutDeciml(Double(checkOutData.totalChargeTax ?? 0))
        self.lblOtherTaxes.text = "\(currency)\(otherChrgs)"
        
        let diaTACX = formatNumberWithoutDeciml(Double(checkOutData.tax ?? 0))
        self.lblDiamondTaxes.text = "\(currency)\(diaTACX)"
        
        let totlTax = formatNumberWithoutDeciml(Double(checkOutData.totalTaxes ?? 0))
        self.lblTotalTaxes.text = "\(currency)\(totlTax)"
        
        let subTotl = formatNumberWithoutDeciml(Double(checkOutData.totalAmount ?? 0))
        self.lblSubTotal.text = "\(currency)\(subTotl)"
        
        let granTotl = formatNumberWithoutDeciml(Double(checkOutData.finalAmount ?? 0))
        self.lblGrandTotal.text = "\(currency)\(granTotl)"
        
        let diaPrice = formatNumberWithoutDeciml(Double(checkOutData.subTotal ?? 0))
        self.lblDiamondPrice.text = "\(currency)\(diaPrice)"
        
        if let vc = self.baseVC{
            let formattedNumber = formatNumberWithoutDeciml(Double(checkOutData.finalAmount ?? 0))
            vc.lblTotalAmount.text = "\(currency)\(formattedNumber)"
        }
       
        
        let cupnDis = formatNumberWithoutDeciml(Double(checkOutData.couponDiscount ?? 0))
        self.lblCouponP.text = "-\(currency)\(cupnDis)"
        self.lblCouponP.textColor = .green2
        
        let walletDis = formatNumberWithoutDeciml(Double(checkOutData.walletPoint ?? 0))
        self.lblWallertPoint.text = "-\(currency)\(walletDis)"
        self.lblWallertPoint.textColor = .green2
        
        let bnkCharges = formatNumberWithoutDeciml(Double(checkOutData.bankCharge ?? 0))
        self.lblBankCHarges.text = "\(currency)\(bnkCharges)"
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func changeImage() {
        var count = CartDataObj.count
//        if CartDataObj.count > 0 {
//            count = CartDataObj.count
//        }
//        else{
//            count = imgArr.count
//        }
     
     if counter < count {
         let index = IndexPath.init(item: counter, section: 0)
         self.ordersCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageView.currentPage = counter
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.ordersCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageView.currentPage = counter
         counter = 1
     }
         
     }

 }

extension OrderSummeryWithItemTVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.isFromCart == 1{
            if self.CartDataObj.count > 0{
                return self.CartDataObj.count
            }
            else{
                return 0
            }
           
        }
        else{
            if self.diamondDetailsOBJ.certificateNo != nil{
                return 1
            }
            else{
                return 0
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderSummeryItemsCVC.cellIdentifierOrderSummeryItemsCVC, for: indexPath) as! OrderSummeryItemsCVC
        
        if self.isFromCart == 1{
            
             cell.lblCirtificateNum.text = self.CartDataObj[indexPath.row].stockNo
            cell.lblLotID.text = "\(self.CartDataObj[indexPath.row].supplierID)"
             cell.lblShape.text = self.CartDataObj[indexPath.row].shape
            cell.lblCarat.text = "\(self.CartDataObj[indexPath.row].carat)ct"
             cell.lblClor.text = self.CartDataObj[indexPath.row].color
             cell.lblClarity.text = self.CartDataObj[indexPath.row].clarity
            
//            let formattedNumber = formatNumberWithoutDeciml(Double(self.CartDataObj[indexPath.row].subtotal))
//            
//            cell.lblPrice.text = formattedNumber
            
            if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                let currncyVal = self.currencyRateDetailObj.value ?? 1
                let finalVal = Double((self.CartDataObj[indexPath.row].subtotal)) * currncyVal
                let formattedNumber = formatNumberWithoutDeciml(finalVal)
                cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
            }
            else{
                let formattedNumber = formatNumberWithoutDeciml(Double(self.CartDataObj[indexPath.row].subtotal))
                cell.lblPrice.text = "₹\(formattedNumber)"
            }
            
            
            cell.imgDiamond.sd_setImage(with: URL(string: self.CartDataObj[indexPath.row].diamondImage), placeholderImage: UIImage(named: "place_Holder"))
        }
        else{
            
             cell.lblCirtificateNum.text = self.diamondDetailsOBJ.stockNO
             cell.lblLotID.text = "\(self.diamondDetailsOBJ.supplierID ?? "")"
             cell.lblShape.text = self.diamondDetailsOBJ.shape
             cell.lblCarat.text = "\(self.diamondDetailsOBJ.carat ?? "")ct"
             cell.lblClor.text = self.diamondDetailsOBJ.color
             cell.lblClarity.text = self.diamondDetailsOBJ.clarity
            
//            let formattedNumber = formatNumberWithoutDeciml(Double(self.diamondDetailsOBJ.subtotal ?? 0))
//            
//            cell.lblPrice.text = formattedNumber
             cell.imgDiamond.sd_setImage(with: URL(string: self.diamondDetailsOBJ.diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
            
            if let currncySimbol = self.currencyRateDetailObj.currencySymbol{
                let currncyVal = self.currencyRateDetailObj.value ?? 1
                let finalVal = Double((self.diamondDetailsOBJ.subtotal ?? 0)) * currncyVal
                let formattedNumber = formatNumberWithoutDeciml(finalVal)
                cell.lblPrice.text = "\(currncySimbol)\(formattedNumber)"
            }
            else{
                let formattedNumber = formatNumberWithoutDeciml(Double(self.diamondDetailsOBJ.subtotal ?? 0))
                cell.lblPrice.text = "₹\(formattedNumber)"
            }
            
            
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
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 1.1   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size - 10, height: size - 200 )
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //            return 10 // Adjust the spacing between rows
    //        }
    
    //        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //            return 40 // Adjust the spacing between items in a row
    //        }
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) // Adjust the left padding
    }
}
