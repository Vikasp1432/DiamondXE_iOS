//
//  PaymentManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 14/08/24.
//

import Foundation
import UIKit
import CryptoKit
import UIKit
import PhonePePayment

// live credential PhionePay

//MERCHANT_ID  :   DIAMONDXEONLINE
//SALT_KEY     :   b74e2a4c-7d13-43c5-a115-c0372ed85dbd
//SALT_INDEX   :   1
//HOST_URL     :   https://api.phonepe.com/apis/hermes/




#if os(iOS) && swift(>=5.0)
import CryptoKit

func sha256(_ string: String) -> String {
    guard let data = string.data(using: .utf8) else {
        return ""
    }
    
    let hash = SHA256.hash(data: data)
    
    return hash.compactMap {
        String(format: "%02x", $0)
    }.joined()
}
#else
import CommonCrypto

func sha256(_ string: String) -> String {
    // CommonCrypto implementation
    if let data = string.data(using: .utf8) {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash).map { String(format: "%02hhx", $0) }.joined()
    }
    return ""
}
#endif


protocol TransactionIDDelegate {
    func paymentTransactionID(transectionID: String, paymentStatus:String)
}


class PaymentManager {

    static let shared = PaymentManager()
    var delegate : TransactionIDDelegate?
    
    var paymentType = String()
    var upiName = String()
    var upiPackageName = String()
    var paymentInstrumentbnkID = String()
    var paymentInstrumentTargetApp = String()
    var paymentINProcessStruct = PaymentINProcessStruct()
    var callBackURl : String?
    

    func initiatePhonePeTransaction(from viewController: UIViewController) {
        
        if let calURL = callBackURl {
            print(calURL)
        }
        else{
            callBackURl = "\(APIs().callBackURL)"
        }
        
      
        var paymentInstrument : [String:Any] = [:]
    
        switch paymentType {
        case "UPI":
            paymentInstrument =  ["type": "UPI_INTENT",
                                  "targetApp": "\(upiName)"]
        case "CreditCard":
            paymentInstrument =  ["type": "PAY_PAGE"]
        case "NetBanking":
            paymentInstrument =  ["type": "NET_BANKING",
                                  "bankId": "\(paymentInstrumentbnkID)"]
        default:
            print("")
        }
    
        // Construct the API endpoint
        let apiEndPoint = "/pg/v1/pay" //"https://api-preprod.phonepe.com/apis/pg-sandbox/v1/pay"
        var updatedAmt = Double()
        if let amount = paymentINProcessStruct.details?.totalAmount{
             updatedAmt = Double(amount) * 100
        }
        
        
        // Construct the request payload
        //https://api-preprod.phonepe.com/apis/pg-sandbox
        let requestBody: [String: Any] = [
            "merchantId": "DIAMONDXEONLINE", //"\(DiamondXEEnvironment.marchantID)",//"DIAMONDXEONLINE",DIAMONDUAT
            "merchantTransactionId": paymentINProcessStruct.details?.orderID ?? "",
            "amount": updatedAmt,
            "productId": "b74e2a4c-7d13-43c5-a115-c0372ed85dbd",//"\(DiamondXEEnvironment.saltKey)",
            "merchantUserId": paymentINProcessStruct.details?.userID ?? "",
            "callbackUrl": callBackURl ?? "",
            "mobileNumber": paymentINProcessStruct.details?.userData?.mobile ?? "",
            "deviceContext": [
               "deviceOS": "IOS",
               "merchantCallBackScheme": "iOSIntentIntegration"
             ],
            "paymentInstrument": paymentInstrument
            
        ]
        
//        print(DiamondXEEnvironment.marchantID)
//        print(DiamondXEEnvironment.saltKey)
        print(requestBody)
        
        // Convert request body to JSON and then to base64
        let jsonData = try! JSONSerialization.data(withJSONObject: requestBody, options: [])
        let base64EncodedString = jsonData.base64EncodedString()

        // Generate checksum (should be generated on the server)
        // saltkey = live - b74e2a4c-7d13-43c5-a115-c0372ed85dbd, test - 1c560f14-86f2-4317-86bf-658f92554b58
        let payloadChecksum = generateChecksum(base64EncodedString: base64EncodedString, saltKey: "b74e2a4c-7d13-43c5-a115-c0372ed85dbd", apiEndPoint: "\(apiEndPoint)")

        // Define headers
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "X-VERIFY": "\(payloadChecksum)###1"
        ]
        
        // Create the transaction request
        let request = DPSTransactionRequest(
            body: base64EncodedString,
            apiEndPoint: apiEndPoint,
            checksum: payloadChecksum,
            headers: headers,
            appSchema: "iOSIntentIntegration"
        )
        
        // Check if PhonePe app is installed
//        if isPhonePeAppInstalled() {
            // Initialize the payment with the app
            PPPayment(environment: .production, enableLogging: true, appId: "b74e2a4c-7d13-43c5-a115-c0372ed85dbd")
                .startPG(transactionRequest: request, on: viewController, animated: true) { data, result in
                    let text = "\(result)"
                    print("Transaction result: \(text)")
                  
                    
                    if self.paymentType == "UPI"{
                        
                        
//                       let transactionID =  requestBody["merchantTransactionId"] as! String
//                        let urlString = "\(self.upiPackageName)pay?amount=\(1.0)&cu=INR&tid=\(transactionID)&merchantId=DIAMONDXEONLINE"

                        self.openUPIApp(with: self.upiPackageName)
                        
                        self.delegate?.paymentTransactionID(transectionID: requestBody["merchantTransactionId"] as! String, paymentStatus: "\(result)")
                        
                    }
                    
                   /// self.verifyTransactionStatus(transactionId: requestBody["merchantTransactionId"] as! String)
                    
                    self.delegate?.paymentTransactionID(transectionID: requestBody["merchantTransactionId"] as! String, paymentStatus: "\(result)")
                    
                    if case let .failure(error) = result {
                        print("Transaction failed with error: \(error.localizedDescription)")
                        // Handle the failure
                    }
                    
                }
//        } else {
//            // Redirect to the PhonePe web payment page
//            if let url = URL(string: "https://www.phonepe.com/en-in/upi-payments/") {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
        
    }
    
    func openUPIApp(with urlScheme: String) {
            if let url = URL(string: urlScheme) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Invalid URL scheme.")
            }
        }
    
    
    // Generate a unique transaction ID
    private func generateTransactionId() -> String {
        return UUID().uuidString
    }
    
    // Example function to generate checksum (this should be done on your server)
    func generateChecksum(base64EncodedString: String, saltKey: String, apiEndPoint:String) -> String {
          let dataToHash = "\(base64EncodedString)\(apiEndPoint)\(saltKey)"
          return sha256(dataToHash)
      }

    func sha256(_ string: String) -> String {
        guard let data = string.data(using: .utf8) else {
            return ""
        }
        
        let hash = SHA256.hash(data: data)
        
        return hash.compactMap {
            String(format: "%02x", $0)
        }.joined()
    }
    
    func verifyTransactionStatus(transactionId: String) {
          print(transactionId)
      }
    
}
