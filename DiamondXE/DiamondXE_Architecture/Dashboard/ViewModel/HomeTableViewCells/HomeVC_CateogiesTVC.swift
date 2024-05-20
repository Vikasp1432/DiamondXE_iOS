//
//  HomeVC_CateogiesTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 20/05/24.
//

import UIKit

class HomeVC_CateogiesTVC: UITableViewCell {
    static let cellIdentifierHomeTVC = String(describing: HomeVC_CateogiesTVC.self)

    @IBOutlet var collectionCat:UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionCat.delegate = self
        collectionCat.dataSource = self
        collectionCat.register(UINib(nibName: HomeVC_CateogiesCVC.cellIdentifierHomeCVC, bundle: nil), forCellWithReuseIdentifier: HomeVC_CateogiesCVC.cellIdentifierHomeCVC)
        
//        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        //layout.minimumInteritemSpacing = 0
//        //layout.minimumLineSpacing = 0
//        collectionCat.collectionViewLayout = layout


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension HomeVC_CateogiesTVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVC_CateogiesCVC", for: indexPath) as! HomeVC_CateogiesCVC
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    
}
