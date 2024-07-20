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
        print("Print Final Header ----------->\(headers)")
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                print(response)
                switch response.result {
                case .success(let data):
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                    completion(.success(data))
                case .failure(let error):
                  completion(.failure(error))
                    
                }
            }
    }
    
    
    func makePostAPIRequestWithLocation(url : String,param: [String: Any], completion: @escaping (Result<Data?, Error>) -> Void) {
        let headers: HTTPHeaders = HeaderInfoLocation().headers
        // Define your API endpoint and parameters
        print("Print Final URL ----------->\(url)")
        print("Print Final Psram ----------->\(param)")
        print("Print Final Header ----------->\(headers)")
        AF.request(url, method: .get, parameters: param, encoding:  URLEncoding.queryString, headers: headers).response { response in
          switch response.result {
          case .success:
              let data = response.data
              
              if data != nil{
                  let str = String(decoding: data!, as: UTF8.self)
                  print(str)
              }
              completion(.success(data))
             // OnResultBlock(data as Any, true)
              
          case let .failure(error):
            print(error)
              completion(.failure(error))
              //OnResultBlock(error, false)
          }
        }
    }
 
    // get API
    func makeGETAPIRequest(url : String, completion: @escaping (Result<Data?, Error>) -> Void) {
        let headers: HTTPHeaders = HeaderInfoLocation().headers
        AF.request(url, method: .get, parameters: nil, encoding:  URLEncoding.queryString, headers: headers).response { response in
          switch response.result {
          case .success:
              let data = response.data
              
              if data != nil{
                  let str = String(decoding: data!, as: UTF8.self)
                  print(str)
              }
              completion(.success(data))
             // OnResultBlock(data as Any, true)
              
          case let .failure(error):
            print(error)
              completion(.failure(error))
              //OnResultBlock(error, false)
          }
        }
              
     }
    
    // get API
    func makeGETAPIRequestWithLocation(url : String, completion: @escaping (Result<Data?, Error>) -> Void) {
        let headers: HTTPHeaders = HeaderInfoLocation().headers
        AF.request(url, method: .get, parameters: nil, encoding:  URLEncoding.queryString, headers: headers).response { response in
          switch response.result {
          case .success:
              let data = response.data
              
              if data != nil{
                  let str = String(decoding: data!, as: UTF8.self)
                  print(str)
              }
              completion(.success(data))
             // OnResultBlock(data as Any, true)
              
          case let .failure(error):
            print(error)
              completion(.failure(error))
              //OnResultBlock(error, false)
          }
        }
              
     }
    

}
