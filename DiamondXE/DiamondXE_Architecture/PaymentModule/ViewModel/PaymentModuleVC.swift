//
//  PaymentModuleVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 11/08/24.
//

import Foundation
import CryptoKit
import UIKit
import PhonePePayment

class PaymentModuleVC: BaseViewController {
   
    
      let merchantID = "DIAMONDUAT"
      let saltKey = "1c560f14-86f2-4317-86bf-658f92554b58"
      let saltIndex = "1"
      let hostURL = "https://api-preprod.phonepe.com/apis/pg-sandbox/"
      let apiEndPoint = "/pg/v1/pay"

    override func viewDidLoad() {
        super.viewDidLoad()
        SwipeGestureUtility.addSwipeGesture(to: self.view, navigationController: self.navigationController)


        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnActionBYU(_ sender : UIButton){
        PaymentManager.shared.initiatePhonePeTransaction(from: self)
    }

   
////    func initiatePhonePeTransaction(appName: String) {
////        // Product details
////        let productId = "BHD1234511"
////        let amount = 1000 // amount in paise
////        
////        // Construct the API endpoint
////       // var appTarget = 
////       
////        
////        // Construct the request payload
////        let requestBody: [String: Any] = [
////            "merchantId": merchantID,
////            //"apiEndPoint": "/pg/v1/pay",
////            "transactionId": generateTransactionId(),
////            "amount": amount,
////            "productId": productId,
////            "merchantTransactionId": "MT7850590068188104",
////            "merchantUserId": "MUID123",
////            "callbackUrl": "",
////            "mobileNumber": "9999999999",
////            "deviceContext": [
////              "deviceOS": "IOS"
////            ],
//            "paymentInstrument": [
//                "type": "UPI_INTENT",
//                "targetApp": "PHONEPE"
//            ]
////            
////            
////        ]
////        
////        // Convert request body to JSON and then to base64
////        do {
////            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
////            let base64EncodedString = jsonData.base64EncodedString()
////
////            // Generate checksum (should be generated on the server)
////            let payloadChecksum = generateChecksum(base64EncodedString: base64EncodedString, saltKey: saltKey, apiEndPoint: self.apiEndPoint)
////
////            // Define headers
////            let headers: [String: String] = [
////                "Content-Type": "application/json",
////                "X-VERIFY": "\(payloadChecksum)###\(saltIndex)"
////            ]
////            
////            // Log the request details for debugging
////            print("API Endpoint: \(apiEndPoint)")
////            print("Request Body: \(requestBody)")
////            print("Headers: \(headers)")
////            print("checksum: \(payloadChecksum)")
////
////            // Create the transaction request
////            let request = DPSTransactionRequest(
////                body: base64EncodedString,
////                apiEndPoint: apiEndPoint,
////                checksum: payloadChecksum,
////                headers: headers,
////                appSchema: "iOSIntentIntegration"
////            )
////
////            // Initialize the payment
////            PPPayment(environment: .sandbox, enableLogging: true, appId: nil)
////                .startPG(transactionRequest: request, on: self, animated: true) { _, result in
////                    // Handle the result of the transaction
////                    let text = "\(result)"
////                    print("Transaction result: \(text)")
////                    
////                    // Now check the transaction status with your server and update the user
////                    
////                    if case let .failure(error) = result {
////                              print("Transaction failed with error: \(error.localizedDescription)")
////                          }
////                    
////                    self.verifyTransactionStatus(transactionId: requestBody["transactionId"] as! String)
////                }
////        } catch {
////            print("Error encoding JSON: \(error)")
////        }
////    }
//    
//    func initiatePhonePeTransaction() {
//         
//          // Product details
//          let productId = "BHD1234511"
//          let amount = 1000 // amount in paise
//          
//          // Construct the API endpoint
//        let apiEndPoint = "\(self.hostURL)v3/transaction/initialize"
//          
//          // Construct the request payload
//          let requestBody: [String: Any] = [
//              "merchantId": merchantID,
//              "transactionId": generateTransactionId(),
//              "amount": amount,
//              "productId": productId
//          ]
//          
//          // Convert request body to JSON and then to base64
//          let jsonData = try! JSONSerialization.data(withJSONObject: requestBody, options: [])
//          let base64EncodedString = jsonData.base64EncodedString()
//
//          // Generate checksum (should be generated on the server)
//          let payloadChecksum = generateChecksum(base64EncodedString: base64EncodedString, saltKey: saltKey)
//
//          // Define headers
//          let headers: [String: String] = [
//              "Content-Type": "application/json",
//              "X-VERIFY": "\(payloadChecksum)###\(saltIndex)"
//          ]
//          
//          // Create the transaction request
//          let request = DPSTransactionRequest(
//              body: base64EncodedString,
//              apiEndPoint: apiEndPoint,
//              checksum: payloadChecksum,
//              headers: headers,
//              appSchema: String()
//          )
//
//          // Initialize the payment
//          PPPayment(environment: .sandbox, enableLogging: true, appId: nil)
//              .startPG(transactionRequest: request, on: self, animated: true) { _, result in
//                  // Handle the result of the transaction
//                  let text = "\(result)"
//                  print("Transaction result: \(text)")
//                  
//                  // Now check the transaction status with your server and update the user
//                  self.verifyTransactionStatus(transactionId: requestBody["transactionId"] as! String)
//              }
//      }

}

