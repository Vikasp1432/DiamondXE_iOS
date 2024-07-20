//
//  CountryListVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/04/24.
//

import UIKit
import SDWebImage


class CountryListVC: BaseViewController {
    
    @IBOutlet var tbleCountryList : UITableView!
    @IBOutlet var viewSearchBar:UIView!
    @IBOutlet var viewBackground:UIView!
    @IBOutlet var searchBar: UISearchBar!


    var countryInfoDelegate : CountryInfoDelegate?
    var stateInfoDelegate : StateInfoDelegate?
    var cityInfoDelegate : CityInfoDelegate?
    var countryList = CountryListStruct()
    var stateList = StateListStruct()
    var cityList = CityListStruct()
    var filteredCountryList = CountryListStruct()
    var filteredStateList = StateListStruct()
    var filteredCityList = CityListStruct()
    var searchBarDelegate : CustomSearchBarDelegate?
    var searching = false
    var countryID = Int()
    var stateID = Int()
    var isGetStateList = 0
    var parameters : [String:Any]?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false

        //get country/state/city list
        setupApiCalling()
        
    }
    
    
    func setupApiCalling(){
        switch isGetStateList {
        case 0, 1:
            self.getCountryList()
        case 2:
            self.getStateList(param: ["countryId": countryID])
        default:
            self.getCityList(param: ["stateId": stateID])
        }
    }
   

}


extension CountryListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch isGetStateList {
        case 0, 1:
            if searchText.isEmpty {
                self.filteredCountryList = self.countryList
                searching = false

            } else {
                searching = true
                if let details = countryList.details {
                    filteredCountryList.details = details.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
                }
               
            }
            tbleCountryList.reloadData()
        case 2:
            if searchText.isEmpty {
                
                self.filteredStateList = self.stateList
                searching = false

                
            } else {
                searching = true
                if let details = stateList.details {
                    filteredStateList.details = details.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
                }
               
            }
            tbleCountryList.reloadData()
        default:
            if searchText.isEmpty {
                
                self.filteredCityList = self.cityList
                searching = false

                
            } else {
                searching = true
                if let details = cityList.details {
                    filteredCityList.details = details.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
                }
               
            }
            tbleCountryList.reloadData()
        }
        
          
       }
}


extension CountryListVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch isGetStateList {
        case 0, 1:
            if searching {
                self.filteredCountryList.details?.count ?? 0
            } else {
                self.countryList.details?.count ?? 0
            }
        case 2:
            if searching {
                self.filteredStateList.details?.count ?? 0
            } else {
                self.stateList.details?.count ?? 0
            }
        default:
            if searching {
                self.filteredCityList.details?.count ?? 0
            } else {
                self.cityList.details?.count ?? 0
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath) as! CountryListCell
        cell.selectionStyle = .none
        
        switch isGetStateList {
        case 0, 1:
            if searching {
                let nameWithCode = "\(self.filteredCountryList.details?[indexPath.row].phonecode ?? "")\(" ")\(self.filteredCountryList.details?[indexPath.row].name ?? "")"
                cell.lblCountryName?.text =  nameWithCode
                cell.imgFlag?.sd_setImage(with: URL( string: (self.filteredCountryList.details?[indexPath.row].flag ?? "")), completed: nil)
               
            }
            else{
                let nameWithCode = "\(self.countryList.details?[indexPath.row].phonecode ?? "")\(" ")\(self.countryList.details?[indexPath.row].name ?? "")"
                cell.lblCountryName?.text =  nameWithCode
                cell.imgFlag?.sd_setImage(with: URL( string: (self.countryList.details?[indexPath.row].flag ?? "")), completed: nil)
            }

        case 2:
            if searching {
                let nameWithCode = "\(self.filteredStateList.details?[indexPath.row].name ?? "")"
                cell.lblCountryName?.text =  nameWithCode
                cell.imgFlag.isHidden = true
               
            }
            else{
                let nameWithCode = "\(self.stateList.details?[indexPath.row].name ?? "")"
                cell.lblCountryName?.text =  nameWithCode
                cell.imgFlag.isHidden = true
            }

        default:
            if searching {
                let nameWithCode = "\(self.filteredCityList.details?[indexPath.row].name ?? "")"
                cell.lblCountryName?.text =  nameWithCode
                cell.imgFlag.isHidden = true
               
            }
            else{
                let nameWithCode = "\(self.cityList.details?[indexPath.row].name ?? "")"
                cell.lblCountryName?.text =  nameWithCode
                cell.imgFlag.isHidden = true
            }

        }
        
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch isGetStateList {
        case 0, 1:
            if searching {
                countryInfoDelegate?.didcountryCodeAndName(countryID: (self.filteredCountryList.details?[indexPath.row].id ?? 0),countryCode: "\(self.filteredCountryList.details?[indexPath.row].phonecode ?? "")", countryName: "\(self.filteredCountryList.details?[indexPath.row].name ?? "")", countryFlag: "\(self.filteredCountryList.details?[indexPath.row].flag ?? "")")
                self.dismiss(animated: true)
            }
            else{
                countryInfoDelegate?.didcountryCodeAndName(countryID: (self.countryList.details?[indexPath.row].id ?? 0),countryCode: "\(self.countryList.details?[indexPath.row].phonecode ?? "")", countryName: "\(self.countryList.details?[indexPath.row].name ?? "")", countryFlag: "\(self.countryList.details?[indexPath.row].flag ?? "")")
                self.dismiss(animated: true)
            }
        case 2:
            if searching {
                stateInfoDelegate?.didGetStateName(stateID: (self.filteredStateList.details?[indexPath.row].id ?? 0), stateName: (self.filteredStateList.details?[indexPath.row].name ?? ""))
                self.dismiss(animated: true)
            }
            else{
                stateInfoDelegate?.didGetStateName(stateID: (self.stateList.details?[indexPath.row].id ?? 0), stateName: (self.stateList.details?[indexPath.row].name ?? ""))
                self.dismiss(animated: true)
            }
        default:
            if searching {
                self.cityInfoDelegate?.didGetCityName(cityID: self.filteredCityList.details?[indexPath.row].id ?? 0, cityName: self.filteredCityList.details?[indexPath.row].name ?? "")
                
                self.dismiss(animated: true)
            }
            else{
                
                self.cityInfoDelegate?.didGetCityName(cityID: self.cityList.details?[indexPath.row].id ?? 0, cityName: self.cityList.details?[indexPath.row].name ?? "")
                
                self.dismiss(animated: true)
            }
        }
        
        
    }
    
    // get country list
    func getCountryList(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        LoginDataModel().getCountryList(url: APIs().country_list_API, requestParam: [:], completion: { countryList , message in
            //print(loginData)
            if countryList.status == 1{
               // print(message)
                self.countryList = countryList
                self.filteredCountryList = countryList
                self.tbleCountryList.reloadData()
            }
            else{
                self.toastMessage(message ?? "")
            }
            CustomActivityIndicator2.shared.hide()
            
        })
    }
    
    // get state list
    func getStateList(param:[String:Any]){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        SignupDataModel().getStateList(url: APIs().state_list_API, requestParam: param, completion: { stateList , message in
            if stateList.status == 1{
               // print(message)
                self.stateList = stateList
                self.filteredStateList = stateList
                self.tbleCountryList.reloadData()
            }
            else{
                self.toastMessage(message ?? "")
            }
            CustomActivityIndicator2.shared.hide()
            
        })
    }
    
    // get city list
    func getCityList(param:[String:Any]){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        SignupDataModel().getCityList(url: APIs().city_list_API, requestParam: param, completion: { cityList , message in
            if cityList.status == 1{
               // print(message)
                self.cityList = cityList
                self.filteredCityList = cityList
                self.tbleCountryList.reloadData()
            }
            else{
                self.toastMessage(message ?? "")
            }
            CustomActivityIndicator2.shared.hide()
            
        })
    }
    
   
    @IBAction func btnActionCancel( _ sender : UIButton){
        self.dismiss(animated: true)
    }
    
    
}


class CountryListCell : UITableViewCell {
    @IBOutlet var imgFlag : UIImageView!
    @IBOutlet var lblCountryName:UILabel!
}
