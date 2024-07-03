//
//  DiamondDetailsModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/06/24.
//

import Foundation

class DiamondDetailsModel {
    
    func getDiamondsDetails(url : String, requestParam: [String:Any], completion: @escaping (DiamondDetailsStruct, String?) -> Void) {
        var diamondDetailsResult = DiamondDetailsStruct()
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    diamondDetailsResult = try JsonParsingManagar.parse(jsonData: data!, type: DiamondDetailsStruct.self)
                    completion(diamondDetailsResult, diamondDetailsResult.msg)
                } catch {
                    completion(diamondDetailsResult, diamondDetailsResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(diamondDetailsResult, error.localizedDescription)
            }
        })
    }
    
    func getRecommendentDiamond(url : String, requestParam: [String:Any], completion: @escaping (RecommendentDiamondStruct, String?) -> Void) {
        var diamondDetailsResult = RecommendentDiamondStruct()
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    diamondDetailsResult = try JsonParsingManagar.parse(jsonData: data!, type: RecommendentDiamondStruct.self)
                    completion(diamondDetailsResult, diamondDetailsResult.msg)
                } catch {
                    completion(diamondDetailsResult, diamondDetailsResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(diamondDetailsResult, error.localizedDescription)
            }
        })
    }
}
