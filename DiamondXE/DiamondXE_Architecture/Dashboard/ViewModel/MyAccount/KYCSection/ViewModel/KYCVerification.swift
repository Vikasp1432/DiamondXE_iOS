//
//  KYCVerification.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/07/24.
//

import UIKit

class KYCVerification: BaseViewController {
    
    @IBOutlet var viewData:UIView!
    
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


    override func viewDidLoad() {
        super.viewDidLoad()

        viewData.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewData.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewData.layer.shadowRadius = 2.0
        viewData.layer.shadowOpacity = 0.3
        viewData.layer.masksToBounds = false
        
        callingAPIGetKYCDocs()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActionDone(_ sender: UIButton){
        let vc = UIStoryboard.init(name: "KYCDocVerify", bundle: Bundle.main).instantiateViewController(withIdentifier: "KYCDOCResubmittedVC") as? KYCDOCResubmittedVC
        vc?.isDocGST = self.isDocGST
        vc?.isDocIEC = self.isDocIEC
        vc?.isDocAAdhaarFront = self.isDocAAdhaarFront
        vc?.isDocAAdhaarBack = self.isDocAAdhaarBack
        vc?.isDocPAN = self.isDocPAN
        vc?.isDocPassportFront = self.isDocPassportFront
        vc?.isDocPassportBack = self.isDocPassportBack
        vc?.isDocDrivingLicence = self.isDocDrivingLicence
        vc?.isDocComapnyPAN = self.isDocComapnyPAN
        vc?.isDocCompanyGST = self.isDocGST
        
        vc?.companyGSTDocID = self.companyGSTDocID 
        vc?.companyPANDocID = self.companyPANDocID
        vc?.IECDocID = self.IECDocID
        vc?.aadhaarFrontDocID = self.aadhaarFrontDocID
        vc?.aadhaarBackDocID = self.aadhaarBackDocID
        vc?.pANDocID = self.pANDocID
        vc?.passportFrontDocID = self.passportFrontDocID
        vc?.passportBackDocID = self.passportBackDocID
        vc?.DrivingLincDocID = self.DrivingLincDocID
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func callingAPIGetKYCDocs(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
       
        _ = getSessionUniqID()
        let url =  APIs().get_KYCDoc_API
       
      
        KYCDataModel().getKYCDocumentStatus(url: url, completion: { data, msg in
            if data.status == 1{
                self.kycDocDataStruct = data
                self.sataSetup()
            }
            else{
                self.toastMessage(msg ?? "")
            }
            CustomActivityIndicator2.shared.hide()

        })
    }
    
    
    func sataSetup(){
        
        if self.kycDocDataStruct.documentStatus == 0{
            self.btnSubmiited.isHidden = false
            
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
        }else{
            self.btnSubmiited.isHidden = true
            self.kycDocDataStruct.details?.allDocument?.enumerated().forEach { (index, value) in
                switch value.attachmentType {
                case "IEC Card":
                    switch value.verifiedInd {
                    case 0:
                        self.lblIECCardStatus.text = "Pending"
                        self.lblIECCardStatus.backgroundColor = .lightGray
                        self.isDocIEC = false
                        
                    case 1:
                        self.lblIECCardStatus.text = "Verified"
                        self.lblIECCardStatus.backgroundColor = .systemGreen
                        self.isDocIEC = true
                    default:
                        self.lblIECCardStatus.text = "Rejected"
                        self.lblIECCardStatus.backgroundColor = .systemRed
                        self.isDocIEC = false
                    }
                    self.lblIECCardSubmitDate.text = value.attachmentDate
                    self.IECDocID = value.attachmentID ?? 0
                    
                case "PAN Card":
                    switch value.verifiedInd {
                    case 0:
                        self.lblPanCardStatus.text = "Pending"
                        self.lblPanCardStatus.backgroundColor = .lightGray
                        self.isDocPAN = false
                    case 1:
                        self.lblPanCardStatus.text = "Verified"
                        self.lblPanCardStatus.backgroundColor = .systemGreen
                        self.isDocPAN = true
                    default:
                        self.lblPanCardStatus.text = "Rejected"
                        self.lblPanCardStatus.backgroundColor = .systemRed
                        self.isDocPAN = false
                    }
                    self.lblPanCardSubmitDate.text = value.attachmentDate
                    self.pANDocID = value.attachmentID ?? 0
                case "Aadhaar Card Back":
                    switch value.verifiedInd {
                    case 0:
                        self.lblAdahrBackStatus.text = "Pending"
                        self.lblAdahrBackStatus.backgroundColor = .lightGray
                        self.isDocAAdhaarBack = false
                    case 1:
                        self.lblAdahrBackStatus.text = "Verified"
                        self.lblAdahrBackStatus.backgroundColor = .systemGreen
                        self.isDocAAdhaarBack = true
                    default:
                        self.lblAdahrBackStatus.text = "Rejected"
                        self.lblAdahrBackStatus.backgroundColor = .systemRed
                        self.isDocAAdhaarBack = false
                    }
                    self.lblAdahrBackSubmitDate.text = value.attachmentDate
                    self.aadhaarBackDocID = value.attachmentID ?? 0
                case "Aadhaar Card Front":
                    switch value.verifiedInd {
                    case 0:
                        self.lblAdahrFrontStatus.text = "Pending"
                        self.lblAdahrFrontStatus.backgroundColor = .lightGray
                        self.isDocAAdhaarFront = false
                    case 1:
                        self.lblAdahrFrontStatus.text = "Verified"
                        self.lblAdahrFrontStatus.backgroundColor = .systemGreen
                        self.isDocAAdhaarFront = true
                    default:
                        self.lblAdahrFrontStatus.text = "Rejected"
                        self.lblAdahrFrontStatus.backgroundColor = .systemRed
                        self.isDocAAdhaarFront = false
                    }
                    self.lblAdahrFrontSubmitDate.text = value.attachmentDate
                    self.aadhaarFrontDocID = value.attachmentID ?? 0
                case "Passport Front":
                    switch value.verifiedInd {
                    case 0:
                        self.lblPassportFrontStatus.text = "Pending"
                        self.lblPassportFrontStatus.backgroundColor = .lightGray
                        self.isDocPassportFront = false
                    case 1:
                        self.lblPassportFrontStatus.text = "Verified"
                        self.lblPassportFrontStatus.backgroundColor = .systemGreen
                        self.isDocPassportFront = true
                    default:
                        self.lblPassportFrontStatus.text = "Rejected"
                        self.lblPassportFrontStatus.backgroundColor = .systemRed
                        self.isDocPassportFront = false
                    }
                    
                    self.lblPassportFrontSubmitDate.text = value.attachmentDate
                    self.passportFrontDocID = value.attachmentID ?? 0
                case "Passport Back":
                    switch value.verifiedInd {
                    case 0:
                        self.lblPassportBackStatus.text = "Pending"
                        self.lblPassportBackStatus.backgroundColor = .lightGray
                        self.isDocPassportBack = false
                    case 1:
                        self.lblPassportBackStatus.text = "Verified"
                        self.lblPassportBackStatus.backgroundColor = .systemGreen
                        self.isDocPassportBack = true
                    default:
                        self.lblPassportBackStatus.text = "Rejected"
                        self.lblPassportBackStatus.backgroundColor = .systemRed
                        self.isDocPassportBack = false
                    }
                    self.lblPassportBackSubmitDate.text = value.attachmentDate
                    self.passportBackDocID = value.attachmentID ?? 0
                case "Company GST Certificate":
                    switch value.verifiedInd {
                    case 0:
                        self.lblCompanyGSTStatus.text = "Pending"
                        self.lblCompanyGSTStatus.backgroundColor = .lightGray
                        self.isDocCompanyGST = false
                    case 1:
                        self.lblCompanyGSTStatus.text = "Verified"
                        self.lblCompanyGSTStatus.backgroundColor = .systemGreen
                        self.isDocCompanyGST = true
                    default:
                        self.lblCompanyGSTStatus.text = "Rejected"
                        self.lblCompanyGSTStatus.backgroundColor = .systemRed
                        self.isDocCompanyGST = false
                    }
                    self.lblCompanyGSTSubmitDate.text = value.attachmentDate
                    self.companyGSTDocID = value.attachmentID ?? 0

                    
                case "Driving License":
                    switch value.verifiedInd {
                    case 0:
                        self.lblDrivingLicenceStatus.text = "Pending"
                        self.lblDrivingLicenceStatus.backgroundColor = .lightGray
                        self.isDocDrivingLicence = false
                    case 1:
                        self.lblDrivingLicenceStatus.text = "Verified"
                        self.lblDrivingLicenceStatus.backgroundColor = .systemGreen
                        self.isDocDrivingLicence = true
                    default:
                        self.lblDrivingLicenceStatus.text = "Rejected"
                        self.lblDrivingLicenceStatus.backgroundColor = .systemRed
                        self.isDocDrivingLicence = false
                    }
                    
                    self.lblDrivingLicenceSubmitDate.text = value.attachmentDate
                    self.DrivingLincDocID = value.attachmentID ?? 0

                    
                case "Company PAN Card":
                    switch value.verifiedInd {
                    case 0:
                        self.lblComPanCardStatus.text = "Pending"
                        self.lblComPanCardStatus.backgroundColor = .lightGray
                        self.isDocComapnyPAN = false
                    case 1:
                        self.lblComPanCardStatus.text = "Verified"
                        self.lblComPanCardStatus.backgroundColor = .systemGreen
                        self.isDocComapnyPAN = true
                    default:
                        self.lblComPanCardStatus.text = "Rejected"
                        self.lblComPanCardStatus.backgroundColor = .systemRed
                        self.isDocComapnyPAN = false
                    }
                    
                    self.lblComPanCardSubmitDate.text = value.attachmentDate
                    self.companyPANDocID = value.attachmentID ?? 0


                default:
                    print(value.attachmentType)
                }
                
            }
        }
        
    }


}
