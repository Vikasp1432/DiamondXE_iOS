//
//  CustomPaymentModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/08/24.
//

import Foundation



class CustomPaymentModel{
    static var shareInstence = CustomPaymentModel()
    
    func getBankInfoData(url : String, requestParam: [String:Any], completion: @escaping (BankInfoDataStruct, String?) -> Void) {
        var dataObj = BankInfoDataStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: [:], completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    dataObj = try JsonParsingManagar.parse(jsonData: data!, type: BankInfoDataStruct.self)
                    completion(dataObj, dataObj.msg)
                } catch {
                    completion(dataObj, dataObj.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(dataObj, error.localizedDescription)
            }
        })
    }
    
    
    func getBankChargesInfoData(url : String, completion: @escaping (BankChargesStruct, String?) -> Void) {
        var dataObj = BankChargesStruct()
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: [:], completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    dataObj = try JsonParsingManagar.parse(jsonData: data!, type: BankChargesStruct.self)
                    completion(dataObj, dataObj.msg)
                } catch {
                    completion(dataObj, dataObj.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(dataObj, error.localizedDescription)
            }
        })
    }
    
    
    func getPaymentModeData(url : String, completion: @escaping (PaymentModeDataStruct, String?) -> Void) {
        var dataObj = PaymentModeDataStruct()
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: [:], completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    dataObj = try JsonParsingManagar.parse(jsonData: data!, type: PaymentModeDataStruct.self)
                    completion(dataObj, dataObj.msg)
                } catch {
                    completion(dataObj, dataObj.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(dataObj, error.localizedDescription)
            }
        })
    }
    
    
    func proceedPaymentAPI(url : String, requestParam: [String:Any], completion: @escaping (PaymentINProcessStruct, String?) -> Void) {
        var resultStruct = PaymentINProcessStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: PaymentINProcessStruct.self)
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
    
    func historyPaymentAPI(url : String, requestParam: [String:Any], completion: @escaping (CustomPaymentDataStruct, String?) -> Void) {
        var resultStruct = CustomPaymentDataStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: CustomPaymentDataStruct.self)
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
    
    func getpaymentStatusApi(url : String, requestParam: [String:Any], completion: @escaping (PaymentStatusStruct, String?) -> Void) {
        var resultStruct = PaymentStatusStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: PaymentStatusStruct.self)
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
