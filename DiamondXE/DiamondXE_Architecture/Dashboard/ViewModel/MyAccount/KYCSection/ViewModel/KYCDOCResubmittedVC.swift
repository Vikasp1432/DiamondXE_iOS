//
//  KYCDOCResubmittedVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 30/07/24.
//

import UIKit
import DTTextField

class KYCDOCResubmittedVC: BaseViewController {
    
    @IBOutlet var viewGSTBG : UIView!
    @IBOutlet var viewComPANBG : UIView!
    @IBOutlet var viewIECBG : UIView!
    @IBOutlet var viewAadharBG : UIView!
    @IBOutlet var viewPANBG : UIView!
    @IBOutlet var viewPassportBG : UIView!
    @IBOutlet var viewDrivingLicenceBG : UIView!
    
    @IBOutlet var dataView : UIView!
    
    @IBOutlet var txtGSTNum:DTTextField!
    @IBOutlet var txtIECNum:DTTextField!
    @IBOutlet var txtAadharNum:DTTextField!
    @IBOutlet var txPANNum:DTTextField!
    @IBOutlet var txPassportNum:DTTextField!
    @IBOutlet var txtDateOFBirth:DTTextField!
    @IBOutlet var txtDrivingLicenceNum:DTTextField!
    
    @IBOutlet var txtComPAN:DTTextField!
    
    @IBOutlet var txtTitle:UILabel!
    
    @IBOutlet var btnVerifyGST:UIButton!
    @IBOutlet var btnGSTVerified:UIButton!
    @IBOutlet var btnGSTDoc:UIButton!
    @IBOutlet var btnGSTDocSelected:UIButton!
    @IBOutlet var btnComPAN:UIButton!
    @IBOutlet var btnComPANVerified:UIButton!
    @IBOutlet var btnIECDoc:UIButton!
    @IBOutlet var btnIECDocVerified:UIButton!
    @IBOutlet var btnIECDocSelected:UIButton!
    @IBOutlet var btnComPANDOC:UIButton!
    @IBOutlet var btnComPANDOCSelected:UIButton!
    
    @IBOutlet var btnVerifyDrivingLicn:UIButton!
    @IBOutlet var btnVerifyDrivingLicnVerified:UIButton!
    @IBOutlet var btnDrivingLicnDoc:UIButton!
    @IBOutlet var btnDrivingLicnDocSelected:UIButton!
    
    @IBOutlet var btnVerifyPAN:UIButton!
    @IBOutlet var btnVerifyPANVerified:UIButton!
    @IBOutlet var btnPANDoc:UIButton!
    @IBOutlet var btnPANDocSelected:UIButton!
    
    @IBOutlet var btnVerifyAadhar:UIButton!
    @IBOutlet var btnVerifyAadharVerified:UIButton!
    @IBOutlet var btnAadharDocFront:UIButton!
    @IBOutlet var btnAadharDocFrontSelected:UIButton!
    @IBOutlet var btnAadharDocBack:UIButton!
    @IBOutlet var btnAadharDocBackSelected:UIButton!
    
    @IBOutlet var btnVerifyPassport:UIButton!
    @IBOutlet var btnPassportVerified:UIButton!
    @IBOutlet var btnPassportDocFront:UIButton!
    @IBOutlet var btnPassportDocFrontSelected:UIButton!
    @IBOutlet var btnPassportDocBack:UIButton!
    @IBOutlet var btnPassportDocBackSelected:UIButton!
    
    @IBOutlet var btnSubmit:UIButton!
   
    
    var docGST = String()
    var docIEC = String()
    var docAAdhaarFront = String()
    var docAAdhaarBack = String()
    var docPAN = String()
    var docPassportFront = String()
    var docPassportBack = String()
    var docDrivingLicence = String()
    var docComPAN = String()
    
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
    
    
    var isAdharVerify = false
    var isPanVerify = false
    var isGSTVerify = false
    var isPassportVerify = false
    var isDrivingLincVerify = false
    var isBasicInfoEmailVerified = false
    var isCompanyDetailsEmailVerified = false
    var isCompanyDetailsPANVerified = false
    var isCompanyDetailsGSTVerified = false
    
    var companyGSTDocID = Int()
    var companyPANDocID = Int()
    var IECDocID = Int()
    var aadhaarFrontDocID = Int()
    var aadhaarBackDocID = Int()
    var pANDocID = Int()
    var passportFrontDocID = Int()
    var passportBackDocID = Int()
    var DrivingLincDocID = Int()
    
    var dateString = String()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataView.layer.shadowColor = UIColor.shadowViewclr.cgColor
        dataView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        dataView.layer.shadowRadius = 2.0
        dataView.layer.shadowOpacity = 0.3
        dataView.layer.masksToBounds = false

         txtGSTNum.delegate = self
         txtIECNum.delegate = self
         txtAadharNum.delegate = self
         txPANNum.delegate = self
         txPassportNum.delegate = self
         txtDateOFBirth.delegate = self
         txtDrivingLicenceNum.delegate = self
        
        //
        self.btnGSTDoc.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnVerifyGST.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnComPANDOC.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnComPAN.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnIECDoc.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        self.btnAadharDocBack.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnAadharDocFront.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnVerifyAadhar.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnPANDoc.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnVerifyPAN.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        self.btnVerifyPassport.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnPassportDocBack.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnPassportDocFront.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnDrivingLicnDoc.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        self.btnVerifyDrivingLicn.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        self.btnSubmit.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        
        txtDateOFBirth.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        
        
        setupViews()
        
    }
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.txtDateOFBirth.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.txtDateOFBirth.text = dateFormatter.string(from: datePicker.date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.dateString = dateFormatter.string(from: datePicker.date)
        }
        self.txtDateOFBirth.resignFirstResponder()
     
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
    
    
    func setupViews(){
        
     
        let loginData = UserDefaultManager().retrieveLoginData()
        if let userRole = loginData?.details?.userRole{
            if  userRole == "BUYER"{
                self.txtTitle.text = "Buyer KYC Verification"
                
                
                //            if let range = loginData?.details?.mobileNo?.range(of: "+91") {
                if isDocAAdhaarFront && isDocAAdhaarBack{
                    viewAadharBG.isHidden = true
                }
                else{
                    viewAadharBG.isHidden = false
                }
                
                if isDocPAN{
                    viewPANBG.isHidden = true
                }
                else{
                    viewPANBG.isHidden = false
                }
                
                if isDocPassportFront && isDocPassportBack{
                    viewPassportBG.isHidden = true
                }
                else{
                    viewPassportBG.isHidden = false
                }
                
                if isDocDrivingLicence{
                    viewDrivingLicenceBG.isHidden = true
                }
                else{
                    viewDrivingLicenceBG.isHidden = false
                }
                
                //            }
                //            else{
                //                viewGSTBG.isHidden = true
                //                viewIECBG.isHidden = true
                //                viewComPANBG.isHidden = true
                //                viewAadharBG.isHidden = true
                //                viewPANBG.isHidden = true
                //                if isDocPassportFront && isDocPassportBack{
                //                    viewPassportBG.isHidden = true
                //                }
                //                else{
                //                    viewPassportBG.isHidden = false
                //                }
                //
                //                if isDocDrivingLicence{
                //                    viewDrivingLicenceBG.isHidden = true
                //                }
                //                else{
                //                    viewDrivingLicenceBG.isHidden = false
                //                }
                //            }
                
                
                
            }
            else{
                self.txtTitle.text = "Dealer KYC Verification"
                
                //            if let range = loginData?.details?.mobileNo?.range(of: "+91") {
                
                if isDocGST{
                    viewGSTBG.isHidden = true
                }
                else{
                    viewGSTBG.isHidden = false
                }
                
                if isDocIEC{
                    viewIECBG.isHidden = true
                }
                else{
                    viewIECBG.isHidden = false
                }
                
                if isDocAAdhaarFront && isDocAAdhaarBack{
                    viewAadharBG.isHidden = true
                }
                else{
                    viewAadharBG.isHidden = false
                }
                
                if isDocPAN{
                    viewPANBG.isHidden = true
                }
                else{
                    viewPANBG.isHidden = false
                }
                
                if isDocPassportFront && isDocPassportBack{
                    viewPassportBG.isHidden = true
                }
                else{
                    viewPassportBG.isHidden = false
                }
                
                if isDocDrivingLicence{
                    viewDrivingLicenceBG.isHidden = true
                }
                else{
                    viewDrivingLicenceBG.isHidden = false
                }
                
                if isDocComapnyPAN{
                    viewComPANBG.isHidden = true
                }
                else{
                    viewComPANBG.isHidden = false
                }
                //            }
                //            else{
                //                viewGSTBG.isHidden = true
                //                viewIECBG.isHidden = true
                //                viewComPANBG.isHidden = true
                //                viewAadharBG.isHidden = true
                //                viewPANBG.isHidden = true
                //                if isDocPassportFront && isDocPassportBack{
                //                    viewPassportBG.isHidden = true
                //                }
                //                else{
                //                    viewPassportBG.isHidden = false
                //                }
                //
                //                if isDocDrivingLicence{
                //                    viewDrivingLicenceBG.isHidden = true
                //                }
                //                else{
                //                    viewDrivingLicenceBG.isHidden = false
                //                }
                //            }
            }
        }
        
       
        
        
        
    }
    
    
    
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActionDone(_ sender: UIButton){
        csubmittedAllDocAPICall()
    }
    
    func csubmittedAllDocAPICall(){
        var param : [String:Any] = [:]

        if isGSTVerify{
            param = ["companyGSTNo" : self.txtGSTNum.text ?? "","companyGSTNoDoc": "\(self.docGST)" ,"companyGSTNoId": "\(companyGSTDocID)" ]
        }
      
        if isCompanyDetailsPANVerified{
            param = ["companyPANNo" : self.txtComPAN.text ?? "","companyPANNoDoc": "\(self.docComPAN)" ,"companyPANNoId": "\(companyPANDocID)" ]
        }
        
        if !txtIECNum.text!.isEmptyStr {
            param = ["IEC" : self.txtIECNum.text ?? "","IECDoc": "\(self.docIEC)" ,"IECId": "\(IECDocID)" ]
        }
        
        
        if isAdharVerify{
            param = ["aadhaarNo" : self.txtAadharNum.text ?? "","aadhaarNoFrontDoc": "\(self.docAAdhaarFront)" ,"aadhaarFrontId": "\(aadhaarFrontDocID)", "aadhaarBackId": "\(aadhaarBackDocID)" , "aadhaarNoBackDoc": "\(self.docAAdhaarBack)"]
        }
       
        
        if isPanVerify{
 
            param = ["PANNo" : self.txPANNum.text ?? "","PANNoDoc": "\(self.docPAN)" ,"PANNoId": "\(pANDocID)" ]
        }
       
        if isPassportVerify{
            param = ["passportNo" : self.txPassportNum.text ?? "","passportFrontDoc": "\(self.docPassportFront)" ,"passportFrontDocId": "\(passportFrontDocID)", "passportBackDocId": "\(passportBackDocID)" , "passportBackDoc": "\(self.docPassportBack)"]
        }
       
        if isDrivingLincVerify{
            
            param = ["dob" :self.txtDateOFBirth.text ?? "","drivingLicenseNo" : self.txtDrivingLicenceNum.text ?? "","drivingLicenseDoc": "\(self.docDrivingLicence)" ,"drivingLicenseDocId": "\(DrivingLincDocID)" ]
        }
        print(param)
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        SignupDataModel().verifyDoc(url: APIs().upload_KYCDoc_API, requestParam: param, completion: { result , msg in
            
            if result.status == 1{
                self.navigationController?.popViewController(animated: true)
                self.toastMessage(msg ?? "")
            }
            else{
                self.toastMessage(msg ?? "")
            }
            
            //self.toastMessage(result.msg ?? "")
            CustomActivityIndicator2.shared.hide()
        })
                     
    }
    
    
    
    
    @IBAction func btnActionVerify(_ sender: UIButton){
        switch sender.tag {
        case 11:
            txtDateOFBirth.becomeFirstResponder()
        case 0:
            self.view.endEditing(true)
            var param :[String:Any] = ["documentType":"GSTNo", "GSTNo":self.txtGSTNum.text ?? ""]
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                
                if result.status == 1{
                    self.btnVerifyGST.isHidden = true
                    self.btnGSTVerified.isHidden = false
                    self.isGSTVerify = true
                }
                else{
                    self.isGSTVerify = false
                    self.txtGSTNum.showError(message: "GST number not verify")
                }
                
                //self.toastMessage(result.msg ?? "")
                CustomActivityIndicator2.shared.hide()
            })
            
        
        case 1:
            self.view.endEditing(true)
            var param :[String:Any] = ["documentType":"companyPANNo", "companyPANNo":self.txtComPAN.text ?? ""]
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                
                if result.status == 1{
                    self.btnComPAN.isHidden = true
                    self.btnComPANVerified.isHidden = false
                    self.isCompanyDetailsPANVerified = true
                }
                else{
                    self.isCompanyDetailsPANVerified = false
                    self.txtComPAN.showError(message: "Co. PAN number not verify")
                }
                
                //self.toastMessage(result.msg ?? "")
                CustomActivityIndicator2.shared.hide()
            })
        case 2:
            self.view.endEditing(true)
            var param :[String:Any] = ["documentType":"aadhaarNo", "aadhaarNo":self.txtAadharNum.text ?? ""]
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                
                if result.status == 1{
                    self.btnVerifyAadhar.isHidden = true
                    self.btnVerifyAadharVerified.isHidden = false
                    self.isAdharVerify = true
                }
                else{
                    self.isAdharVerify = false
                    self.txtAadharNum.showError(message: "Aadhaar number not verify")
                }
                
                //self.toastMessage(result.msg ?? "")
                CustomActivityIndicator2.shared.hide()
            })
        case 3:
            self.view.endEditing(true)
            var param :[String:Any] = ["documentType":"PANNo", "PANNo":self.txPANNum.text ?? ""]
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                
                if result.status == 1{
                    self.btnVerifyPAN.isHidden = true
                    self.btnVerifyPANVerified.isHidden = false
                    self.isPanVerify = true
                }
                else{
                    self.isPanVerify = false
                    self.txPANNum.showError(message: "PAN number not verify")
                }
                
                //self.toastMessage(result.msg ?? "")
                CustomActivityIndicator2.shared.hide()
            })
        case 4:
            self.view.endEditing(true)
            var param :[String:Any] = ["documentType":"passportNo", "passportNo":self.txPassportNum.text ?? ""]
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                
                if result.status == 1{
                    self.btnVerifyPassport.isHidden = true
                    self.btnPassportVerified.isHidden = false
                    self.isPassportVerify = true
                }
                else{
                    self.isPassportVerify = false
                    self.txPANNum.showError(message: "Passport number not verify")
                }
                
                //self.toastMessage(result.msg ?? "")
                CustomActivityIndicator2.shared.hide()
            })
        case 5:
            self.view.endEditing(true)
            var param :[String:Any] = ["documentType":"drivingLicenseNo", "drivingLicenseNo":self.txtDrivingLicenceNum.text ?? ""]
            CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            SignupDataModel().verifyDoc(url: APIs().document_verification_API, requestParam: param, completion: { result , msg in
                
                if result.status == 1{
                    self.btnVerifyDrivingLicn.isHidden = true
                    self.btnVerifyDrivingLicnVerified.isHidden = false
                    self.isDrivingLincVerify = true
                }
                else{
                    self.isDrivingLincVerify = false
                    self.txPANNum.showError(message: "Driving Licence not verify")
                }
                
                //self.toastMessage(result.msg ?? "")
                CustomActivityIndicator2.shared.hide()
            })
        default:
            print(sender.tag)
        }
    }
    
    
    

    @IBAction func btnActionBrows(_ sender: UIButton){
        switch sender.tag {
        case 0:
            ImagePickerManager().pickImage(self){ image in
                self.docGST = image
                self.btnGSTDoc.isHidden = true
                self.btnGSTDocSelected.isHidden = false
            }
        case 1:
            ImagePickerManager().pickImage(self){ image in
                self.docComPAN = image
                self.btnComPANDOC.isHidden = true
                self.btnComPANDOCSelected.isHidden = false
            }
        case 2:
            ImagePickerManager().pickImage(self){ image in
                self.docIEC = image
                self.btnIECDoc.isHidden = true
                self.btnIECDocSelected.isHidden = false
            }
       
        case 3:
            ImagePickerManager().pickImage(self){ image in
                self.docAAdhaarFront = image
                self.btnAadharDocFront.isHidden = true
                self.btnAadharDocFrontSelected.isHidden = false
            }
        case 4:
            ImagePickerManager().pickImage(self){ image in
                self.docAAdhaarBack = image
                self.btnAadharDocBack.isHidden = true
                self.btnAadharDocBackSelected.isHidden = false
            }
        case 5:
            ImagePickerManager().pickImage(self){ image in
                self.docPAN = image
                self.btnPANDoc.isHidden = true
                self.btnPANDocSelected.isHidden = false
            }
        case 6:
            ImagePickerManager().pickImage(self){ image in
                self.docPassportFront = image
                self.btnPassportDocFront.isHidden = true
                self.btnPassportDocFrontSelected.isHidden = false
            }
        case 7:
            ImagePickerManager().pickImage(self){ image in
                self.docPassportBack = image
                self.btnPassportDocBack.isHidden = true
                self.btnPassportDocBackSelected.isHidden = false
            }
        case 8:
            ImagePickerManager().pickImage(self){ image in
                self.docDrivingLicence = image
                self.btnDrivingLicnDoc.isHidden = true
                self.btnDrivingLicnDocSelected.isHidden = false
            }
        default:
            print(sender.tag)
        }
       
    }
   

}
