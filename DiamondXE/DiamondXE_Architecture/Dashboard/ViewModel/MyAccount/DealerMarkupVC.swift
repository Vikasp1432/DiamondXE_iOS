//
//  DealerMarkupVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 01/10/24.
//

import UIKit

class DealerMarkupVC: BaseViewController {
    
    
    @IBOutlet var tableViewMarkupLbl : UITableView!
    
    @IBOutlet var btnCancle : UIButton!
    @IBOutlet var btnUpdate : UIButton!
    
    
    var dealerMrkupoStruct = DealerMarkupStruct()
    var commissionRange = [CommissionRange]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMarkupLbl.register(UINib(nibName: DealerMarkupTVC.cellIdentifierDealerMarkupTVC, bundle: nil), forCellReuseIdentifier: DealerMarkupTVC.cellIdentifierDealerMarkupTVC)
        
        self.getDealerMarkupInfo()
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionUpdate(_ sender: UIButton){
        UpdateDealerMarkupInfo()
    }
    

    func getDealerMarkupInfo(){
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        let url =  APIs().getDealerMrkupInfo_API
        HomeDataModel().getDealerMarkup(url: url, completion: { data, msg in
            if data.status == 1{
                self.dealerMrkupoStruct = data
                if let commitionRng = data.details?.commissionRange{
                    self.commissionRange = commitionRng
                }
                self.tableViewMarkupLbl.reloadData()
            }
            else{
                self.toastMessage(msg ?? "")
            }
            CustomActivityIndicator2.shared.hide()
            
        })
        
        
    }
    
    func UpdateDealerMarkupInfo(){
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let url =  APIs().updateDealerMrkupInfo_API
        
        var param :[String:Any] = [:]
        
        do {
            let jsonData = try JSONEncoder().encode(self.commissionRange)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                // print(jsonString)
                param = ["CommissionRange" : jsonString]
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        HomeDataModel().getUpdateDealerMarkup(param: param, url: url, completion: { data, msg in
            if data.status == 1{
                self.navigationController?.popViewController(animated: true)
                self.toastMessage(msg ?? "")
            }
            else{
                self.toastMessage(msg ?? "")
            }
            CustomActivityIndicator2.shared.hide()
            
        })
        
        
    }
    

}


extension DealerMarkupVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = dealerMrkupoStruct.details?.commissionRange?.count{
            return count
        }
        else{
            return 0
        }
            
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DealerMarkupTVC.cellIdentifierDealerMarkupTVC, for: indexPath) as! DealerMarkupTVC
        cell.selectionStyle = .none
        var data = dealerMrkupoStruct.details?.commissionRange?[indexPath.row]
        cell.lblTile.text = "\(data?.from ?? "")-\(data?.to ?? "")"
        cell.lblValNatural.text = "\(data?.natural ?? "")"
        cell.lblValLabGrown.text = "\(data?.labGrown ?? "")"
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    
}

extension DealerMarkupVC : MarkupDataDelegate{

    
    func didUpdateText(natural: String, labGrn: String?, indexPath: IndexPath) {
        //print(self.commissionRange)
        self.commissionRange[indexPath.row].labGrown = labGrn
        self.commissionRange[indexPath.row].natural = natural
       // print(self.commissionRange)
    }
    
    
}


