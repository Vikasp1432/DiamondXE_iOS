//
//  ModelHomeVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 27/05/24.
//

import Foundation

class HomeDataModel {
    
    func getHomeData(url : String, completion: @escaping (HomeDataStruct, String?) -> Void) {
        var homeDataResult = HomeDataStruct()
        
        AlamofireManager().makeGETAPIRequest(url: url,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    homeDataResult = try JsonParsingManagar.parse(jsonData: data!, type: HomeDataStruct.self)
                    completion(homeDataResult, homeDataResult.msg)
                } catch {
                    completion(homeDataResult, homeDataResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(homeDataResult, error.localizedDescription)
            }
        })
    }
    
    func getTopDealsData(url : String, completion: @escaping (TopDealsDataStruct, String?) -> Void) {
        var topDealsResult = TopDealsDataStruct()
        
        AlamofireManager().makeGETAPIRequest(url: url,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    topDealsResult = try JsonParsingManagar.parse(jsonData: data!, type: TopDealsDataStruct.self)
                    completion(topDealsResult, topDealsResult.msg)
                } catch {
                    completion(topDealsResult, topDealsResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(topDealsResult, error.localizedDescription)
            }
        })
    }
}
    
