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
    
    
    var imgArr = [ UIImage(named:"LooseDiamonds"),
                    UIImage(named:"Rings_") ,
                    UIImage(named:"EarRings") ,
                    UIImage(named:"Pendants") ,
                    UIImage(named:"Bracelets") ,
                    UIImage(named:"Bangles_") ]
    
    var titleArr = [ "Solitaires",
                    "Rings" ,
                    "Earrings" ,
                    "Pendants" ,
                    "Bracelets" ,
                    "Bangles"]
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionCat.delegate = self
        collectionCat.dataSource = self
        collectionCat.register(UINib(nibName: HomeVC_CateogiesCVC.cellIdentifierHomeCVC, bundle: nil), forCellWithReuseIdentifier: HomeVC_CateogiesCVC.cellIdentifierHomeCVC)
        
        collectionCat.showsHorizontalScrollIndicator = false
        collectionCat.showsVerticalScrollIndicator = false


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension HomeVC_CateogiesTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVC_CateogiesCVC", for: indexPath) as! HomeVC_CateogiesCVC
        cell.lblCateIMG.image = imgArr[indexPath.row]
        cell.lblCateName.text = titleArr[indexPath.row]
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size , height: size + 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15 // Adjust the spacing between rows
        }
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 20 // Adjust the spacing between items in a row
//        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) // Adjust the left padding
        }
}
