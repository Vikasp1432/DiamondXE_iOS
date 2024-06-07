//
//  AdvanceFilterVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/06/24.
//

import UIKit

class AdvanceFilterVC: BaseViewController , DataReceiver{
    
    
    var searchAttriStruct =  SearchOptionDataStruct()
    
    @IBOutlet var tableViewAdvanceFilter:UITableView!
    
    
    func receiveData(_ data: SearchOptionDataStruct) {
        // Use the received data here
        searchAttriStruct = data
    }
    
    
    @IBOutlet var headerView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewAdvanceFilter.register(UINib(nibName: AdvanceFilterTVC.cellIdentifierAdvanceFilTVC, bundle: nil), forCellReuseIdentifier: AdvanceFilterTVC.cellIdentifierAdvanceFilTVC)
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }


}

extension AdvanceFilterVC :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdvanceFilterTVC.cellIdentifierAdvanceFilTVC, for: indexPath) as! AdvanceFilterTVC
        cell.filterDataStruct(searchAttributeStruct: self.searchAttriStruct)
//        cell.btnActionAdvanceFilter = { tag in
//            self.navigationManager(AdvanceFilterVC.self, storyboardName: "SearchDiamond", storyboardID: "AdvanceFilterVC", data: self.searchAttributeStruct)
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1500
    }
    
}
