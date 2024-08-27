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
    func paymentTransactionID(transectionID: String)
}


class PaymentManager {

    static let shared = PaymentManager()
    var delegate : TransactionIDDelegate?
    
    var paymentType = String()
    var upiName = String()
    var paymentInstrumentbnkID = String()
    var paymentInstrumentTargetApp = String()
    

    func initiatePhonePeTransaction(from viewController: UIViewController) {
        
        var paymentInstrument : [String:Any] = [:]
    
        switch paymentType {
        case "UPI":
            paymentInstrument =  ["type": "UPI_INTENT",
                                  "targetApp": "\(upiName)".uppercased()]
        case "CreditCard":
            paymentInstrument =  ["type": "PAY_PAGE"]
        case "NetBanking":
            paymentInstrument =  ["type": "NET_BANKING",
                                  "bankId": "\(paymentInstrumentbnkID)"]
        default:
            print("")
        }
        
        
        // Product details
        let productId = "BHD1234511"
        let amount = 1000 // amount in paise
        
        
        
        // Construct the API endpoint
        let apiEndPoint = "/pg/v1/pay" //"https://api-preprod.phonepe.com/apis/pg-sandbox/v1/pay"
        
        // Construct the request payload
        let requestBody: [String: Any] = [
            "merchantId": "DIAMONDUAT",
            "merchantTransactionId": generateTransactionId(),
            "amount": amount,
            "productId": productId,
            "merchantUserId": "MUID123",
            "callbackUrl": "https://webhook.site/callback-url",
            "mobileNumber": "9999999999",
          //  "paymentInstrument": ["type": "PAY_PAGE"]
            "paymentInstrument": paymentInstrument
            
        ]
        
        print(requestBody)
        
        // Convert request body to JSON and then to base64
        let jsonData = try! JSONSerialization.data(withJSONObject: requestBody, options: [])
        let base64EncodedString = jsonData.base64EncodedString()

        // Generate checksum (should be generated on the server)
        let payloadChecksum = generateChecksum(base64EncodedString: base64EncodedString, saltKey: "1c560f14-86f2-4317-86bf-658f92554b58", apiEndPoint: "\(apiEndPoint)")

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
        if isPhonePeAppInstalled() {
            // Initialize the payment with the app
            PPPayment(environment: .sandbox, enableLogging: true, appId: nil)
                .startPG(transactionRequest: request, on: viewController, animated: true) { _, result in
                    let text = "\(result)"
                    print("Transaction result: \(text)")
                    
                   /// self.verifyTransactionStatus(transactionId: requestBody["merchantTransactionId"] as! String)
                    
                    self.delegate?.paymentTransactionID(transectionID: requestBody["merchantTransactionId"] as! String)
                    
                    
                    if case let .failure(error) = result {
                        print("Transaction failed with error: \(error.localizedDescription)")
                        // Handle the failure
                    }
                    
                }
        } else {
            // Redirect to the PhonePe web payment page
            if let url = URL(string: "https://www.phonepe.com/en-in/upi-payments/") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    // Check if PhonePe app is installed
    private func isPhonePeAppInstalled() -> Bool {
        if let url = URL(string: "phonepe://"), UIApplication.shared.canOpenURL(url) {
            return true
        } else {
            return false
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
