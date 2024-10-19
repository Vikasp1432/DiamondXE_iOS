//
//  KYCDocStatusTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/09/24.
//

import UIKit

class KYCDocStatusTVC: UITableViewCell {
    
    static let cellIdentifierShippingKYCDocStatusTVC = String(describing: KYCDocStatusTVC.self)
    
    
    @IBOutlet var lblAdahrFrontStatus:UILabel!
    @IBOutlet var lblAdahrBackStatus:UILabel!
    @IBOutlet var lblPanCardStatus:UILabel!
    @IBOutlet var lblComPanCardStatus:UILabel!
    @IBOutlet var lblCompanyGSTStatus:UILabel!
    @IBOutlet var lblIECCardStatus:UILabel!
    @IBOutlet var lblPassportFrontStatus:UILabel!
    @IBOutlet var lblPassportBackStatus:UILabel!
    @IBOutlet var lblAdahrFrontSubmitDate:UILabel!
    @IBOutlet var lblAdahrBackSubmitDate:UILabel!
    @IBOutlet var lblPanCardSubmitDate:UILabel!
    @IBOutlet var lblComPanCardSubmitDate:UILabel!
    @IBOutlet var lblCompanyGSTSubmitDate:UILabel!
    @IBOutlet var lblIECCardSubmitDate:UILabel!
    @IBOutlet var lblPassportFrontSubmitDate:UILabel!
    @IBOutlet var lblPassportBackSubmitDate:UILabel!
    
    @IBOutlet var lblDrivingLicenceStatus:UILabel!
    @IBOutlet var lblDrivingLicenceSubmitDate:UILabel!
    @IBOutlet var btnSubmiited:UIButton!
    
    @IBOutlet var viewAAdharFrount:UIView!
    @IBOutlet var viewAAdharBacK:UIView!
    @IBOutlet var viewPANCad:UIView!
    @IBOutlet var viewPassportPront:UIView!
    @IBOutlet var viewPassportBack:UIView!
    @IBOutlet var viewDrivingLicence:UIView!
    @IBOutlet var viewCompanyPAN:UIView!
    @IBOutlet var viewCompanyGST:UIView!
    @IBOutlet var viewIEC:UIView!
    @IBOutlet var stackViewCompanyPAN:UIView!
    @IBOutlet var stackViewCompanyGST:UIView!
    @IBOutlet var stackViewIEC:UIView!
    @IBOutlet var stackViewAAdharFrount:UIView!
    @IBOutlet var stackViewAAdharBacK:UIView!
    @IBOutlet var stackViewPANCad:UIView!
    @IBOutlet var stackViewPassportPront:UIView!
    @IBOutlet var stackViewPassportBack:UIView!
    @IBOutlet var stackViewDrivingLicence:UIView!
    
  
   
    
    var isDocGST = false
    var isDocIEC = false
    var isDocAAdhaarFront = false
    var isDocAAdhaarBack = false
    var isDocPAN = false
    var isDocPassportFront = false
    var isDocPassportBack = false
    var isDocDrivingLicence = false
    var isDocComapnyPAN = false
    var isDocCompanyGST = false
    
    var companyGSTDocID = Int()
    var companyPANDocID = Int()
    var IECDocID = Int()
    var aadhaarFrontDocID = Int()
    var aadhaarBackDocID = Int()
    var pANDocID = Int()
    var passportFrontDocID = Int()
    var passportBackDocID = Int()
    var DrivingLincDocID = Int()
    
    var kycDocDataStruct =  KYCDataStruct()
    let loginData = UserDefaultManager().retrieveLoginData()
    
    var objectVC : ShippingModuleVC?
    
    var isUserIndian = false
    
    
    @IBOutlet var viewData:UIView!
    var btnActionResubmit : (() -> Void) = { }
    
    var reloadTBLE : ((KYCDataStruct) -> Void) = { _ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewData.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewData.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewData.layer.shadowRadius = 2.0
        viewData.layer.shadowOpacity = 0.5
        viewData.layer.masksToBounds = false
        
        self.viewAAdharFrount.isHidden = true
        self.viewAAdharBacK.isHidden = true
        self.viewPANCad.isHidden = true
        self.viewPassportPront.isHidden = true
        self.viewPassportBack.isHidden = true
        self.viewDrivingLicence.isHidden = true
        self.viewCompanyPAN.isHidden = true
        self.viewCompanyGST.isHidden = true
        self.viewIEC.isHidden = true
        self.stackViewCompanyPAN.isHidden = true
        self.stackViewCompanyGST.isHidden = true
        self.stackViewIEC.isHidden = true
        self.stackViewAAdharFrount.isHidden = true
        self.stackViewAAdharBacK.isHidden = true
        self.stackViewPANCad.isHidden = true
        self.stackViewPassportPront.isHidden = true
        self.stackViewPassportBack.isHidden = true
        self.stackViewDrivingLicence.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    @IBAction func btnActionAdd(_ sender : UIButton){
        btnActionResubmit()
    }
    
    func isIndianPhoneNumber(_ phoneNumber: String) -> Bool {
        let cleanedPhoneNumber = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let indiaPattern = "^(\\+91|91|0)?[6-9][0-9]{9}$"
        let indiaPhoneTest = NSPredicate(format: "SELF MATCHES %@", indiaPattern)
        return indiaPhoneTest.evaluate(with: cleanedPhoneNumber)
    }
    
    func baseVCObj(vc : ShippingModuleVC) {
        
        
        let loginData = UserDefaultManager().retrieveLoginData()
        if let mobile = loginData?.details?.mobileNo{
            if self.isIndianPhoneNumber(mobile){
                self.isUserIndian = true
            }
            else{
                self.isUserIndian = false
            }
        }
        
        
        self.objectVC = vc
        
        
        if let data = kycDocDataStruct.details{
            
        }
        else{
            callingAPIGetKYCDocs()
        }
       
        
    }
    
    
    
    
//    func callingAPIGetKYCDocs(){
//        if let vc = objectVC{
//                    
//        CustomActivityIndicator2.shared.show(in: vc.view, gifName: "diamond_logo", topMargin: 300)
//        
//        let url =  APIs().get_KYCDoc_API
//        
//        
//        KYCDataModel().getKYCDocumentStatus(url: url, completion: { data, msg in
//            CustomActivityIndicator2.shared.hide()
//            if data.status == 1{
//                self.kycDocDataStruct = data
//                if data.details?.allDocument?.count ?? 0 > 0{
//                   // CustomActivityIndicator2.shared.hide()
//                    self.sataSetup()
//                    vc.btnProceadPayment.setTitle("Continue", for: .normal)
//                    vc.isresubmitTag = false
//                    //vc.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
//                }
//                else{
//                    vc.btnProceadPayment.setTitle("Submit", for: .normal)
//                    vc.isresubmitTag = true
//                   // vc.shippingTableView.reloadSections(IndexSet(integer: 0), with: .none)
//                }
//               
//            }
//            else{
//                vc.toastMessage(msg ?? "")
//            }
//           //CustomActivityIndicator2.shared.hide()
//            
//        })
//    }
//    }
    
    func callingAPIGetKYCDocs() {
        if let vc = objectVC {
            CustomActivityIndicator2.shared.show(in: vc.view, gifName: "diamond_logo", topMargin: 300)
            
            let url = APIs().get_KYCDoc_API
            
            // Create a work item to hide the activity indicator after a delay
            let timeoutWorkItem = DispatchWorkItem {
                CustomActivityIndicator2.shared.hide()
                vc.toastMessage("Request timed out. Please try again.")
            }
            
            // Schedule the timeout to run after 10 seconds (adjust the time as needed)
            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: timeoutWorkItem)
            
            KYCDataModel().getKYCDocumentStatus(url: url) { data, msg in
                // Cancel the timeoutWorkItem if the API responds before the timeout
                timeoutWorkItem.cancel()
                
                // Hide the activity indicator upon API completion
                CustomActivityIndicator2.shared.hide()
                
                if data.status == 1 {
                    self.kycDocDataStruct = data
                    if data.details?.allDocument?.count ?? 0 > 0 {
                        self.sataSetup()
                        vc.btnProceadPayment.setTitle("Continue", for: .normal)
                        vc.isresubmitTag = false
                    } else {
                        vc.btnProceadPayment.setTitle("Submit", for: .normal)
                        vc.isresubmitTag = true
                    }
                } else {
                    vc.toastMessage(msg ?? "")
                }
            }
        }
    }
    
    
    func sataSetup(){
        
        if self.kycDocDataStruct.documentStatus == 0{
            
            if self.isUserIndian{
                self.viewPANCad.isHidden = false
                self.stackViewPANCad.isHidden = false
                self.viewAAdharBacK.isHidden = false
                self.stackViewAAdharBacK.isHidden = false
                self.viewAAdharFrount.isHidden = false
                self.stackViewAAdharFrount.isHidden = false
            }
            else{
                self.viewAAdharBacK.isHidden = true
                self.stackViewAAdharBacK.isHidden = true
                self.viewAAdharFrount.isHidden = true
                self.stackViewAAdharFrount.isHidden = true
                self.viewPANCad.isHidden = true
                self.stackViewPANCad.isHidden = true
            }
            
            self.lblComPanCardStatus.text = "Pending"
            self.lblComPanCardStatus.backgroundColor = .lightGray
            
            self.lblDrivingLicenceStatus.text = "Pending"
            self.lblDrivingLicenceStatus.backgroundColor = .lightGray
            
            self.lblIECCardStatus.text = "Pending"
            self.lblIECCardStatus.backgroundColor = .lightGray
            
            self.lblPanCardStatus.text = "Pending"
            self.lblPanCardStatus.backgroundColor = .lightGray
            
            self.lblAdahrBackStatus.text = "Pending"
            self.lblAdahrBackStatus.backgroundColor = .lightGray
            
            self.lblAdahrFrontStatus.text = "Pending"
            self.lblAdahrFrontStatus.backgroundColor = .lightGray
            
            self.lblPassportFrontStatus.text = "Pending"
            self.lblPassportFrontStatus.backgroundColor = .lightGray
            
            self.lblPassportBackStatus.text = "Pending"
            self.lblPassportBackStatus.backgroundColor = .lightGray
            
            self.lblCompanyGSTStatus.text = "Pending"
            self.lblCompanyGSTStatus.backgroundColor = .lightGray
            
            self.lblCompanyGSTStatus.text = "Pending"
            self.lblCompanyGSTStatus.backgroundColor = .lightGray
        }
        
       
        else{
            
            if self.kycDocDataStruct.documentStatus == 2{
                self.btnSubmiited.isHidden = true
            }
            
            self.kycDocDataStruct.details?.allDocument?.enumerated().forEach { (index, value) in
                
                switch value.attachmentType {
                case "IEC Card":
                    self.viewIEC.isHidden = false
                    self.stackViewIEC.isHidden = false
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblIECCardStatus.text = "Pending"
                        self.lblIECCardStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocIEC = false
                        
                    case 1:
                        self.lblIECCardStatus.text = "Verified"
                        self.lblIECCardStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocIEC = true
                    default:
                        self.lblIECCardStatus.text = "Rejected"
                        self.lblIECCardStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocIEC = false
                    }
                    self.lblIECCardSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.IECDocID = value.attachmentID ?? 0
                    
                case "PAN Card":
                    self.viewPANCad.isHidden = false
                    self.stackViewPANCad.isHidden = false
                    
                    if self.isUserIndian{
                        self.viewPANCad.isHidden = false
                        self.stackViewPANCad.isHidden = false
                    }
                    else{
                        self.viewPANCad.isHidden = true
                        self.stackViewPANCad.isHidden = true
                    }
                    
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblPanCardStatus.text = "Pending"
                        self.lblPanCardStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocPAN = false
                    case 1:
                        self.lblPanCardStatus.text = "Verified"
                        self.lblPanCardStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocPAN = true
                    default:
                        self.lblPanCardStatus.text = "Rejected"
                        self.lblPanCardStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocPAN = false
                    }
                    self.lblPanCardSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.pANDocID = value.attachmentID ?? 0
                case "Aadhaar Card Back":
                    
                    self.stackViewAAdharBacK.isHidden = false
                    self.viewAAdharBacK.isHidden = false
                    
                    if self.isUserIndian{
                        self.viewAAdharBacK.isHidden = false
                        self.stackViewAAdharBacK.isHidden = false
                    }
                    else{
                        self.viewAAdharBacK.isHidden = true
                        self.stackViewAAdharBacK.isHidden = true
                    }
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblAdahrBackStatus.text = "Pending"
                        self.lblAdahrBackStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocAAdhaarBack = false
                    case 1:
                        self.lblAdahrBackStatus.text = "Verified"
                        self.lblAdahrBackStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocAAdhaarBack = true
                    default:
                        self.lblAdahrBackStatus.text = "Rejected"
                        self.lblAdahrBackStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocAAdhaarBack = false
                    }
                    self.lblAdahrBackSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.aadhaarBackDocID = value.attachmentID ?? 0
                case "Aadhaar Card Front":
                    self.viewAAdharFrount.isHidden = false
                    self.stackViewAAdharFrount.isHidden = false
                    if self.isUserIndian{
                        self.viewAAdharFrount.isHidden = false
                        self.stackViewAAdharFrount.isHidden = false
                    }
                    else{
                        self.viewAAdharFrount.isHidden = true
                        self.stackViewAAdharFrount.isHidden = true
                    }
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblAdahrFrontStatus.text = "Pending"
                        self.lblAdahrFrontStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocAAdhaarFront = false
                    case 1:
                        self.lblAdahrFrontStatus.text = "Verified"
                        self.lblAdahrFrontStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocAAdhaarFront = true
                    default:
                        self.lblAdahrFrontStatus.text = "Rejected"
                        self.lblAdahrFrontStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocAAdhaarFront = false
                    }
                    self.lblAdahrFrontSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.aadhaarFrontDocID = value.attachmentID ?? 0
                case "Passport Front":
                    
                    self.viewPassportPront.isHidden = false
                    self.stackViewPassportPront.isHidden = false
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblPassportFrontStatus.text = "Pending"
                        self.lblPassportFrontStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocPassportFront = false
                    case 1:
                        self.lblPassportFrontStatus.text = "Verified"
                        self.lblPassportFrontStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocPassportFront = true
                    default:
                        self.lblPassportFrontStatus.text = "Rejected"
                        self.lblPassportFrontStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocPassportFront = false
                    }
                    
                    self.lblPassportFrontSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.passportFrontDocID = value.attachmentID ?? 0
                case "Passport Back":
                    
                    self.viewPassportBack.isHidden = false
                    self.stackViewPassportBack.isHidden = false
                    
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblPassportBackStatus.text = "Pending"
                        self.lblPassportBackStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocPassportBack = false
                    case 1:
                        self.lblPassportBackStatus.text = "Verified"
                        self.lblPassportBackStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocPassportBack = true
                    default:
                        self.lblPassportBackStatus.text = "Rejected"
                        self.lblPassportBackStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocPassportBack = false
                    }
                    self.lblPassportBackSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.passportBackDocID = value.attachmentID ?? 0
                case "Company GST Certificate":
                    
                    
                    self.viewCompanyGST.isHidden = false
                    self.stackViewCompanyGST.isHidden = false
                    
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblCompanyGSTStatus.text = "Pending"
                        self.lblCompanyGSTStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocCompanyGST = false
                    case 1:
                        self.lblCompanyGSTStatus.text = "Verified"
                        self.lblCompanyGSTStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocCompanyGST = true
                    default:
                        self.lblCompanyGSTStatus.text = "Rejected"
                        self.lblCompanyGSTStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocCompanyGST = false
                    }
                    self.lblCompanyGSTSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.companyGSTDocID = value.attachmentID ?? 0

                    
                case "Driving License":
                    
                    self.viewDrivingLicence.isHidden = false
                    self.stackViewDrivingLicence.isHidden = false
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblDrivingLicenceStatus.text = "Pending"
                        self.lblDrivingLicenceStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocDrivingLicence = false
                    case 1:
                        self.lblDrivingLicenceStatus.text = "Verified"
                        self.lblDrivingLicenceStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocDrivingLicence = true
                    default:
                        self.lblDrivingLicenceStatus.text = "Rejected"
                        self.lblDrivingLicenceStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocDrivingLicence = false
                    }
                    
                    self.lblDrivingLicenceSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.DrivingLincDocID = value.attachmentID ?? 0

                    
                case "Company PAN Card":
                    
                    self.viewCompanyPAN.isHidden = false
                    self.stackViewCompanyPAN.isHidden = false
                    
                    switch value.verifiedInd {
                    case 0:
                        self.lblComPanCardStatus.text = "Pending"
                        self.lblComPanCardStatus.backgroundColor = UIColor(named: "DXE_Gray")
                        self.isDocComapnyPAN = false
                    case 1:
                        self.lblComPanCardStatus.text = "Verified"
                        self.lblComPanCardStatus.backgroundColor = UIColor(named: "green2")
                        self.isDocComapnyPAN = true
                    default:
                        self.lblComPanCardStatus.text = "Rejected"
                        self.lblComPanCardStatus.backgroundColor = UIColor(named: "red_")
                        self.isDocComapnyPAN = false
                    }
                    
                    self.lblComPanCardSubmitDate.text = extractDate(from: value.attachmentDate ?? "")
                    self.companyPANDocID = value.attachmentID ?? 0


                default:
                    print(value.attachmentType)
                }
                
            }
        }
        
        self.reloadTBLE(self.kycDocDataStruct)
        
    }
    
    func extractDate(from dateTimeString: String) -> String? {
        // Input date-time string format
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Format of your input string
        
        // Convert the string to a Date object
        if let date = inputFormatter.date(from: dateTimeString) {
            // Output date format (only date part)
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd" // Desired output format (only date)
            
            // Convert the Date object back to string (only date)
            let dateString = outputFormatter.string(from: date)
            return dateString
        }
        
        return nil // Return nil if conversion fails
    }
    
    
}


