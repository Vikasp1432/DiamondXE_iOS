//
//  WishlistDataModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 03/07/24.
//

import Foundation

class WishlistDataModel{
    static var shareInstence = WishlistDataModel()
    
    func getWishlistData(url : String, requestParam: [String:Any], completion: @escaping (WishlistDataStruct, String?) -> Void) {
        var wishlistDataResult = WishlistDataStruct()
        AlamofireManager().makePostAPIRequestWithLocation(url: url, param: requestParam, completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    wishlistDataResult = try JsonParsingManagar.parse(jsonData: data!, type: WishlistDataStruct.self)
                    completion(wishlistDataResult, wishlistDataResult.msg)
                } catch {
                    completion(wishlistDataResult, wishlistDataResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(wishlistDataResult, error.localizedDescription)
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
