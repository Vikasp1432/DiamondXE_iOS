//
//  CustomerReviewTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/05/24.
//

import UIKit

class CustomerReviewTVC: UITableViewCell {
    static let cellIdentifierCustomerView = String(describing: CustomerReviewTVC.self)
    
    
    @IBOutlet var collectionCustomerView:UICollectionView!
    
    var customerStories = CustomerStories()
    
   
    var imgArr = [ UIImage(named:"customerReview1"),
                    UIImage(named:"customerReview2") ,
                    UIImage(named:"customerReview3")]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionCustomerView.delegate = self
        collectionCustomerView.dataSource = self
        collectionCustomerView.register(UINib(nibName: CustomerViewCVC.cellIdentifierCustomerViewCVC, bundle: nil), forCellWithReuseIdentifier: CustomerViewCVC.cellIdentifierCustomerViewCVC)
        
        collectionCustomerView.showsHorizontalScrollIndicator = false
        collectionCustomerView.showsVerticalScrollIndicator = false
        
      

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension CustomerReviewTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if customerStories.content?.count ?? 0 > 0{
            return customerStories.content?.count ?? 0
        }
        else{
            return imgArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomerViewCVC.cellIdentifierCustomerViewCVC, for: indexPath) as! CustomerViewCVC
        
        
        if customerStories.content?.count ?? 0 > 0{
            let imageUrlString = customerStories.content?[indexPath.row].image ?? ""
            if let imageUrl = URL(string: imageUrlString) {
                
                cell.imgCustomer.sd_setImage(with: imageUrl)
                //cell.imgCustomer.setImage(from: imageUrl, placeholder: nil, timeoutInterval: 1.0)
            }
        }
        else{
            cell.imgCustomer.image = imgArr[indexPath.row]
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 1.3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size + 30, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15 // Adjust the spacing between rows
        }
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 20 // Adjust the spacing between items in a row
//        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0) // Adjust the left padding
        }

    
  
}
