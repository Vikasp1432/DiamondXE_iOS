//
//  QuatationHistoryVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 10/10/24.
//

import UIKit

class QuatationHistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var uiSearchBar: UISearchBar!
    @IBOutlet weak var listQATableView: UITableView!
    
    @IBOutlet weak var btnNatural: UIButton!
    @IBOutlet weak var btnLabGrown: UIButton!
    
    var isSearch = false
    
    var quotations = [Quotationstruct]()
    var searchQuotations = [Quotationstruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listQATableView.register(UINib(nibName: "QuatationListTVC", bundle: nil), forCellReuseIdentifier: "QuatationListTVC")
        uiSearchBar.delegate = self
        uiSearchBar.frame.size.height = 50
        uiSearchBar.tintColor = UIColor.init(named: "lightGray")
        uiSearchBar.borderColor = UIColor.init(named: "lightGray")
        
        btnNatural.isSelected = false
            btnLabGrown.isSelected = false

            // Set default images for deselected state
            btnNatural.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
            btnLabGrown.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
        
     
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.quotations = CalcUserDefaultManager().getSavedQuotations().reversed()
        self.listQATableView.reloadData()
    }
    
    @IBAction func btnactionsManage(_ sender : UIButton){
        
//        if sender.tag == 0{
//            self.btnNatural.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
//            self.btnLabGrown.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
//            // self.btnActionsCancel(selectedItemsArray)
//            
//            self.searchQuotations = self.quotations
//            
//                self.isSearch = true
//                // Filter quotations array based on productName
//                let filterData = self.quotations.filter {
//                    $0.productName?.lowercased().contains("natural") == true
//                }
//                self.searchQuotations = filterData
//                self.listQATableView.reloadData()
//        }
//        else if sender.tag == 1{
//            self.btnNatural.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
//            self.btnLabGrown.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
//            
//            self.searchQuotations = self.quotations
//            
//                self.isSearch = true
//                // Filter quotations array based on productName
//                let filterData = self.quotations.filter {
//                    $0.productName?.lowercased().contains("labgrown") == true
//                }
//                self.searchQuotations = filterData
//            self.listQATableView.reloadData()
//            
//            
//            
//        }
        if sender == btnNatural { // Natural Button Tapped
              if sender.isSelected {
                  // Deselect the button
                  sender.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
                  sender.isSelected = false
                  self.isSearch = false
                  self.searchQuotations = self.quotations // Reset to original data
              } else {
                  // Select the button
                  btnNatural.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
                  btnNatural.isSelected = true
                  
                  // Deselect Lab Grown
                  btnLabGrown.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
                  btnLabGrown.isSelected = false

                  // Apply filter
                  self.isSearch = true
                  let filterData = self.quotations.filter {
                      $0.natualOrLabGrown?.lowercased().contains("Natural Diamond".lowercased()) == true
                  }
                  self.searchQuotations = filterData
              }
          } else if sender == btnLabGrown { // Lab Grown Button Tapped
              if sender.isSelected {
                  // Deselect the button
                  sender.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
                  sender.isSelected = false
                  self.isSearch = false
                  self.searchQuotations = self.quotations // Reset to original data
              } else {
                  // Select the button
                  btnLabGrown.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
                  btnLabGrown.isSelected = true
                  
                  // Deselect Natural
                  btnNatural.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
                  btnNatural.isSelected = false

                  // Apply filter
                  self.isSearch = true
                  let filterData = self.quotations.filter {
                      $0.natualOrLabGrown?.lowercased().contains("Lab Grown Diamond".lowercased()) == true
                  }
                  self.searchQuotations = filterData
              }
          }

          // Reload the table view to show updated data
          self.listQATableView.reloadData()
       
    }
    
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch{
            return self.searchQuotations.count
        }
        else{
            return self.quotations.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuatationListTVC", for: indexPath) as! QuatationListTVC
        cell.selectionStyle = .none
        //        let view = UIView()
        //        view.backgroundColor = UIColor(named: "selectionClr")
        //        cell.selectedBackgroundView = view
        
        if isSearch{
            if quotations.count > 0{
                let indexData = self.searchQuotations[indexPath.row]
                cell.lbldate.text = "\(indexData.dateStr ?? "")"
                cell.lblKt.text = indexData.purityType
                cell.lblName.text = indexData.productName ?? ""
                cell.lblGrandTotl.text = indexData.grandTotal
                return cell
            }else{
                return cell
            }
            
        }else{
            if quotations.count > 0{
            let indexData = self.quotations[indexPath.row]
                cell.lbldate.text = "\(indexData.dateStr ?? "")"
                cell.lblKt.text = indexData.purityType
                cell.lblName.text = indexData.productName ?? ""
            cell.lblGrandTotl.text = indexData.grandTotal
            
            return cell
        }else{
            return cell
        }
    }
    
    
}

    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.uiSearchBar.resignFirstResponder()
        let vc = UIStoryboard(name: "JewelleryCalc", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuotatiosVC") as? QuotatiosVC
        
        if isSearch{
            let indexData = self.searchQuotations[indexPath.row]
           
                vc?.metalwt = indexData.metalwt ?? 0
                vc?.metalRatePGm = indexData.metalRatePGm ?? 0
                vc?.metalwtTotal = indexData.metalwtTotal ?? 0
                vc?.labourChar = indexData.labourChar ?? 0
                vc?.labourCharRatePGm = indexData.labourCharRatePGm ?? 0
                vc?.labourCharTotal = indexData.labourCharTotal ?? 0
                vc?.solitairwt = indexData.solitairwt ?? 0
                vc?.solitairRatePCt = indexData.solitairRatePCt ?? 0
                vc?.solitairTotal = indexData.solitairTotal ?? 0
                vc?.sideDIA = indexData.sideDIA ?? 0
                vc?.sideDIARatePCt = indexData.sideDIARatePCt ?? 0
                vc?.sideDIATotal = indexData.sideDIATotal ?? 0
                vc?.colStoneWt = indexData.colStoneWt ?? 0
                vc?.colStonePCt = indexData.colStonePCt ?? 0
                vc?.colStoneTotal = indexData.colStoneTotal ?? 0
                vc?.extraCharges = indexData.extraCharges ?? 0
                vc?.taxCharges = indexData.taxCharges ?? 0
                vc?.taxCalculation = indexData.taxCalculation ?? 0
                vc?.currncyVal = indexData.currncyVal ?? 0
                vc?.currencyType = indexData.currencyType ?? ""
                vc?.natualOrLabGrown = indexData.natualOrLabGrown ?? ""
                vc?.solitaierNotes = indexData.solitaierNotes ?? ""
                vc?.sideDiaNotes = indexData.sideDiaNotes ?? ""
                vc?.otherCharges = indexData.otherCharges ?? ""
                vc?.productName = indexData.productName ?? ""
                vc?.purityType = indexData.purityType ?? ""
                vc?.grandTotal = indexData.grandTotal ?? ""
                vc?.priceWitCurr = indexData.priceWitCurr ?? ""
                vc?.date = indexData.dateStr ?? ""
            
            
        }
        else{
            let indexData = self.quotations[indexPath.row]
          
                vc?.metalwt = indexData.metalwt ?? 0
                vc?.metalRatePGm = indexData.metalRatePGm ?? 0
                vc?.metalwtTotal = indexData.metalwtTotal ?? 0
                vc?.labourChar = indexData.labourChar ?? 0
                vc?.labourCharRatePGm = indexData.labourCharRatePGm ?? 0
                vc?.labourCharTotal = indexData.labourCharTotal ?? 0
                vc?.solitairwt = indexData.solitairwt ?? 0
                vc?.solitairRatePCt = indexData.solitairRatePCt ?? 0
                vc?.solitairTotal = indexData.solitairTotal ?? 0
                vc?.sideDIA = indexData.sideDIA ?? 0
                vc?.sideDIARatePCt = indexData.sideDIARatePCt ?? 0
                vc?.sideDIATotal = indexData.sideDIATotal ?? 0
                vc?.colStoneWt = indexData.colStoneWt ?? 0
                vc?.colStonePCt = indexData.colStonePCt ?? 0
                vc?.colStoneTotal = indexData.colStoneTotal ?? 0
                vc?.extraCharges = indexData.extraCharges ?? 0
                vc?.taxCharges = indexData.taxCharges ?? 0
                vc?.taxCalculation = indexData.taxCalculation ?? 0
                vc?.currncyVal = indexData.currncyVal ?? 0
                vc?.currencyType = indexData.currencyType ?? ""
                vc?.natualOrLabGrown = indexData.natualOrLabGrown ?? ""
                vc?.solitaierNotes = indexData.solitaierNotes ?? ""
                vc?.sideDiaNotes = indexData.sideDiaNotes ?? ""
                vc?.otherCharges = indexData.otherCharges ?? ""
                vc?.productName = indexData.productName ?? ""
                vc?.purityType = indexData.purityType ?? ""
                vc?.grandTotal = indexData.grandTotal ?? ""
                vc?.priceWitCurr = indexData.priceWitCurr ?? ""
                vc?.date = indexData.dateStr ?? ""
            
        }
            
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}


extension QuatationHistoryVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //code
        self.searchQuotations = self.quotations
        if searchText.count > 0 {
            self.isSearch = true
            // Filter quotations array based on productName
            let filterData = self.quotations.filter {
                $0.productName?.lowercased().contains(searchText.lowercased()) == true
            }
            self.searchQuotations = filterData
        } else {
            self.isSearch = false
        }

        // Reload table view
        self.listQATableView.reloadData()
        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         //code
        self.uiSearchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.uiSearchBar.resignFirstResponder()
    }
}
