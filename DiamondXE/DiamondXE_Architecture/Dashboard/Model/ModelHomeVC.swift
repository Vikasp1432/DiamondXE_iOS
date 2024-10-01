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
    
    
    func getAddresses(url : String, completion: @escaping (GetAddressStruct, String?) -> Void) {
        var addressResponce = GetAddressStruct()
        
        AlamofireManager().makeGETAPIRequest(url: url,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    addressResponce = try JsonParsingManagar.parse(jsonData: data!, type: GetAddressStruct.self)
                    completion(addressResponce, addressResponce.msg)
                } catch {
                    completion(addressResponce, addressResponce.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(addressResponce, error.localizedDescription)
            }
        })
    }
    
    func deleteAddress(url : String, requestParam: [String:Any],completion: @escaping (LogoutDataStruct, String?) -> Void) {
        var deleteAddResult = LogoutDataStruct()
        let deviceID = BaseViewController().getSessionUniqID()
       // let requestParam = ["addressId" : deviceID]
        //let url = APIs().get_Logout_API
        
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    deleteAddResult = try JsonParsingManagar.parse(jsonData: data!, type: LogoutDataStruct.self)
                    completion(deleteAddResult, deleteAddResult.msg)
                } catch {
                    completion(deleteAddResult, deleteAddResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(deleteAddResult, error.localizedDescription)
            }
        })
    }
    
    
    func changePasswordAPI(url : String, requestParam: [String:Any], completion: @escaping (LogoutDataStruct, String?) -> Void) {
        var respoce = LogoutDataStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    respoce = try JsonParsingManagar.parse(jsonData: data!, type: LogoutDataStruct.self)
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
    
    
    func getProfileInfo(url : String, completion: @escaping (ProfileInfoStruct, String?) -> Void) {
        var profileInfo = ProfileInfoStruct()
        
        AlamofireManager().makeGETAPIRequest(url: url,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    profileInfo = try JsonParsingManagar.parse(jsonData: data!, type: ProfileInfoStruct.self)
                    completion(profileInfo, profileInfo.msg)
                } catch {
                    completion(profileInfo, profileInfo.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(profileInfo, error.localizedDescription)
            }
        })
    }
    
    func updateProfileInfo(param:[String:Any],url : String, completion: @escaping (LogoutDataStruct, String?) -> Void) {
        var profileInfo = LogoutDataStruct()
        
        AlamofireManager().makePostAPIRequest(url: url, param: param,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    profileInfo = try JsonParsingManagar.parse(jsonData: data!, type: LogoutDataStruct.self)
                    completion(profileInfo, profileInfo.msg)
                } catch {
                    completion(profileInfo, profileInfo.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(profileInfo, error.localizedDescription)
            }
        })
    }
    
    func deleteUserAccount(param:[String:Any],url : String, completion: @escaping (LogoutDataStruct, String?) -> Void) {
        var deleteProfile = LogoutDataStruct()
        
        AlamofireManager().makePostAPIRequest(url: url, param: param,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    deleteProfile = try JsonParsingManagar.parse(jsonData: data!, type: LogoutDataStruct.self)
                    completion(deleteProfile, deleteProfile.msg)
                } catch {
                    completion(deleteProfile, deleteProfile.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(deleteProfile, error.localizedDescription)
            }
        })
    }
    
    
    
    func getDealerMarkup(url : String, completion: @escaping (DealerMarkupStruct, String?) -> Void) {
        var resultData = DealerMarkupStruct()
        
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: [:],  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultData = try JsonParsingManagar.parse(jsonData: data!, type: DealerMarkupStruct.self)
                    completion(resultData, resultData.msg)
                } catch {
                    completion(resultData, resultData.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(resultData, error.localizedDescription)
            }
        })
    }
    
    
    func getUpdateDealerMarkup(param:[String:Any],url : String, completion: @escaping (LogoutDataStruct, String?) -> Void) {
        var deleteProfile = LogoutDataStruct()
        
        AlamofireManager().makePostAPIRequest(url: url, param: param,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    deleteProfile = try JsonParsingManagar.parse(jsonData: data!, type: LogoutDataStruct.self)
                    completion(deleteProfile, deleteProfile.msg)
                } catch {
                    completion(deleteProfile, deleteProfile.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(deleteProfile, error.localizedDescription)
            }
        })
    }
    
    
}
    
