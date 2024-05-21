//
//  HomeVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 16/05/24.
//

import UIKit

class HomeVC: BaseViewController {

    @IBOutlet var homeTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red

        // define uitableview cell
        homeTableView.register(UINib(nibName: HomeVC_CateogiesTVC.cellIdentifierHomeTVC, bundle: nil), forCellReuseIdentifier: HomeVC_CateogiesTVC.cellIdentifierHomeTVC)
        homeTableView.register(UINib(nibName: BannerTVC.cellIdentifierBannerTVC, bundle: nil), forCellReuseIdentifier: BannerTVC.cellIdentifierBannerTVC)
        homeTableView.register(UINib(nibName: GiftOfChoiceTVC.cellIdentifierGiftChoiceTVC, bundle: nil), forCellReuseIdentifier: GiftOfChoiceTVC.cellIdentifierGiftChoiceTVC)
        homeTableView.register(UINib(nibName: NewArrivalsTVC.cellIdentifierNewArrTVC, bundle: nil), forCellReuseIdentifier: NewArrivalsTVC.cellIdentifierNewArrTVC)
        homeTableView.showsHorizontalScrollIndicator = false
        homeTableView.showsVerticalScrollIndicator = false
    }

}

extension HomeVC : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeVC_CateogiesTVC.cellIdentifierHomeTVC, for: indexPath) as! HomeVC_CateogiesTVC
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTVC.cellIdentifierBannerTVC, for: indexPath) as! BannerTVC
            cell.selectionStyle = .none
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GiftOfChoiceTVC.cellIdentifierGiftChoiceTVC, for: indexPath) as! GiftOfChoiceTVC
            cell.selectionStyle = .none
            cell.lblTitle.text = "Gift of choice"
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewArrivalsTVC.cellIdentifierNewArrTVC, for: indexPath) as! NewArrivalsTVC
            cell.selectionStyle = .none
            cell.lblTitle.text = "New Arrivals"
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 170
            
        case 1:
            return 320
            
        case 2:
            return 340
            
        case 3:
            return 224
            
        default:
            return 0
        }
    }
  
    
    
}
