//
//  SignupModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 01/05/24.
//

import Foundation

class SignupDataModel {
    
    func userSignup(url : String, requestParam: [String:Any], completion: @escaping (SignupReponceDataStruct, String?) -> Void) {
        var signupResult = SignupReponceDataStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    signupResult = try JsonParsingManagar.parse(jsonData: data!, type: SignupReponceDataStruct.self)
                    completion(signupResult, signupResult.msg)
                } catch {
                    completion(signupResult, signupResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(signupResult, error.localizedDescription)
            }
        })
    }
    
    func emialVerification(url : String, requestParam: [String:Any], completion: @escaping (EmialVerify, String?) -> Void) {
        var emailVerifyResult = EmialVerify()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    emailVerifyResult = try JsonParsingManagar.parse(jsonData: data!, type: EmialVerify.self)
                    completion(emailVerifyResult, emailVerifyResult.msg)
                } catch {
                    completion(emailVerifyResult, emailVerifyResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(emailVerifyResult, error.localizedDescription)
            }
        })
    }
    
    
    func getStateList(url : String, requestParam: [String:Any], completion: @escaping (StateListStruct, String?) -> Void) {
        var stateListResult = StateListStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    stateListResult = try JsonParsingManagar.parse(jsonData: data!, type: StateListStruct.self)
                    completion(stateListResult, stateListResult.msg)
                } catch {
                    completion(stateListResult, stateListResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(stateListResult, error.localizedDescription)
            }
        })
    }
    
    
    func getCityList(url : String, requestParam: [String:Any], completion: @escaping (CityListStruct, String?) -> Void) {
        var cityListResult = CityListStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    cityListResult = try JsonParsingManagar.parse(jsonData: data!, type: CityListStruct.self)
                    completion(cityListResult, cityListResult.msg)
                } catch {
                    completion(cityListResult, cityListResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(cityListResult, error.localizedDescription)
            }
        })
    }
    
    func getOtherDocList(url : String, requestParam: [String:Any], completion: @escaping (OtherDocListStruct, String?) -> Void) {
        var otherDocResult = OtherDocListStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    otherDocResult = try JsonParsingManagar.parse(jsonData: data!, type: OtherDocListStruct.self)
                    completion(otherDocResult, otherDocResult.msg)
                } catch {
                    completion(otherDocResult, otherDocResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(otherDocResult, error.localizedDescription)
            }
        })
    }
    
    
    
    func verifyDoc(url : String, requestParam: [String:Any], completion: @escaping (DocVerifyStruct, String?) -> Void) {
        var verifyDocResult = DocVerifyStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    verifyDocResult = try JsonParsingManagar.parse(jsonData: data!, type: DocVerifyStruct.self)
                    completion(verifyDocResult, verifyDocResult.msg)
                } catch {
                    completion(verifyDocResult, verifyDocResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(verifyDocResult, error.localizedDescription)
            }
        })
    }
    
    
    
}
