//
//  MyOrderBaseVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 11/09/24.
//

import UIKit
import XLPagerTabStrip

class MyOrderBaseVC: ButtonBarPagerTabStripViewController {
 
    override func viewDidLoad() {
        settings.style.buttonBarItemBackgroundColor = UIColor.viewBGClr
        settings.style.buttonBarHeight = 22.0
        settings.style.selectedBarBackgroundColor = UIColor.tabSelectClr
        settings.style.buttonBarItemFont = .systemFont(ofSize: 15.0)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarMinimumInteritemSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor.clrGray
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
//        DispatchQueue.main.async {
//               self.moveToViewController(at: 1, animated: false) 
//           }
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.font = oldCell?.label.font.withSize(15)
            oldCell?.label.textColor = UIColor.clrGray
            newCell?.label.textColor = UIColor.tabSelectClr
        }
        super.viewDidLoad()
        //containerView.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        

    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
  
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        
        let child_1 = UIStoryboard(name: "MyOrder", bundle: nil).instantiateViewController(withIdentifier: String(describing: "RecentIListVC")) as! RecentIListVC
        
        let child_2 = UIStoryboard(name: "MyOrder", bundle: nil).instantiateViewController(withIdentifier: String(describing: "ReturnListVC")) as! ReturnListVC

        
        let child_3 = UIStoryboard(name: "MyOrder", bundle: nil).instantiateViewController(withIdentifier: String(describing: "ReservedListVC")) as! ReservedListVC
        
        let child_4 = UIStoryboard(name: "MyOrder", bundle: nil).instantiateViewController(withIdentifier: String(describing: "PastListVC")) as! PastListVC
        
        let child_5 = UIStoryboard(name: "MyOrder", bundle: nil).instantiateViewController(withIdentifier: String(describing: "CancelledListVC")) as! CancelledListVC
        
        let array :  [UIViewController] = [child_1,child_2,child_3,child_4,child_5]
        return array
       
    }



}
