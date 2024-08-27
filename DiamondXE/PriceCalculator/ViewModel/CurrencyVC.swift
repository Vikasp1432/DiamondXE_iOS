//
//  CurrencyVC.swift
//  DXE Calc
//
//  Created by Genie Talk on 02/03/23.
//

import UIKit

class CurrencyVC: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet var lblCurrencyName : UILabel!
    @IBOutlet var txtCurrencyValue : UITextField!
    @IBOutlet var btnRefresh : UIButton!
    @IBOutlet var btnCancel : UIButton!
    @IBOutlet var btnDone : UIButton!
    @IBOutlet weak var uiSearchBar: UISearchBar!
    
    @IBOutlet var viewSetCurrencyVal : NSLayoutConstraint!
    @IBOutlet var viewButtons : NSLayoutConstraint!
    @IBOutlet var btnback : UIButton!
    
    @IBOutlet var currencyTableView : UITableView!
    var currencyVal : CurrencyValue?
    var filtercurrencyVal : CurrencyValue?
    var isSearch = false
    var activityView: UIActivityIndicatorView?
    var currencyDefaultVal : Double?
    var currencyVCDelegate : CurrencyVCDelegate?
    var isViewChanges = false
    var currncyVal  = Double()
    var currencyType  = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyTableView.register(UINib(nibName: "CurrencyTVC", bundle: nil), forCellReuseIdentifier: "CurrencyTVC")

        // Do any additional setup after loading the view.
        self.getCurrency()
        uiSearchBar.delegate = self
        txtCurrencyValue.delegate = self
        uiSearchBar.frame.size.height = 50
        self.btnback.isHidden = true
        uiSearchBar.tintColor = UIColor.init(named: "lightGray")
        uiSearchBar.borderColor = UIColor.init(named: "lightGray")
        
        if isViewChanges{
            self.btnback.isHidden = true
        }
        else{
            self.btnback.isHidden = false
        }
    }
    
   
    
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCurrency(){
        showActivityIndicator()
        CalcAlamofireManager.callAPiGetCurrencyJson(OnResultBlock: { (response, status) in
            if status {
                self.hideActivityIndicator()
                let data = response as? Data
                do {
                    let decoder = JSONDecoder()
                    var result = try decoder.decode(CurrencyValue.self, from: data!)
                    //print(result)
                    
                    var modifiedQutos = [String: Double]()
                    
                    result.quotes?.enumerated().forEach({ int, val in
                        let newKey = val.key.replacingOccurrences(of: "USD", with: "")
                        modifiedQutos[newKey] = val.value
                    })
                    result.quotes?.removeAll()
                    result.quotes = modifiedQutos
                    self.currencyVal = result
                    self.setDefaultValue()
                    self.currencyTableView.reloadData()
                } catch {
                    print("Error")
                }
            }
            else{
                self.hideActivityIndicator()
            }
           
            
        })
    }

  
    
    
    func setDefaultValue(){
        if self.currncyVal != 0.0 || !currencyType.isEmpty {
            self.lblCurrencyName.text = currencyType
            self.txtCurrencyValue.text = String(format:"%.2f", currncyVal)//"\(currncyVal)"
            self.currencyTableView.reloadData()
            
          
        }
        else{
            let filterDataUSD = self.currencyVal?.quotes?.filter { $0.key.lowercased().contains("USD".lowercased()) }
            if filterDataUSD != nil{
               
                self.lblCurrencyName.text = "USD"
                let value = "\(filterDataUSD!.values)".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
                let currencyDec = Calculation().decimalManageCurrency(value: Double(value) ?? 0.0)
                self.txtCurrencyValue.text = "\(currencyDec)"
                
            }
        }
        
        
    }
    
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = UIColor(named: "HeadingClr")
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
 
    @IBAction func btnActionRefresh(_ sender: AnyObject) {
     
        let filterData = self.currencyVal?.quotes?.filter { $0.key.lowercased() == self.currencyType.lowercased()}
        var finalVal = Calculation().decimalManageCurrency(value: filterData?.values.first ?? 0.0)
        self.txtCurrencyValue.text = finalVal
    }
    
    @IBAction func btnActionCancel(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnActionDone(_ sender: AnyObject) {

        let viewControllers = self.navigationController!.viewControllers as [UIViewController];
        for aViewController:UIViewController in viewControllers {
            if aViewController.isKind(of: DashboardVC.self) {
                CalcUserDefaultManager().setCurrencyType(currencyValue: self.lblCurrencyName.text ?? "")
                if currencyDefaultVal != nil{
                    CalcUserDefaultManager().setCurrencyValue(currencyValue: self.currencyDefaultVal ?? 0.0)
                    self.currencyVCDelegate?.getCurrency(currencyType: self.lblCurrencyName.text ?? "", currencyVal: self.currencyDefaultVal ?? 0.0)
                }
                else{
                    
                    CalcUserDefaultManager().setCurrencyValue(currencyValue: Double(self.txtCurrencyValue.text ?? "0.0") ?? 0.0)
                    self.currencyVCDelegate?.getCurrency(currencyType: self.lblCurrencyName.text ?? "", currencyVal: Double(self.txtCurrencyValue.text ?? "0.0") ?? 0.0)
                }
               
                _ = self.navigationController?.popToViewController(aViewController, animated: true)
            }
        }
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 < 0{
            self.txtCurrencyValue.text = "\(self.currencyDefaultVal ?? 0.0)"
        }
           self.view.endEditing(true)
           return false
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch{
            return self.filtercurrencyVal?.quotes?.count ?? 0
        }
        else{
            return self.currencyVal?.quotes?.count ?? 0
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTVC", for: indexPath) as! CurrencyTVC
        cell.selectionStyle = .none
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "selectionClr")
//        cell.selectedBackgroundView = view
        
        if isSearch{
            if currencyVal?.quotes?.count ?? 0 > 0{
                let currencyType = Array((self.filtercurrencyVal?.quotes!.keys)!)[indexPath.row]
                cell.lblCurrencyName.text =  currencyType
                let currency = Array((self.filtercurrencyVal?.quotes!.values)!)[indexPath.row]
                let currencyDec = Calculation().decimalManageCurrency(value: currency)
                cell.lblCurrencyValue.text = "\(currencyDec)"
                
                if self.currencyType == currencyType{
                    self.currencyTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                }
                return cell
            }else{
                return cell
            }
        }
        else{
            if currencyVal?.quotes?.count ?? 0 > 0{
                let currencyType = Array((self.currencyVal?.quotes!.keys)!)[indexPath.row]
                cell.lblCurrencyName.text =  currencyType
                let currency = Array((self.currencyVal?.quotes!.values)!)[indexPath.row]
                let currencyDec = Calculation().decimalManageCurrency(value: currency)
                cell.lblCurrencyValue.text = "\(currencyDec)"
                
                if self.currencyType == currencyType{
                    self.currencyTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                }
              
                return cell
            }else{
                return cell
            }
        }
        
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.uiSearchBar.resignFirstResponder()
        self.txtCurrencyValue.resignFirstResponder()
       
        if isSearch{
            self.lblCurrencyName.text =  Array((self.filtercurrencyVal?.quotes!.keys)!)[indexPath.row]
            let currency = Array((self.filtercurrencyVal?.quotes!.values)!)[indexPath.row]
            let currencyDec = Calculation().decimalManageCurrency(value: currency)
            self.txtCurrencyValue.text = "\(currencyDec)"
            self.currencyDefaultVal = Double(currency)
            
        }
        else{
            
            self.lblCurrencyName.text =  Array((self.currencyVal?.quotes!.keys)!)[indexPath.row]
            let currency = Array((self.currencyVal?.quotes!.values)!)[indexPath.row]
            let currencyDec = Calculation().decimalManageCurrency(value: currency)
            self.txtCurrencyValue.text = "\(currencyDec)"
            self.currencyDefaultVal = Double(currency)

        }
    }
    
}


extension CurrencyVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //code
        self.filtercurrencyVal = self.currencyVal
        if searchText.count > 0{
            self.isSearch = true
            let filterData = self.currencyVal?.quotes?.filter { $0.key.lowercased().contains(searchText.lowercased()) }
            self.filtercurrencyVal?.quotes = filterData
            
        }
        else{
            self.isSearch = false
        }
        
        self.currencyTableView.reloadData()

        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         //code
        self.uiSearchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.uiSearchBar.resignFirstResponder()
    }
}
