//
//  TableViewCellManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 09/05/24.
//

import Foundation
import UIKit

class TableViewCellManager : SignupVC {
   static var shareInstence = TableViewCellManager()
    
    func kycCellVerification(cell:Dealer_KYCCell){
        cell.buttonPressedVerify = { tag in
            if tag == 0 {
                let aadharNo = cell.getAdharnum()
                self.view.endEditing(true)
                var param :[String:Any] = [:]
                param = ["documentType":"aadhaarNo", "aadhaarNo":aadharNo]
                CustomActivityIndicator.shared.show(in: self.view)
                // APIs().document_verification_API
                SignupDataModel().verifyDoc(url: "https://admin.diamondxe.com/app/v1/validate-document", requestParam: param, completion: { result , msg in
                    
                    if result.status == 1{
                        self.dealerDataStruct.aadhaarNo = aadharNo
                        cell.btnverifyGST.isHidden = true
                        cell.btnverifiedAdhar.isHidden = false
                        self.isAdharVerify = true
                    }
                    else{
                        self.isAdharVerify = false
                        cell.txtAdhar.showError(message: "Aadhar number verify requried")
                    }
                    
                    self.toastMessage(result.msg ?? "")
                    CustomActivityIndicator.shared.hide()
                })
                
            }
            else{
                let panNo = cell.getPANnum()
                self.view.endEditing(true)
                var param :[String:Any] = [:]
                param = ["documentType":"PANNo", "PANNo":panNo]
                CustomActivityIndicator.shared.show(in: self.view)
                // APIs().document_verification_API
                SignupDataModel().verifyDoc(url: "https://admin.diamondxe.com/app/v1/validate-document", requestParam: param, completion: { result , msg in
                    
                    if result.status == 1{
                        self.dealerDataStruct.panNo = panNo
                        cell.btnverifyPAN.isHidden = true
                        cell.btnverifiedPAN.isHidden = false
                        self.isPanVerify = true
                    }
                    else{
                        self.isPanVerify = false
                        cell.txtPAN.showError(message: "PAN number verify requried")
                    }
                    
                    self.toastMessage(result.msg ?? "")
                    CustomActivityIndicator.shared.hide()
                })
                
            }
        }
    }
}
