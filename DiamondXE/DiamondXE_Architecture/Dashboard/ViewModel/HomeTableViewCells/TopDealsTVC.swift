//
//  TopDealsTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/05/24.
//

import UIKit

class TopDealsTVC: UITableViewCell {
    
    static let cellIdentifierTopDealsTVC = String(describing: TopDealsTVC.self)
    
    var buttonPressed : ((Int) -> Void) = {_ in }
    @IBOutlet var btnNaturalDiamd:UIButton!
    @IBOutlet var btnLABDiamd:UIButton!
    
    var naturalDia = [NaturalDiamond]()
    var labGlDia = [LabGDiamond]()
    
    var buttonPressedDetails : ((Int) -> Void) = {_ in }
    
    @IBOutlet var collectionViewTopDeL:UICollectionView!
    
    
    var imgArr = [  UIImage(named:"Emerald_"),
                    UIImage(named:"Heart") ,
                    UIImage(named:"Princess") ]
    

    
    var titleArr = [ "Emerald 1.00Ct H VVS1",
                    "Heart 0.50Ct F VS2" ,
                    "Emerald 1.00Ct H VVS1"]
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewTopDeL.delegate = self
        collectionViewTopDeL.dataSource = self
        collectionViewTopDeL.register(UINib(nibName: TopDealsCVC.cellIdentifierTopDealsCVC, bundle: nil), forCellWithReuseIdentifier: TopDealsCVC.cellIdentifierTopDealsCVC)
        
        collectionViewTopDeL.showsHorizontalScrollIndicator = false
        collectionViewTopDeL.showsVerticalScrollIndicator = false
        self.btnNaturalDiamd.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        buttonPressed(sender.tag)
        if sender.tag == 0{
//            btnNaturalDiamd.backgroundColor = .tabSelectClr
            btnNaturalDiamd.setTitleColor(.whitClr, for: .normal)
            btnLABDiamd.backgroundColor = .clear
            btnLABDiamd.setTitleColor(.tabSelectClr, for: .normal)
            btnLABDiamd.clearGradient()
            self.btnNaturalDiamd.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        }
        else{
            
            btnNaturalDiamd.backgroundColor = .clear
            btnNaturalDiamd.setTitleColor(.tabSelectClr, for: .normal)
//            btnLABDiamd.backgroundColor = .tabSelectClr
            btnLABDiamd.setTitleColor(.whitClr, for: .normal)
            btnNaturalDiamd.clearGradient()
            self.btnLABDiamd.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            
        }
        
        
    }
    
}


extension TopDealsTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.naturalDia.count > 0{
            return self.naturalDia.count
        }
        else if self.labGlDia.count > 0{
            return self.labGlDia.count
        }
        else{
            return self.imgArr.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopDealsCVC.cellIdentifierTopDealsCVC, for: indexPath) as! TopDealsCVC
        let placeholderImage = UIImage(named: "place_Holder")
        if self.naturalDia.count > 0{
            
            cell.diamondSelect = {
                self.buttonPressedDetails(indexPath.row)
            }
            
            let imageUrlString = naturalDia[indexPath.row].diamondImage ?? ""
            
            
            if let imageUrl = URL(string: imageUrlString) {
                cell.imgDiamond.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell.imgDiamond.image = placeholderImage
            }
            
            cell.lblDiaName.text = naturalDia[indexPath.row].itemName
            cell.lblDiaPrice.text = "₹\(naturalDia[indexPath.row].totalPrice ?? 0)"
//            cell.imgDiamond.sd_setImage(with: URL(string: naturalDia[indexPath.row].diamondImage ?? ""), completed: nil)
        }
        else if self.labGlDia.count > 0{
            
            let imageUrlString = labGlDia[indexPath.row].diamondImage ?? ""
            
            if let imageUrl = URL(string: imageUrlString) {
                cell.imgDiamond.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell.imgDiamond.image = placeholderImage
            }

            
            cell.lblDiaName.text = labGlDia[indexPath.row].itemName
            cell.lblDiaPrice.text = "₹\(labGlDia[indexPath.row].totalPrice ?? 0)"
           // cell.imgDiamond.sd_setImage(with: URL(string: labGlDia[indexPath.row].diamondImage ?? ""), completed: nil)
            
        }
        else{
            cell.lblDiaName.text = titleArr[indexPath.row]
            cell.lblDiaPrice.text = "₹--"
            cell.imgDiamond.image = imgArr[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size + 45)
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
