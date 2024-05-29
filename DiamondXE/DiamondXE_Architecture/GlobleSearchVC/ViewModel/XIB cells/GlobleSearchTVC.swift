//
//  GlobleSearchTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/05/24.
//

import UIKit

class GlobleSearchTVC: UITableViewCell {
    static let cellIdentifireGloblwSearchTVC = String(describing: GlobleSearchTVC.self)
    
    @IBOutlet var lblHeading:UILabel!
    @IBOutlet var collectionTrending:UICollectionView!
    
    
    var titleArr = [ "Loose Diamonds",
                    "Engagement Rings" ,
                    "Color Fancy Diamonds" ,
                    "Jewellery under 30 K"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionTrending.delegate = self
        collectionTrending.dataSource = self
        collectionTrending.register(UINib(nibName: GlobleSearchCVC.cellIdentifireGloblwSearchCVC, bundle: nil), forCellWithReuseIdentifier: GlobleSearchCVC.cellIdentifireGloblwSearchCVC)
        
        collectionTrending.showsHorizontalScrollIndicator = false
        collectionTrending.showsVerticalScrollIndicator = false
        
        collectionTrending.collectionViewLayout = createLeftAlignedLayout()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension GlobleSearchTVC :  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobleSearchCVC.cellIdentifireGloblwSearchCVC, for: indexPath) as! GlobleSearchCVC
       
        cell.lblTitles.text = titleArr[indexPath.row]
       
        return cell
    }


    private func createLeftAlignedLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(50),
                heightDimension: .absolute(55)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(55)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            group.interItemSpacing = .fixed(10)
        
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 6
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
            
            return UICollectionViewCompositionalLayout(section: section)
        }
}
