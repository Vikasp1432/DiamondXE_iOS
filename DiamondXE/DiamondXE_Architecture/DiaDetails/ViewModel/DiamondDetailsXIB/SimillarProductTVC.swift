//
//  SimillarProductTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/06/24.
//

import UIKit
import UIView_Shimmer

protocol CustomRcommCellDelegate: AnyObject {
    func cellViewTapped(in certificateNO: String, _ cell: SimillarProductCVC, tag:Int)
}
class SimillarProductTVC: UITableViewCell {

    static let cellIdentifierSimmilarDiaTVC = String(describing: SimillarProductTVC.self)
    
    @IBOutlet var sliderCollectionView: UICollectionView!
    @IBOutlet var pageView: UIPageControl!
    
     var isLoading = true {
        didSet {
            sliderCollectionView.isUserInteractionEnabled = !isLoading
            sliderCollectionView.reloadData()
        }
    }
    
    
    var diaDataObj = [RecommendedDiamdDetail]()
    var delegate : CustomRcommCellDelegate?
    var timer = Timer()
    var counter = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        pageView.numberOfPages = 0
//        pageView.currentPage = 0
        
        
        
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(UINib(nibName: SimillarProductCVC.cellIdentifiersameProduct, bundle: nil), forCellWithReuseIdentifier: SimillarProductCVC.cellIdentifiersameProduct)
        
//        if let layout = sliderCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                    layout.scrollDirection = .horizontal
//                    layout.minimumLineSpacing = 0
//                }
//
//        sliderCollectionView.isPagingEnabled = true
        
        sliderCollectionView.showsHorizontalScrollIndicator = false
        sliderCollectionView.showsVerticalScrollIndicator = false
        
       
        
    }
    
    
    func setupRecommendentData(dataObj:[RecommendedDiamdDetail]){
        self.diaDataObj = dataObj
        if dataObj.count > 0{
            pageView.numberOfPages = self.diaDataObj.count
//            pageView.numberOfPages = 0
            pageView.currentPage = 0
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
            
            sliderCollectionView.reloadData()
        }
        self.isLoading = false
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func changeImage() {
        var count = Int()
        if self.diaDataObj.count  > 0 {
            count = self.diaDataObj.count
        }
        else{
            count = 0
        }
     
     if counter < count {
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageView.currentPage = counter
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageView.currentPage = counter
         counter = 1
     }
         
     }

 }

 extension SimillarProductTVC: UICollectionViewDelegate, UICollectionViewDataSource, ShimmeringViewProtocol {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
         if diaDataObj.count > 0{
             return self.diaDataObj.count
         }
         else{
             return 0
         }
         
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimillarProductCVC.cellIdentifiersameProduct, for: indexPath) as! SimillarProductCVC
//         cell.selectionStyle = .default
         cell.contentView.isUserInteractionEnabled = true

         cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
         
       
         
         cell.addToCart = {
             self.delegate?.cellViewTapped(in: self.diaDataObj[indexPath.row].certificateNo ?? "", cell, tag: 0)
         }
         cell.addToWish = {
             self.delegate?.cellViewTapped(in: self.diaDataObj[indexPath.row].certificateNo ?? "", cell, tag: 1)
         }
         
         if diaDataObj.count > 1{
             
             if let isCart = self.diaDataObj[indexPath.row].isCart{
                 if isCart == 0 {
                     cell.btnCard.setTitle("Add To Cart", for: .normal)
                 }
                 else{
                     cell.btnCard.setTitle("Go To Cart", for: .normal)
                 }
             }
             
             if let isWish = self.diaDataObj[indexPath.row].isWishlist{
                 if isWish == 0 {
                     cell.btnWhshlist.setImage(UIImage(named: "wishlist"), for: .normal)
                 }
                 else{
                     cell.btnWhshlist.setImage(UIImage(named: "heartFilled"), for: .normal)
                 }
             }
             
             cell.lblCirtificateNum.text = self.diaDataObj[indexPath.row].certificateNo
             cell.lblLotID.text = "ID: \(self.diaDataObj[indexPath.row].supplierID ?? "")"
             cell.btnShape.text = self.diaDataObj[indexPath.row].shape
             cell.lblCarat.text = "Ct\(self.diaDataObj[indexPath.row].carat ?? "")"
             cell.lblClor.text = self.diaDataObj[indexPath.row].color
             cell.lblClarity.text = self.diaDataObj[indexPath.row].clarity
             cell.lblCarat.text = self.diaDataObj[indexPath.row].carat
             
             
             if let availibility = self.diaDataObj[indexPath.row].status{
                 if availibility == "On Hold"{
                     cell.btnAvailable.setImage(UIImage(named: "onHold"), for: .normal)
                 }
                 else if  availibility == "Available"{
                     cell.btnAvailable.setImage(UIImage(named: "available"), for: .normal)
                 }
                 else{
                     cell.btnAvailable.isHidden = true
                 }
             }
             
             let cutVal = self.diaDataObj[indexPath.row].cutGrade
             if cutVal?.isEmptyStr ?? true || cutVal == "-"{
                 cell.viewCut.isHidden = true
             }
             else{
                 cell.lblCut.text = cutVal
             }
             
//             cell.shapeClick = {
//                 cell.shapeFullNameshow(name: self.diamondListDetails[indexPath.row].shape ?? "")
//             }
           

             let polishVal = self.diaDataObj[indexPath.row].polish
             if polishVal?.isEmptyStr ?? true || polishVal == "-"{
                 cell.viewPolish.isHidden = true
             }
             else{
                 cell.lblPolish.text = polishVal
             }
           
             let symmetryVal = self.diaDataObj[indexPath.row].symmetry
             if symmetryVal?.isEmptyStr ?? true || symmetryVal == "-"{
                 cell.viewSymmetry.isHidden = true
             }
             else{
                 cell.lblSymmetry.text = symmetryVal
             }
             
             let flouroVal = self.diaDataObj[indexPath.row].fluorescenceIntensity
             if flouroVal?.isEmptyStr ?? true || flouroVal == "-"{
                 cell.viewFlouro.isHidden = true
             }
             else{
                 cell.lblFlouro.text = flouroVal
             }
             
             let certificateVal = self.diaDataObj[indexPath.row].certificateName
             if certificateVal?.isEmptyStr ?? true || certificateVal == "-"{
                 cell.viewCertificate.isHidden = true
             }
             else{
                 cell.lblCertificate.text = certificateVal
             }
             
             cell.lblDiscount.text = self.diaDataObj[indexPath.row].rDiscount ?? ""
             
             cell.lblTablePer.text = "T: \(self.diaDataObj[indexPath.row].tablePerc ?? "")"
             cell.lblDepPer.text = "D: \(self.diaDataObj[indexPath.row].depthPerc ?? "")"
             cell.lblMasurments.text = "M: \(self.diaDataObj[indexPath.row].measurement ?? "")"
             
             
                 
                 let formattedNumber = formatNumberWithoutDeciml(Double(self.diaDataObj[indexPath.row].totalPrice ?? 0))
                 cell.lblPrice.text = "₹\(formattedNumber)"
            
             
             cell.imgDiamond.sd_setImage(with: URL(string: self.diaDataObj[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
             
             cell.diamondSelect = {
                 self.delegate?.cellViewTapped(in: self.diaDataObj[indexPath.row].certificateNo ?? "", cell, tag: -1)
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
 }

 extension SimillarProductTVC: UICollectionViewDelegateFlowLayout {
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         
         let size = sliderCollectionView.frame.size
         return CGSize(width: size.width , height: size.height)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 13
     }
     
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
             let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
             pageView.currentPage = page
             counter = page + 1
         }
 

}
