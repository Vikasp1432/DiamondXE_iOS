//
//  ModelGetDiamond.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/06/24.
//

import Foundation

class ModelGetDiamond {
    
    func getDiamondsList(url : String, requestParam: [String:Any], completion: @escaping (DiamondSearchDataStructB2B, String?) -> Void) {
        var diamondListResult = DiamondSearchDataStructB2B()
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    diamondListResult = try JsonParsingManagar.parse(jsonData: data!, type: DiamondSearchDataStructB2B.self)
                    completion(diamondListResult, diamondListResult.msg)
                } catch {
                    completion(diamondListResult, diamondListResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(diamondListResult, error.localizedDescription)
            }
        })
    }
    
    func addToWishCart(url : String, requestParam: [String:Any], completion: @escaping (ResultStruct, String?) -> Void) {
        var resultStruct = ResultStruct()
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: ResultStruct.self)
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
