//
//  ShippingAddressListingTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/08/24.
//

import UIKit

class ShippingAddressListingTVC: UITableViewCell {
    
    static let cellIdentifierShippingAddressListingTVc = String(describing: ShippingAddressListingTVC.self)
    
    @IBOutlet var shippingAddressCollectionView:UICollectionView!
    @IBOutlet var lblHeaderTitle:UILabel!
    
    var addressData = GetAddressStruct()
    var btnActionCell : ((Int) -> Void) = {_ in }
    var btnActionEdit : ((Int) -> Void) = {_ in }
    
    var btnActionAddAddress : (() -> Void) = { }
    
    
    var selectedIndexPath : IndexPath?
    
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shippingAddressCollectionView.delegate = self
        shippingAddressCollectionView.dataSource = self
       
        shippingAddressCollectionView.register(UINib(nibName: ShippingAddressListingCVC.cellIdentifierShippingAddressListingCVC, bundle: nil), forCellWithReuseIdentifier: ShippingAddressListingCVC.cellIdentifierShippingAddressListingCVC)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionAdd(_ sender : UIButton){
        btnActionAddAddress()
    }
    
    func updateDataIncell(cellData: GetAddressStruct){
        self.addressData = cellData
        shippingAddressCollectionView.reloadData()
    }
    
    
}

extension ShippingAddressListingTVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressData.details?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShippingAddressListingCVC.cellIdentifierShippingAddressListingCVC, for: indexPath) as! ShippingAddressListingCVC
        cell.lblAddress.text = "Address: \(addressData.details?[indexPath.row].address1 ?? "")"
        cell.lblPhone.text = "Phone No.: \(addressData.details?[indexPath.row].mobileNo ?? "")"
        cell.lblEmail.text = "Email: \(addressData.details?[indexPath.row].emailID ?? "")"
        cell.lblAddressType.text = "Address Type:\(addressData.details?[indexPath.row].addressType ?? "")"
        cell.lblName.text = "City Name: \(addressData.details?[indexPath.row].cityNameS ?? "")"

        cell.isSelectedCell = (indexPath == selectedIndexPath)
        
         let isDefault = addressData.details?[indexPath.row].isDefault ?? -1
            if isDefault == 0{
                cell.lblDefaut.isHidden = true
                cell.isSelectedCell = false
            }
            else{
                cell.lblDefaut.isHidden = false
                cell.isSelectedCell = true
            }
        
       

        cell.btnActionCell = { tag in
            if tag == 2 {
                self.selectedIndexPath = indexPath
                self.btnActionCell(tag)
            }
            else{
                self.btnActionEdit(indexPath.row)
            }
        }
        return cell
    }
    
  
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("hhhudhsuhdus")
//       //
//       }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 1.1   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size - 15, height: size - 215 )
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
