//
//  MyOrderDataModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 16/09/24.
//

import Foundation

class MyOrderDataModel{
    static var shareInstence = MyOrderDataModel()
    
    func getOrderListAPI(url : String, requestParam: [String:Any], completion: @escaping (MyOrderDataStruct, String?) -> Void) {
        var resultStruct = MyOrderDataStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: MyOrderDataStruct.self)
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
    
    
    func getOrderDetailsAPI(url : String, requestParam: [String:Any], completion: @escaping (OrderDetailsStruct, String?) -> Void) {
        var resultStruct = OrderDetailsStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: OrderDetailsStruct.self)
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
    
    func getOrderSummaryAPI(url : String, requestParam: [String:Any], completion: @escaping (OrderSummaryStruct, String?) -> Void) {
        var resultStruct = OrderSummaryStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: OrderSummaryStruct.self)
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
    
    func getOrderTrackingAPI(url : String, requestParam: [String:Any], completion: @escaping (TrackOrderStruct, String?) -> Void) {
        var resultStruct = TrackOrderStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: TrackOrderStruct.self)
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
    
    //makeGETAPIRequest
    func getResionsAPI(url : String, requestParam: [String:Any], completion: @escaping (ResionsDataStruct, String?) -> Void) {
        var resultStruct = ResionsDataStruct()
        AlamofireManager().makeGETAPIRequest(url: url, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: ResionsDataStruct.self)
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
    
    
    func getCancelOrderSummaryAPI(url : String, requestParam: [String:Any], completion: @escaping (CancelOrderSummaryStruct, String?) -> Void) {
        var resultStruct = CancelOrderSummaryStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: CancelOrderSummaryStruct.self)
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
    
    
    func getCancelOrderSummaryManageAPI(url : String, requestParam: [String:Any], completion: @escaping (CancelOrderPriceManageStruct, String?) -> Void) {
        var resultStruct = CancelOrderPriceManageStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: CancelOrderPriceManageStruct.self)
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
    
    func cancelOrderAPI(url : String, requestParam: [String:Any], completion: @escaping (CancelOrderProcessStruct, String?) -> Void) {
        var resultStruct = CancelOrderProcessStruct()
        AlamofireManager().makePostAPIRequestWithLocation2(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    resultStruct = try JsonParsingManagar.parse(jsonData: data!, type: CancelOrderProcessStruct.self)
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
