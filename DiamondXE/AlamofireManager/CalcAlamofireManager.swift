//
//  CalcAlamofireManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/08/24.
//

import Foundation
import Alamofire

class CalcAlamofireManager : NSObject {
    
    var currencyDelegate : CurrencyResponceProtocol?
    
    func alamofireApiCalling(shape:String,OnResultBlock: @escaping (_ dict: Any,_ status:Bool) -> Void) {
        let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        let paramater = ["request": [
                "header": [
                    "username": privateKey,
                    "password": privateKeyPass
                ],
                "body": [
                    "shape" : shape
//                    "size" : size,
//                    "color" : color,
//                    "clarity" : clarity
                    
                ]
            ]
        ]
        
        print(apiGetPrice)
        print(paramater)
        AF.request(apiGetPrice, method: .post, parameters: paramater,encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let data = response.data
                    if data != nil{
                        let str = String(decoding: data!, as: UTF8.self)
                    }
                    OnResultBlock(data as Any, true)
                    
                case let .failure(error):
                  print(error)
                    OnResultBlock(error, false)
                }
            }
    }
    
   
    // getcurrency api
    static  func callAPiGetCurrencyJson(OnResultBlock: @escaping (_ dict: Any,_ status:Bool) -> Void) {
        let url = apiCurrencyValue
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
    
    
    // get inr info api
      func callAPiINRInfoJson(OnResultBlock: @escaping (_ dict: Any,_ status:Bool) -> Void) {
        let url = inrInfoURL
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
