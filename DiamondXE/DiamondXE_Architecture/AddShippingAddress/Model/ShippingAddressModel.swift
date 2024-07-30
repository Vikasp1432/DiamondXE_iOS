//
//  ShippingAddressModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/07/24.
//

import Foundation

class ShippingAddressModel {
    
    func addShippingAddress(url : String, requestParam: [String:Any], completion: @escaping (APIRespoceStruct, String?) -> Void) {
        var respoce = APIRespoceStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    respoce = try JsonParsingManagar.parse(jsonData: data!, type: APIRespoceStruct.self)
                    completion(respoce, respoce.msg)
                } catch {
                    completion(respoce, respoce.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(respoce, error.localizedDescription)
            }
        })
    }
}
