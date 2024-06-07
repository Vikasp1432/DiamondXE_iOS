//
//  SearchOptionModel.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/06/24.
//

import Foundation
import UIKit

class SearchOptionModel {
    
    func getSeachAttributes(url : String, completion: @escaping (SearchOptionDataStruct, String?) -> Void) {
        var searchAttriDataResult = SearchOptionDataStruct()
        
        AlamofireManager().makeGETAPIRequestWithLocation(url: url,  completion: { result in
            switch result {
            case .success(let data):
                // Handle the response data
                do {
                    searchAttriDataResult = try JsonParsingManagar.parse(jsonData: data!, type: SearchOptionDataStruct.self)
                    completion(searchAttriDataResult, searchAttriDataResult.msg)
                } catch {
                    completion(searchAttriDataResult, searchAttriDataResult.msg)
                }
            case .failure(let error):
                // Handle the error
                completion(searchAttriDataResult, error.localizedDescription)
            }
        })
    }
}
