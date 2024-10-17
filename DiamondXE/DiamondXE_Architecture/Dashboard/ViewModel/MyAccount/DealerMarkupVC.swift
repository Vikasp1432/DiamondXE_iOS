//
//  DealerMarkupVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 01/10/24.
//

import UIKit

class DealerMarkupVC: BaseViewController {
    
    
    @IBOutlet var tableViewMarkupLbl : UITableView!
    
    @IBOutlet var btnReset : UIButton!
    @IBOutlet var btnUpdate : UIButton!
    
    
    var dealerMrkupoStruct = DealerMarkupStruct()
    var commissionRange = [CommissionRange]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMarkupLbl.register(UINib(nibName: DealerMarkupTVC.cellIdentifierDealerMarkupTVC, bundle: nil), forCellReuseIdentifier: DealerMarkupTVC.cellIdentifierDealerMarkupTVC)
        
        self.btnReset.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        self.btnUpdate.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        self.getDealerMarkupInfo(completion: {
            CustomActivityIndicator2.shared.hide()
        })
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionUpdate(_ sender: UIButton){
        
        if sender.tag == 0{
            self.updateDealerMarkupInfo()
        }
        else{
            self.commissionRange.enumerated().forEach{ index, val in
                self.commissionRange[index].labGrown = "0"
                self.commissionRange[index].natural = "0"
            }
            
            self.updateDealerMarkupInfo()
        }
        
       
    }
 
    func updateDealerMarkupInfo() {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)

        let url = APIs().updateDealerMrkupInfo_API
        var param: [String: Any] = [:]

        do {
            let jsonData = try JSONEncoder().encode(self.commissionRange)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                param = ["CommissionRange": jsonString]
            }
        } catch {
            print("Error encoding JSON: \(error)")
            CustomActivityIndicator2.shared.hide()
            return
        }

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        HomeDataModel().getUpdateDealerMarkup(param: param, url: url) { data, msg in
            if data.status == 1 {
                self.toastMessage(msg ?? "")
            } else {
                self.toastMessage(msg ?? "")
            }
            
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.getDealerMarkupInfo {
                CustomActivityIndicator2.shared.hide()
            }
        }
    }

    func getDealerMarkupInfo(completion: @escaping () -> Void) {
        let url = APIs().getDealerMrkupInfo_API
        HomeDataModel().getDealerMarkup(url: url) { data, msg in
            if data.status == 1 {
                self.dealerMrkupoStruct = data
                if let commitionRng = data.details?.commissionRange {
                    self.commissionRange = commitionRng
                }
                self.tableViewMarkupLbl.reloadData()
            } else {
                self.toastMessage(msg ?? "")
            }

            // Call the completion handler when done
            completion()
        }
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
        let data = dealerMrkupoStruct.details?.commissionRange?[indexPath.row]
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


