//
//  SuggestedTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/05/24.
//

import UIKit

class SuggestedTVC: UITableViewCell {
    
    static let cellIdentifireGloblwSuggestedTVC = String(describing: SuggestedTVC.self)
    
    @IBOutlet var lblHeading:UILabel!
    @IBOutlet var collectionViewSuggested:UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewSuggested.delegate = self
        collectionViewSuggested.dataSource = self
        collectionViewSuggested.register(UINib(nibName: SuggestedCVC.cellIdentifierSuggestedCVC, bundle: nil), forCellWithReuseIdentifier: SuggestedCVC.cellIdentifierSuggestedCVC)
        
        collectionViewSuggested.showsHorizontalScrollIndicator = false
        collectionViewSuggested.showsVerticalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension SuggestedTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestedCVC.cellIdentifierSuggestedCVC, for: indexPath) as! SuggestedCVC
        cell.lblName.text = "12345"
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size + 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5 // Adjust the spacing between rows
        }
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 20 // Adjust the spacing between items in a row
//        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0) // Adjust the left padding
        }
    
}
