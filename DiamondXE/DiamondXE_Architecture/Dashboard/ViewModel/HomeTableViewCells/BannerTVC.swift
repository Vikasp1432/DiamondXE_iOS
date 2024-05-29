//
//  BannerTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/05/24.
//

import UIKit

class BannerTVC: UITableViewCell {
    
    static let cellIdentifierBannerTVC = String(describing: BannerTVC.self)
    
    @IBOutlet var sliderCollectionView: UICollectionView!
    @IBOutlet var pageView: UIPageControl!
    
    var banners = Banners()
    
    var imgArr = [ UIImage(named:"Banner1"),
                    UIImage(named:"Banner2") ,
                    UIImage(named:"Banner3") ,
                    UIImage(named:"Banner4") ,
                    UIImage(named:"Banner5") ,
                    UIImage(named:"Banner6") ]
    
    var timer = Timer()
    var counter = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(UINib(nibName: BannerCVC.cellIdentifierBannerCVC, bundle: nil), forCellWithReuseIdentifier: BannerCVC.cellIdentifierBannerCVC)
        
//        if let layout = sliderCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                    layout.scrollDirection = .horizontal
//                    layout.minimumLineSpacing = 0
//                }
//
//        sliderCollectionView.isPagingEnabled = true
        
        sliderCollectionView.showsHorizontalScrollIndicator = false
        sliderCollectionView.showsVerticalScrollIndicator = false
        
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func changeImage() {
        var count = 0
        if banners.content?.count ?? 0 > 0 {
            count = banners.content?.count ?? 0
        }
        else{
            count = imgArr.count
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

 extension BannerTVC: UICollectionViewDelegate, UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
         if banners.content?.count ?? 0 > 0 {
             return banners.content?.count ?? 0
         }
         else{
             return imgArr.count
         }
         
         
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVC.cellIdentifierBannerCVC, for: indexPath) as! BannerCVC
         if banners.content?.count ?? 0 > 0 {
             cell.images.sd_setImage(with: URL(string: banners.content?[indexPath.row].image ?? ""), completed: nil)
         }
         else{
             cell.images.image = imgArr[indexPath.row]
         }
//         if let vc = cell.viewWithTag(111) as? UIImageView {
//             if banners.content?.count ?? 0 > 0 {
//                 vc.image.sd_setImage(with: URL(string: banners.content?[indexPath.row].image)!, for: .normal, completed: nil)
//                 //vc.image
//                // return banners.content?.count ?? 0
//             }
//             else{
//                 vc.image = imgArr[indexPath.row]
//             }
//         }
         return cell
     }
 }

 extension BannerTVC: UICollectionViewDelegateFlowLayout {
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let size = sliderCollectionView.frame.size
         return CGSize(width: size.width, height: size.height)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 0.0
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 0.0
     }
     
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
             let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
             pageView.currentPage = page
             counter = page + 1
         }
 }
