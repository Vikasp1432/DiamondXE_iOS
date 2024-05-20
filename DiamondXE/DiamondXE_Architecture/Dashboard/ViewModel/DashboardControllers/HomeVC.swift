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
        view.backgroundColor = .red

        // define uitableview cell
        homeTableView.register(UINib(nibName: HomeVC_CateogiesTVC.cellIdentifierHomeTVC, bundle: nil), forCellReuseIdentifier: HomeVC_CateogiesTVC.cellIdentifierHomeTVC)
    }

}

extension HomeVC : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeVC_CateogiesTVC.cellIdentifierHomeTVC, for: indexPath) as! HomeVC_CateogiesTVC
            //cell.collectionCat.tag = indexPath.row
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 170
        default:
            return 80
        
        }
    }
  
    
    
}
