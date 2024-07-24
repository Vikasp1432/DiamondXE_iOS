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
    
    
    func logoutUser(completion: @escaping (LogoutDataStruct, String?) -> Void) {
        var logoutResult = LogoutDataStruct()
        let deviceID = BaseViewController().getSessionUniqID()
        let requestParam = ["deviceId" : deviceID]
        let url = APIs().get_Logout_API
        
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    logoutResult = try JsonParsingManagar.parse(jsonData: data!, type: LogoutDataStruct.self)
                    completion(logoutResult, logoutResult.msg)
                } catch {
                    completion(logoutResult, logoutResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(logoutResult, error.localizedDescription)
            }
        })
    }
    
    
    func refreshToken(completion: @escaping (RefreshBearerToken, String?) -> Void) {
        var refreshResult = RefreshBearerToken()
       
        let url = APIs().get_RefreshToken_API
        
        AlamofireManager().makeGETAPIRequest(url: url, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    refreshResult = try JsonParsingManagar.parse(jsonData: data!, type: RefreshBearerToken.self)
                    completion(refreshResult, refreshResult.msg)
                } catch {
                    completion(refreshResult, refreshResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(refreshResult, error.localizedDescription)
            }
        })
    }
}
    
