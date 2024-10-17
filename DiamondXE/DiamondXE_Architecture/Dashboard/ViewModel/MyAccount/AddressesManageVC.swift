//
//  AddressesManageVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 25/07/24.
//

import UIKit

class AddressesManageVC: BaseViewController {
    
    @IBOutlet var tableViewAddresses:UITableView!
    
    
      let sectionHeaders = ["Shipping Address", "", "Billing Address", "Choose a different billing address",""]
      let sectionData = [
          ["Item 1.1", "Item 1.2"],
          ["Item 2.1"],
          ["Item 3.1", "Item 3.2"]
      ]
    
    var billingAddressesStruct = GetAddressStruct()
    var shippingAddressesStruct = GetAddressStruct()
    
    var selectedIndexPathBilling: IndexPath?
    var selectedIndexPathShipping: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewAddresses.delegate = self
        tableViewAddresses.dataSource = self
        
        tableViewAddresses.register(UINib(nibName: ShippingAddressCell.cellIdentifierShippingAddRss, bundle: nil), forCellReuseIdentifier: ShippingAddressCell.cellIdentifierShippingAddRss)
        
        tableViewAddresses.register(UINib(nibName: AddAddressBTNCell.cellIdentifierAddBTNCell, bundle: nil), forCellReuseIdentifier: AddAddressBTNCell.cellIdentifierAddBTNCell)
        
        tableViewAddresses.register(UINib(nibName: SameAddressCell.cellIdentifierSameAddRssCell, bundle: nil), forCellReuseIdentifier: SameAddressCell.cellIdentifierSameAddRssCell)
        
        
        if #available(iOS 15.0, *) {
            tableViewAddresses.sectionHeaderTopPadding = 10
        } else {
            // Fallback on earlier versions
        }

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //get addresses
        fetchDataFromAPIs()
        
    }
    
    func fetchDataFromAPIs() {
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
          // Create a DispatchGroup
          let dispatchGroup = DispatchGroup()
          
         
          // Second API call
          dispatchGroup.enter()
        getShippingAddressAPICalling { success in
              // Leave the group when the API call is complete
              dispatchGroup.leave()
          }
        
        
        // First API call
        dispatchGroup.enter()
      getBillingAddressAPICalling { success in
            // Leave the group when the API call is complete
            dispatchGroup.leave()
        }
        
          
          // Notify when all API calls are complete
          dispatchGroup.notify(queue: .main) {
              // Hide the activity indicator
              CustomActivityIndicator2.shared.hide()
              // Update UI or handle data here
              print("Both API calls completed")
          }
      }
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    
    func getBillingAddressAPICalling(completion: @escaping (Bool) -> Void){
        DispatchQueue.global().async {
            let url = APIs().get_GetAddressBilling_API
            
            HomeDataModel().getAddresses(url: url, completion: { data, msg in
                if data.status == 1{
                    self.billingAddressesStruct = data
                    
                    self.tableViewAddresses.reloadSections(IndexSet(integer: 3), with: .none)
                    
                    completion(true)
                }
                else{
                    self.toastMessage(msg ?? "")
                    completion(false)
                }

                
            })
        }
            
          
    }
    
    func getShippingAddressAPICalling(completion: @escaping (Bool) -> Void){
        DispatchQueue.global().async {

            let url = APIs().get_GetAddressShipping_API
            
            HomeDataModel().getAddresses(url: url, completion: { data, msg in
                if data.status == 1{
                    self.shippingAddressesStruct = data
                    self.tableViewAddresses.reloadSections(IndexSet(integer: 0), with: .none)
                    //self.toastMessage(msg ?? "")
                    completion(true)
                }
                else{
                    completion(false)
                    self.toastMessage(msg ?? "")
                    //                self.isLoading = false
                }
               
                
            })
        }
            
          
    }
    
    
    func deleteAddressAPICalling(indexpa:IndexPath, addressID : String){
        DispatchQueue.main.async {
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            let url = APIs().get_RemoveAddress_API
            let requestParam = ["addressId" : addressID]

            HomeDataModel().deleteAddress(url: url, requestParam: requestParam, completion: { data, msg in
                if data.status == 1{
                    CustomActivityIndicator2.shared.hide()
                    self.fetchDataFromAPIs()
                }
                else{
                    CustomActivityIndicator2.shared.hide()
                    self.toastMessage(msg ?? "")
                }
               
            })
        }
            
          
    }
    

}


extension AddressesManageVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 5 // Return the number of sections
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            if  let data = self.shippingAddressesStruct.details{
                return data.count
            }
            else{
                return 1
            }
       
        case 1:
                return 1
            
        case 2:
                return 1
            
        case 3:
            if  let data = self.billingAddressesStruct.details{
                return data.count
            }
            else{
                return 1
            }
      
        default:
            return 1
        }
        
        //return sectionData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ShippingAddressCell.cellIdentifierShippingAddRss, for: indexPath) as! ShippingAddressCell
            cell.selectionStyle = .none
            if  let data = self.shippingAddressesStruct.details{
                cell.viewData.isHidden = false
                cell.viewNoData.isHidden = true
                cell.lblAddress.text = "Address: \(data[indexPath.row].address1 ?? "")"
                cell.lblPhone.text = "Phone No.: \(data[indexPath.row].mobileNo ?? "")"
                cell.lblEmail.text = "Email: \(data[indexPath.row].emailID ?? "")"
                cell.lblAddressType.text = "Address Type:\(data[indexPath.row].addressType ?? "")"
                cell.lblName.text = "City Name:\(data[indexPath.row].cityNameS ?? "")"
                if data[indexPath.row].isDefault == 1{
                    cell.lblDefault.isHidden = false
                }
                else{
                    cell.lblDefault.isHidden = true
                }
            }
            else{
                cell.viewData.isHidden = true
                cell.viewNoData.isHidden = false
            }
            
            cell.isSelectedCell = (indexPath == selectedIndexPathShipping)
            cell.btnActionCell = { tag in
                switch tag {
                case 0:
                    if  let data = self.shippingAddressesStruct.details{
                        
                        if data[indexPath.row].isDefault == 1{
                            self.toastMessage("Default address cannot be deleted.")
                        }
                        else{
                            self.showDeleteAccountAlert(indexpa: indexPath, addressID: "\(data[indexPath.row].addressID ?? 0)")
                          //  self.deleteAddressAPICalling(indexpa: indexPath, addressID: "\(data[indexPath.row].addressID ?? 0)")
                        }
                    }
                case 1:
                    print("")
                    
                    if let data = self.shippingAddressesStruct.details{                        self.navigationManager(AddShippingAddressVC.self, storyboardName: "ShippingAddress", storyboardID: "AddShippingAddressVC", data: data[indexPath.row])
                    }
                    
                default:
                    if let selected = self.selectedIndexPathShipping {
                        tableView.deselectRow(at: selected, animated: true)
                    }
                    
                    self.selectedIndexPathShipping = indexPath
                    
                    self.tableViewAddresses.reloadSections(IndexSet(integer: 3), with: .none)
                }
            }
            
            
         
            
            return cell
                            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddAddressBTNCell.cellIdentifierAddBTNCell, for: indexPath) as! AddAddressBTNCell
            cell.selectionStyle = .none
            cell.tapAction = {
                self.gotoAddAddress(index: 1)
            }
            return cell
        
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: SameAddressCell.cellIdentifierSameAddRssCell, for: indexPath) as! SameAddressCell
            cell.selectionStyle = .none
            cell.btnActionCell = {tag in
                cell.isSelectedCell.toggle()
            }
            return cell
            
        case 3:

            let cell = tableView.dequeueReusableCell(withIdentifier: ShippingAddressCell.cellIdentifierShippingAddRss, for: indexPath) as! ShippingAddressCell
            cell.selectionStyle = .none
            
            if  let data = self.billingAddressesStruct.details{
                cell.viewData.isHidden = false
                cell.viewNoData.isHidden = true
                cell.lblAddress.text = "Address: \(data[indexPath.row].address1 ?? "")"
                cell.lblPhone.text = "Phone No.: \(data[indexPath.row].mobileNo ?? "")"
                cell.lblEmail.text = "Email: \(data[indexPath.row].emailID ?? "")"
                cell.lblAddressType.text = "Address Type:\(data[indexPath.row].addressType ?? "")"
                cell.lblName.text = "City Name: \(data[indexPath.row].cityNameS ?? "")"
                if data[indexPath.row].isDefault == 1{
                    cell.lblDefault.isHidden = false
                }
                else{
                    cell.lblDefault.isHidden = true
                }
            }
            else{
                cell.viewData.isHidden = true
                cell.viewNoData.isHidden = false
            }
            cell.isSelectedCell = (indexPath == selectedIndexPathBilling)
            cell.btnActionCell = { tag in
                switch tag {
                case 0:
                    if  let data = self.billingAddressesStruct.details{
                        
                        if data[indexPath.row].isDefault == 1{
                            self.toastMessage("Default address cannot be deleted.")
                        }
                        else{
                            self.showDeleteAccountAlert(indexpa: indexPath, addressID: "\(data[indexPath.row].addressID ?? 0)")
                           
                        }
                    }
                case 1:
                    print("")
                    if  let data = self.billingAddressesStruct.details{
                        self.navigationManager(AddBillingAddress.self, storyboardName: "BillingAddress", storyboardID: "AddBillingAddress", data: data[indexPath.row])
                    }
                    
                    
                default:
                    if let selected = self.selectedIndexPathBilling {
                        tableView.deselectRow(at: selected, animated: true)
                    }
                    
                    self.selectedIndexPathBilling = indexPath
                    
                    self.tableViewAddresses.reloadSections(IndexSet(integer: 0), with: .none)
                }
            }
            return cell
            
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AddAddressBTNCell.cellIdentifierAddBTNCell, for: indexPath) as! AddAddressBTNCell
            cell.selectionStyle = .none
            cell.tapAction = {
                self.gotoAddAddress(index: 0)
            }
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            return sectionHeaders[section]
        }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.blackClr
            header.contentView.backgroundColor = UIColor.viewBGClr
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return .leastNormalMagnitude
        }
    
    
    func gotoAddAddress(index:Int){
        if index == 0{
            self.navigationManager(storybordName: "BillingAddress", storyboardID: "AddBillingAddress", controller: AddBillingAddress())
        }
        else{
            self.navigationManager(storybordName: "ShippingAddress", storyboardID: "AddShippingAddressVC", controller: AddShippingAddressVC())
        }
    }
    
    
    func showDeleteAccountAlert(indexpa:IndexPath, addressID : String) {
        // Create the alert controller
        let alert = UIAlertController(title: "Delete Account",
                                      message: "Are you sure you want to delete this address",
                                      preferredStyle: .alert)
        
        // Add the Delete action
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteAddressAPICalling(indexpa: indexpa, addressID: addressID)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
