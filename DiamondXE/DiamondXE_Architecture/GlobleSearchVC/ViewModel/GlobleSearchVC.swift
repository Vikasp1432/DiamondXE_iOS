//
//  GlobleSearchVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/05/24.
//

import UIKit

class GlobleSearchVC: BaseViewController {
    
    @IBOutlet var txtSearchField:UITextField!
    @IBOutlet var headerView:UIView!
    
    @IBOutlet var tableViewGlobleSearch:UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.shadowColor = UIColor.shadowViewclr.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        headerView.layer.shadowRadius = 2.0
        headerView.layer.shadowOpacity = 0.3
        headerView.layer.masksToBounds = false
        
        
        tableViewGlobleSearch.register(UINib(nibName: GlobleSearchTVC.cellIdentifireGloblwSearchTVC, bundle: nil), forCellReuseIdentifier: GlobleSearchTVC.cellIdentifireGloblwSearchTVC)
        
        tableViewGlobleSearch.register(UINib(nibName: SuggestedTVC.cellIdentifireGloblwSuggestedTVC, bundle: nil), forCellReuseIdentifier: SuggestedTVC.cellIdentifireGloblwSuggestedTVC)
        
        tableViewGlobleSearch.showsHorizontalScrollIndicator = false
        tableViewGlobleSearch.showsVerticalScrollIndicator = false
    }
    
    @IBAction func btnActionBack( _ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionClear( _ sender:UIButton){
        
    }


}


extension GlobleSearchVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobleSearchTVC.cellIdentifireGloblwSearchTVC, for: indexPath) as! GlobleSearchTVC
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedTVC.cellIdentifireGloblwSuggestedTVC, for: indexPath) as! SuggestedTVC
            cell.selectionStyle = .none
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
            return 230
       
        default:
            return 0
        }
    }
    
    
}
