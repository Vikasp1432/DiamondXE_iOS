//
//  UPITVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/08/24.
//

import UIKit

class UPITVC: UITableViewCell {

    static let cellIdentifierUPITVC = String(describing: UPITVC.self)
    @IBOutlet var viewBG:UIView!
    
    @IBOutlet var collectionUPIApps:UICollectionView!
    var upiApps: [UPIAppInfo] = []
    
    var selectedIndexPath: IndexPath?
    
    var tapAction : ((String, String) -> Void) = { _,_  in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBG.applyShadow()
        collectionUPIApps.delegate = self
        collectionUPIApps.dataSource  = self
     
        
        collectionUPIApps.register(UINib(nibName: UPIAppsCVC.cellIdentifierUPIAppsCVC, bundle: nil), forCellWithReuseIdentifier: UPIAppsCVC.cellIdentifierUPIAppsCVC)
        
        
        upiApps = fetchInstalledUPIApps()


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UPITVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upiApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UPIAppsCVC.cellIdentifierUPIAppsCVC, for: indexPath) as! UPIAppsCVC
        let upiApp = upiApps[indexPath.row]
        
        cell.lblName?.text = upiApp.appName
        cell.iconIMG?.image = upiApp.appIcon
        
       
        
        cell.tapAction = {
           
            
            if self.selectedIndexPath == indexPath {
                self.selectedIndexPath = nil
                self.tapAction("", "")
            } else {
                self.selectedIndexPath = indexPath
                self.tapAction(upiApp.appName, upiApp.packageName)
            }
            
          //  collectionView.reloadItems(at: [indexPath])
            collectionView.reloadData()
            
        }
        
        if indexPath == self.selectedIndexPath {
            cell.viewBG.borderWidth = 1.5
            cell.viewBG.borderColor = UIColor.tabSelectClr
          
        } else {
            cell.viewBG.borderWidth = 0
            cell.viewBG.borderColor = UIColor.clear
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 6 //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size + 35 , height: size + 20 )
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0) // Adjust the left padding
    }
    
    
  
    
    
//    func fetchInstalledUPIApps() -> [String] {
//        var installedUPIApps = [String]()
//        
//        // Check for PhonePe
//        if UIApplication.shared.canOpenURL(URL(string: "phonepe://")!) {
//            installedUPIApps.append("PhonePe")
//        }
//        
//        // Check for Paytm
//        if UIApplication.shared.canOpenURL(URL(string: "paytmUPI://")!) {
//            installedUPIApps.append("Paytm")
//        }
//        
//        // Check for Google Pay
//        if UIApplication.shared.canOpenURL(URL(string: "gpay://")!) {
//            installedUPIApps.append("Google Pay")
//        }
//        
//        // Check for BHIM
//        if UIApplication.shared.canOpenURL(URL(string: "upi://")!) {
//            installedUPIApps.append("BHIM")
//        }
//        
//        return installedUPIApps
//    }
    
    
}



//struct UPIApp {
//    let name: String
//    let urlScheme: String
//    let icon: UIImage?
//}
//
//func fetchInstalledUPIApps() -> [UPIApp] {
//    var installedUPIApps = [UPIApp]()
//    
//    // Check for PhonePe
//    if UIApplication.shared.canOpenURL(URL(string: "phonepe://")!) {
//        installedUPIApps.append(UPIApp(name: "PhonePe", urlScheme: "phonepe://", icon: UIImage(named: "phonepeIcon")))
//    }
//    
//    // Check for Paytm
//    if UIApplication.shared.canOpenURL(URL(string: "paytmUPI://")!) {
//        installedUPIApps.append(UPIApp(name: "Paytm", urlScheme: "paytmUPI://", icon: UIImage(named: "phonepeIcon")))
//    }
//    
//    // Check for Google Pay
//    if UIApplication.shared.canOpenURL(URL(string: "gpay://")!) {
//        installedUPIApps.append(UPIApp(name: "Google Pay", urlScheme: "gpay://", icon: UIImage(named: "phonepeIcon")))
//    }
//    
//    // Check for BHIM
//    if UIApplication.shared.canOpenURL(URL(string: "upi://")!) {
//        installedUPIApps.append(UPIApp(name: "BHIM", urlScheme: "upi://", icon: UIImage(named: "phonepeIcon")))
//    }
//    
//    return installedUPIApps
//}


struct UPIAppInfo {
    let packageName: String
    let appName: String
    let appIcon: UIImage?
}


func fetchInstalledUPIApps() -> [UPIAppInfo] {
    var installedUPIApps = [UPIAppInfo]()
    
    // Define the UPI apps URL schemes and their icons
    let upiApps = [
        ("PhonePe", "phonepe://", "phonepeIcon"),
        ("Paytm", "paytmUPI://", "paytmIcon"),
        ("Google Pay", "gpay://", "gpayIcon"),
        ("BHIM", "upi://", "bhimIcon")
    ]
    
    for (appName, urlScheme, iconName) in upiApps {
        if let url = URL(string: urlScheme), UIApplication.shared.canOpenURL(url) {
            let packageName = urlScheme // This can be adjusted if you have specific package names
            let appIcon = UIImage(named: iconName) // Load icon from assets
            
            installedUPIApps.append(UPIAppInfo(packageName: packageName, appName: appName, appIcon: appIcon))
        } else {
            print("\(appName) is not installed or cannot be opened.")
        }
    }
    
    return installedUPIApps
}
