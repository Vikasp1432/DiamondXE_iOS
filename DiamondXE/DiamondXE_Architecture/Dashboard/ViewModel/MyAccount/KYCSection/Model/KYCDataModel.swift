//
//  KYCDataModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 30/07/24.
//

import Foundation

class KYCDataModel {
    func getKYCDocumentStatus(url : String, completion: @escaping (KYCDataStruct, String?) -> Void) {
        var kycDataResponce = KYCDataStruct()
        
        AlamofireManager().makeGETAPIRequest(url: url,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    kycDataResponce = try JsonParsingManagar.parse(jsonData: data!, type: KYCDataStruct.self)
                    completion(kycDataResponce, kycDataResponce.msg)
                } catch {
                    completion(kycDataResponce, kycDataResponce.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(kycDataResponce, error.localizedDescription)
            }
        })
    }
}
