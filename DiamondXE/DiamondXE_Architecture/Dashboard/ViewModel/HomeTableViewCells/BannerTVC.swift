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
    
    var imgArr = [  UIImage(named:"Banner1"),
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
        
        sliderCollectionView.showsHorizontalScrollIndicator = false
        sliderCollectionView.showsVerticalScrollIndicator = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func changeImage() {
     
     if counter < imgArr.count {
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
         return imgArr.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVC.cellIdentifierBannerCVC, for: indexPath) as! BannerCVC
         if let vc = cell.viewWithTag(111) as? UIImageView {
             vc.image = imgArr[indexPath.row]
         }
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
