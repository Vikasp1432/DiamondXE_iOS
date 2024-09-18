//
//  ShippingModuleModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 06/09/24.
//

import Foundation

class ShippingModuleModel{
    static var shareInstence = ShippingModuleModel()
    
    func getCheckOutDetailsAPI(url : String, requestParam: [String:Any], completion: @escaping (CheckOutDataStruct, String?) -> Void) {
        var resultStruct = CheckOutDataStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: CheckOutDataStruct.self)
                    completion(resultStruct, resultStruct.msg)
                } catch {
                    completion(resultStruct, resultStruct.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(resultStruct, error.localizedDescription)
            }
        })
    }
    
    
    func createOrderAPI(url : String, requestParam: [String:Any], completion: @escaping (CreateOrderStruct, String?) -> Void) {
        var resultStruct = CreateOrderStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: CreateOrderStruct.self)
                    completion(resultStruct, resultStruct.msg)
                } catch {
                    completion(resultStruct, resultStruct.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(resultStruct, error.localizedDescription)
            }
        })
    }
}
