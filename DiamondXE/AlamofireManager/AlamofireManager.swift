//
//  AlamofireManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 19/04/24.
//

import Foundation
import Alamofire

class AlamofireManager {
    
    static var shareInstence = AlamofireManager()

    func makePostAPIRequest(url : String,param: [String: Any], completion: @escaping (Result<Data?, Error>) -> Void) {
        let headers: HTTPHeaders = HeaderInfo().headers
        // Define your API endpoint and parameters
        print("Print Final URL ----------->\(url)")
        print("Print Final Psram ----------->\(param)")
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                print(response)
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                  completion(.failure(error))
                    
                }
            }
    }
    
//    //Post APi
//    func alamofireApiCalling(apiURl:String,paramater: [String:Any],shape:String,OnResultBlock: @escaping (_ dict: Any,_ status:Bool) -> Void) {
//        let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
////        let paramater = ["request": [
////                "header": [
////                    "username": "privateKey",
////                    "password": "privateKeyPass"
////                ],
////                "body": [
////                    "shape" : shape
//////                    "size" : size,
//////                    "color" : color,
//////                    "clarity" : clarity
////                    
////                ]
////            ]
////        ]
//        print(apiURl)
//        print(paramater)
//        AF.request(apiURl, method: .post, parameters: paramater,encoding: JSONEncoding.default, headers: headers)
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    let data = response.data
//                    if data != nil{
//                        let str = String(decoding: data!, as: UTF8.self)
//                    }
//                    OnResultBlock(data as Any, true)
//                    
//                case let .failure(error):
//                  print(error)
//                    OnResultBlock(error, false)
//                }
//            }
//    }
//    
   

    
    // get API
      func callAPiINRInfoJson(apiURl:String,OnResultBlock: @escaping (_ dict: Any,_ status:Bool) -> Void) {
        let url = apiURl
        AF.request(url, method: .get, parameters: nil, encoding:  URLEncoding.queryString, headers: nil).response { response in
          switch response.result {
          case .success:
              let data = response.data
              
              if data != nil{
                  let str = String(decoding: data!, as: UTF8.self)
                  print(str)
              }
              OnResultBlock(data as Any, true)
              
          case let .failure(error):
            print(error)
              OnResultBlock(error, false)
          }
        }
              
     }
    

    

}
