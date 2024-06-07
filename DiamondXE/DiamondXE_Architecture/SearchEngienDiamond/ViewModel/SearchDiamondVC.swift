//
//  SearchDiamondVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/05/24.
//

import UIKit

class SearchDiamondVC: BaseViewController {
    
    @IBOutlet var shadowedView:InnerDropShadowView!
    @IBOutlet var shadowedBGView:UIView!
    
    @IBOutlet var tbleViewSearchDim:UITableView!
    
    var searchAttributeStruct = SearchOptionDataStruct()

    override func viewDidLoad() {
        super.viewDidLoad()

        tbleViewSearchDim.register(UINib(nibName: SearchDiamondTVC.cellIdentifierSearchDiamondTVC, bundle: nil), forCellReuseIdentifier: SearchDiamondTVC.cellIdentifierSearchDiamondTVC)

//        shadowedBGView.addInnerOuterShadow()
        
        self.getSearchAttriDataAPICalling()

        
    }
    
    
    // API Calling()
    func getSearchAttriDataAPICalling(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)

        let url = APIs().get_SearchAttribute_API
        SearchOptionModel().getSeachAttributes(url: url, completion: { searchAttri , message in
           // print(homeData)
            if searchAttri.status == 1{
                self.searchAttributeStruct = searchAttri
                self.tbleViewSearchDim.reloadData()
            }
            
            else{
                self.toastMessage(message ?? "")
            }
            CustomActivityIndicator2.shared.hide()
        })
        
    }
    

   
}

extension SearchDiamondVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchDiamondTVC.cellIdentifierSearchDiamondTVC, for: indexPath) as! SearchDiamondTVC
       // cell.searchAttributeStruct = self.searchAttributeStruct
        cell.filterDataStruct(searchAttributeStruct: self.searchAttributeStruct)
        cell.btnActionAdvanceFilter = { tag in
            self.navigationManager(AdvanceFilterVC.self, storyboardName: "SearchDiamond", storyboardID: "AdvanceFilterVC", data: self.searchAttributeStruct)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1200
    }
    
}
