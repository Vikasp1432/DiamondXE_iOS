//
//  DashboardLoginVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 16/05/24.
//

import UIKit

class DashboardLoginVC: BaseViewController , ChildViewControllerProtocol {
    
    func didSendString(str: String) {
        print(str)
    }
    
    var delegate : BaseViewControllerDelegate?
    
    
    @IBOutlet var menuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self

        // Do any additional setup after loading the view.
        
        menuTableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        menuTableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
        menuTableView.showsHorizontalScrollIndicator = false
        menuTableView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showLogoutConfirmationAlert() {
           let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to Delete this acount?", preferredStyle: .alert)
           
           // Add the cancel action
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alert.addAction(cancelAction)
           
           // Add the logout action
           let logoutAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
               // Perform logout logic here
               self.callAPIDeleteAccount()
           }
           alert.addAction(logoutAction)
           
           present(alert, animated: true, completion: nil)
       }
    
    private func showLogoutAlert() {
           let alert = UIAlertController(title: "Alert", message: "Need to login first", preferredStyle: .alert)
           
           // Add the cancel action
           let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
           alert.addAction(cancelAction)
           
           present(alert, animated: true, completion: nil)
       }
    
    


}

extension DashboardLoginVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return sectionsAccountProfile.count
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let section = sectionsAccountProfile[section]
            if section.isExpandableCellsHidden {
                return 1
            } else {
                return section.expandableCellOptions.count + 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier, for: indexPath) as! MainCell
                cell.configure2(with: sectionsAccountProfile[indexPath.section])
                cell.mainIconIMG.image = sectionsAccountProfile[indexPath.section].mainCellOptionsIcons[indexPath.section]
                
                cell.tapCell = {
                    if indexPath.row == 0 {
                        let section = indexPath.section
                        
                        self.sideMenuActions(sectionStr: self.sectionsAccountProfile[section].mainCellTitle)
                        
                        let isCurrentlyHidden = self.sectionsAccountProfile[section].isExpandableCellsHidden
                        self.sectionsAccountProfile[section].isExpandableCellsHidden = !isCurrentlyHidden
                        self.sectionsAccountProfile[section].isExpanded = !isCurrentlyHidden // Update the expanded state

                        if self.sectionsAccountProfile[section].expandableCellOptions.isEmpty {
                            // If there are no expandable options, do nothing
                            return
                        }

                        var indexPaths = [IndexPath]()
                        for row in 1...self.sectionsAccountProfile[section].expandableCellOptions.count {
                            indexPaths.append(IndexPath(row: row, section: section))
                        }
                        
                        tableView.beginUpdates()
                        if isCurrentlyHidden {
                            // Expand the section with animation
                            tableView.insertRows(at: indexPaths, with: .fade)
                        } else {
                            // Collapse the section with animation
                            tableView.deleteRows(at: indexPaths, with: .fade)
                        }
                        tableView.endUpdates()

                        // Reload the main cell to update the icon
                        let mainCellIndexPath = IndexPath(row: 0, section: section)
                        tableView.reloadRows(at: [mainCellIndexPath], with: .none)
                    }
                    
                    else{
                        self.sideMenuActions(sectionStr: self.sectionsAccountProfile[indexPath.section].expandableCellOptions[indexPath.row - 1])
                    }
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.cellIdentifier, for: indexPath) as! ExpandableCell
                cell.label.text = sectionsAccountProfile[indexPath.section].expandableCellOptions[indexPath.row - 1]
                cell.iconIMG.image = sectionsAccountProfile[indexPath.section].expandableCellOptionsIcons[indexPath.row - 1]
                
                cell.tapCell = {
                    print(indexPath.row)
                    self.myAcountVCsNavi(index: indexPath.row)
                }
                
                return cell
            }
        }
    
    
    func myAcountVCsNavi(index:Int){
        
        let loginData = UserDefaultManager().retrieveLoginData()
        if let data = loginData?.details?.userRole{
           switch index {
            case 1:
                self.navigationManager(storybordName: "Dashboard", storyboardID: "PersonalProfileVC", controller: PersonalProfileVC())
            case 2:
                self.navigationManager(storybordName: "Dashboard", storyboardID: "AddressesManageVC", controller: AddressesManageVC())
           case 4:
               self.navigationManager(storybordName: "Dashboard", storyboardID: "ChangePasswordVC", controller: ChangePasswordVC())
            default:
               self.navigationManager(storybordName: "Dashboard", storyboardID: "KYCVerification", controller: KYCVerification())
            }
        }
        else{
            self.navigationManager(storybordName: "Login", storyboardID: "LoginVC", controller: LoginVC())
        }
    }
    
    
        

    
    func sideMenuActions(sectionStr:String){
        
        if account_delete == sectionStr{
            let loginData = UserDefaultManager().retrieveLoginData()
            if let authToken = loginData?.details?.authToken{
                self.showLogoutConfirmationAlert()
            }
            else{
                self.showLogoutAlert()
            }
        }
        else if account_payment == sectionStr{
            
            let loginData = UserDefaultManager().retrieveLoginData()
            if let authToken = loginData?.details?.authToken{
                self.navigationManager(storybordName: "CustomPayment", storyboardID: "CustomPaymentVC", controller: CustomPaymentVC())
            }
            else{
                self.navigationManager(storybordName: "Login", storyboardID: "LoginVC", controller: LoginVC())
            }
            
        }
        
        else if account_order == sectionStr{
            
            let loginData = UserDefaultManager().retrieveLoginData()
            if let authToken = loginData?.details?.authToken{
                self.navigationManager(storybordName: "MyOrder", storyboardID: "MyOrderBaseVC", controller: MyOrderBaseVC())
            }
            else{
                self.navigationManager(storybordName: "Login", storyboardID: "LoginVC", controller: LoginVC())
            }
            
          
        }
        
        
        else if account_wallet == sectionStr{
            let loginData = UserDefaultManager().retrieveLoginData()
//            if let userType = loginData?.details?.userRole{
//                if userType.lowercased() == "buyer"{
//                    return
//                }
//            }
            if let authToken = loginData?.details?.authToken{
                self.navigationManager(storybordName: "Dashboard", storyboardID: "WalletHistoryVC", controller: WalletHistoryVC())
            }
            else{
                self.navigationManager(storybordName: "Login", storyboardID: "LoginVC", controller: LoginVC())
            }
        }
        
        else if account_markup == sectionStr{
            let loginData = UserDefaultManager().retrieveLoginData()
            if let userType = loginData?.details?.userRole{
                if userType.lowercased() == "buyer"{
                    return
                }
            }
            if let authToken = loginData?.details?.authToken{
                self.navigationManager(storybordName: "Dashboard", storyboardID: "DealerMarkupVC", controller: DealerMarkupVC())
            }
            else{
                self.navigationManager(storybordName: "Login", storyboardID: "LoginVC", controller: LoginVC())
            }
        }
        
        
    }
    
    
    func callAPIDeleteAccount(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            
        let sessionID = getSessionUniqID()
        let url = APIs().deleteAccount_API
        let param : [String:Any] = ["deviceId": sessionID]
            
        HomeDataModel().deleteUserAccount(param: param, url: url, completion: { data, msg in
                if data.status == 1{
                    self.toastMessage(msg ?? "")
                    UserDefaultManager.shareInstence.clearLoginDataDefaults()
                  //  self.btnTitleLogin.setTitle("Account", for: .normal)
//                    self.lblWelcomeUser.text = "Welcome User"
//                    self.lblType.text = "--"
                }
                else{
                    self.toastMessage(msg ?? "")
                    
                }
                CustomActivityIndicator2.shared.hide()
                
            })
    }
    
}
