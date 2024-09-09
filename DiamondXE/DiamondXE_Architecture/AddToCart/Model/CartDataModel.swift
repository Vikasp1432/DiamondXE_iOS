//
//  CartDataModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 02/07/24.
//

import Foundation

struct RemoveCartItemStruct: Codable {
    var status: Int?
    var msg: String?
    var details: ContDetails?
 }

 // MARK: - Details
 struct ContDetails: Codable {
     var cartCount, wishlistCount: Int?

     enum CodingKeys: String, CodingKey {
         case cartCount = "cart_count"
         case wishlistCount = "wishlist_count"
     }
 }


class CartDataModel{
    static var shareInstence = CartDataModel()
    
    func getMyCartData(url : String, requestParam: [String:Any], completion: @escaping (CartDataStruct, String?) -> Void) {
        var cartDataResult = CartDataStruct()
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    cartDataResult = try JsonParsingManagar.parse(jsonData: data!, type: CartDataStruct.self)
                    completion(cartDataResult, cartDataResult.msg)
                } catch {
                    completion(cartDataResult, cartDataResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(cartDataResult, error.localizedDescription)
            }
        })
    }
    
    func removeItemFromCart(url : String, requestParam: [String:Any], completion: @escaping (RemoveCartItemStruct, String?) -> Void) {
        var cartItemRemove = RemoveCartItemStruct()
        AlamofireManager().makePostAPIRequest(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    cartItemRemove = try JsonParsingManagar.parse(jsonData: data!, type: RemoveCartItemStruct.self)
                    completion(cartItemRemove, cartItemRemove.msg)
                } catch {
                    completion(cartItemRemove, cartItemRemove.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(cartItemRemove, error.localizedDescription)
            }
        })
    }
}

