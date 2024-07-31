//
//  PersonalProfileVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 25/07/24.
//

import UIKit
import DTTextField
import DropDown

class PersonalProfileVC: BaseViewController {
    
    @IBOutlet var txtFirstName:DTTextField!
    @IBOutlet var txtLastName:DTTextField!
    @IBOutlet var txtMobile:DTTextField!
    @IBOutlet var txtEmail:DTTextField!
    @IBOutlet var txtCompanyName:DTTextField!
    @IBOutlet var txtCompanyEmail:DTTextField!
    @IBOutlet var txtCompanyPhone:DTTextField!
    @IBOutlet var txtCompanyType:DTTextField!
    @IBOutlet var txtCompanyNatureBusiness:DTTextField!
    @IBOutlet var btnCountryCode:UIButton!
    @IBOutlet var btnCompanyCountryCode:UIButton!
    
    @IBOutlet var btnCountryFlag:UIButton!
    @IBOutlet var btnCompanyCountryFlag:UIButton!
    
    @IBOutlet var viewCompanyName:UIView!
    @IBOutlet var viewCompanyEmail:UIView!
    @IBOutlet var viewCompanyPhone:UIView!
    @IBOutlet var viewCompanyType:UIView!
    @IBOutlet var viewCompanyNatureOfBusiness:UIView!
    
    
    var profileInfoStruct = ProfileInfoStruct()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtMobile.delegate = self
        txtEmail.delegate = self
        txtCompanyName.delegate = self
        txtCompanyPhone.delegate = self
        txtCompanyEmail.delegate = self
        txtCompanyType.delegate = self
        txtCompanyNatureBusiness.delegate = self
        txtMobile.paddingX = 8
        txtCompanyPhone.paddingX = 80
        
        viewCompanyName.isHidden = true
        viewCompanyEmail.isHidden = true
        viewCompanyPhone.isHidden = true
        viewCompanyType.isHidden = true
        viewCompanyNatureOfBusiness.isHidden = true
        
        txtCompanyType.addInputViewDatePicker(target: self, selector: #selector(companyType))
        
        txtCompanyNatureBusiness.addInputViewDatePicker(target: self, selector: #selector(natureOfbusiness))
        
        self.getProfileInfo()
        // Do any additional setup after loading the view.
    }
    
    @objc func companyType() {
        self.openDropDown(dataArr: self.compaanyTypes, anchorView: viewCompanyType, titleLabel: txtCompanyType, refr: "")
   
    }
    @objc func natureOfbusiness() {
        self.openDropDown(dataArr: self.businessNature, anchorView: viewCompanyType, titleLabel: txtCompanyType, refr: "")
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let dtTextField = textField as? DTTextField {
            dtTextField.borderColor = UIColor.tabSelectClr
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // Change border color or perform any other actions
           if let customTextField = textField as? DTTextField {
               customTextField.borderColor = UIColor.tabSelectClr
           }
       }
       
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
    }
    
    func getProfileInfo(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
//        DispatchQueue.global().async {
            
            let url = APIs().get_ProfileInfo_API
            
            HomeDataModel().getProfileInfo(url: url, completion: { data, msg in
                if data.status == 1{
                  
                    self.profileInfoStruct = data
                    self.setupData()
                    self.toastMessage(msg ?? "")
                }
                else{
                    self.toastMessage(msg ?? "")
                    
                }
                CustomActivityIndicator2.shared.hide()
                
            })
           
            
          
    }
    
    
    func setupData(){
        //"Role":"BUYER"
        if self.profileInfoStruct.details?.role == "BUYER"{
            
            viewCompanyName.isHidden = true
            viewCompanyEmail.isHidden = true
            viewCompanyPhone.isHidden = true
            viewCompanyType.isHidden = true
            viewCompanyNatureOfBusiness.isHidden = true
            
            
            self.txtFirstName.text = self.profileInfoStruct.details?.firstName ?? ""
            self.txtLastName.text = self.profileInfoStruct.details?.lastName ?? ""
            self.txtMobile.text = self.profileInfoStruct.details?.mobileNumber ?? ""
            self.txtEmail.text = self.profileInfoStruct.details?.loginEmailID ?? ""
            
        }
        else{
            
            viewCompanyName.isHidden = false
            viewCompanyEmail.isHidden = false
            viewCompanyPhone.isHidden = false
            viewCompanyType.isHidden = false
            viewCompanyNatureOfBusiness.isHidden = false
            
            self.txtFirstName.text = self.profileInfoStruct.details?.firstName ?? ""
            self.txtLastName.text = self.profileInfoStruct.details?.lastName ?? ""
            self.txtMobile.text = self.profileInfoStruct.details?.mobileNumber ?? ""
            self.txtEmail.text = self.profileInfoStruct.details?.loginEmailID ?? ""
            self.txtCompanyName.text = self.profileInfoStruct.details?.companyName ?? ""
            self.txtCompanyEmail.text = self.profileInfoStruct.details?.companyEmailID ?? ""
            self.txtCompanyPhone.text = self.profileInfoStruct.details?.companyContact ?? ""
            self.txtCompanyType.text = self.profileInfoStruct.details?.typeOfCompany ?? ""
            self.txtCompanyNatureBusiness.text = self.profileInfoStruct.details?.natureOfBusiness ?? ""
            
            self.btnCountryCode.setTitle("+\(self.profileInfoStruct.details?.mobileDialCode ?? "")", for: .normal)
            self.btnCompanyCountryCode.setTitle("+\(self.profileInfoStruct.details?.companyDialCode ?? "")", for: .normal)
        }
    }
    
    
    @IBAction func btnActionCompanyData(_ sender:UIButton){
        switch sender.tag {
        case 0:
            getCountryCode()
        case 1:
            self.openDropDown(dataArr: self.compaanyTypes, anchorView: viewCompanyType, titleLabel: txtCompanyType, refr: "")
        case 2:
            self.openDropDown(dataArr: self.businessNature, anchorView: viewCompanyType, titleLabel: txtCompanyNatureBusiness, refr: "")
        default:
            print("")
        }
    }
    
    
    func openDropDown(dataArr:[String], anchorView:UIView, titleLabel:UITextField, refr:String){
        let dropDown = DropDown()
        dropDown.anchorView = anchorView
        dropDown.dataSource = dataArr
        dropDown.backgroundColor = .whitClr
        dropDown.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        dropDown.shadowColor = UIColor(white: 0.6, alpha: 1)
        dropDown.shadowOpacity = 0.7
        dropDown.shadowRadius = 15
        dropDown.cellHeight = 40
        
        if refr != "FCIntencity"{
            dropDown.height = 250
        }
       
       
//        dropDown.bottomOffset = CGPoint(x: 0, y: anchorView.bounds.height)
        if dropDown.dataSource.count > 10 {
                   dropDown.dismissMode = .onTap
                   dropDown.reloadAllComponents()
               }

        
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            titleLabel.text = dataArr[index]
            dropDown.hide()
            
        }
        dropDown.show()
    }
    
    
    func getCountryCode(){
        
            if let bottomSheet = UIStoryboard.init(name: TVCellIdentifire.customAlertStoryboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: TVCellIdentifire.customAlertController) as? CountryListVC{
                if #available(iOS 15.0, *) {
                    if let sheet = bottomSheet.sheetPresentationController{
                        sheet.detents = [.large()]
                        sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                        
                    }
                } else {
                }
                bottomSheet.modalPresentationStyle = .pageSheet
                bottomSheet.countryInfoDelegate = self
                self.present(bottomSheet, animated: true)
                
              
                
        }
        
    }
    
    @IBAction func btnActionUpdate(_ sender: UIButton){
        updateProfile()
    }
    
    
    
    func updateProfile(){
        
        var parameter : [String:Any] = [:]
        
        if self.profileInfoStruct.details?.role == "BUYER"{
            parameter = ["FirstName" : self.txtFirstName.text ?? "", "LastName" : self.txtLastName.text ?? ""]
        }
        else{
            parameter = [
                "FirstName": self.txtFirstName.text ?? "","LastName" : self.txtLastName.text ?? "","companyContact" : self.txtCompanyPhone.text ?? "","companyName" : self.txtCompanyName.text ?? "","companyEmailId" : self.txtCompanyEmail.text ?? "","typeOfCompany" : self.txtCompanyType.text ?? "","natureOfBusiness" : self.txtCompanyNatureBusiness.text ?? "", "CompanyDialCode": "\(self.btnCompanyCountryCode.currentTitle ?? "")"
            ]
//
        }
        
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
//        DispatchQueue.global().async {
            
            let url = APIs().update_ProfileInfo_API
            
        HomeDataModel().updateProfileInfo(param: parameter, url: url, completion: { data, msg in
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

extension PersonalProfileVC: CountryInfoDelegate {
    func didcountryCodeAndName(countryID: Int, countryCode: String, countryName: String, countryFlag: String) {
        self.btnCompanyCountryCode.setTitle(countryCode, for: .normal)
    }
    
    
}
