//
//  LoginModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/04/24.
//

import Foundation

class LoginDataModel {
    
    func loginUser(url : String, requestParam: [String:Any], completion: @escaping (LoginDataStruct, String?) -> Void) {
        var loginResult = LoginDataStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    loginResult = try JsonParsingManagar.parse(jsonData: data!, type: LoginDataStruct.self)
                    completion(loginResult, loginResult.msg)
                } catch {
                    completion(loginResult, loginResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(loginResult, error.localizedDescription)
            }
        })
    }
    
    
    func forgotPassword(url : String, requestParam: [String:Any], completion: @escaping (ForgotPassStruct, String?) -> Void) {
        var forgotPassResult = ForgotPassStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    forgotPassResult = try JsonParsingManagar.parse(jsonData: data!, type: ForgotPassStruct.self)
                    completion(forgotPassResult, forgotPassResult.msg)
                } catch {
                    completion(forgotPassResult, forgotPassResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(forgotPassResult, error.localizedDescription)
            }
        })
    }
    
    
    func resetPassword(url : String, requestParam: [String:Any], completion: @escaping (ForgotPassStruct, String?) -> Void) {
        var forgotPassResult = ForgotPassStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    forgotPassResult = try JsonParsingManagar.parse(jsonData: data!, type: ForgotPassStruct.self)
                    completion(forgotPassResult, forgotPassResult.msg)
                } catch {
                    completion(forgotPassResult, forgotPassResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(forgotPassResult, error.localizedDescription)
            }
        })
    }
    
    
    func getCountryList(url : String, requestParam: [String:Any], completion: @escaping (CountryListStruct, String?) -> Void) {
        var countryListResult = CountryListStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    countryListResult = try JsonParsingManagar.parse(jsonData: data!, type: CountryListStruct.self)
                    completion(countryListResult, countryListResult.msg)
                } catch {
                    completion(countryListResult, countryListResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(countryListResult, error.localizedDescription)
            }
        })
    }
    
    
}
