//
//  DiamondXE_Environment.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/04/24.
//

import Foundation


enum DiamondXEEnvironment {
    private static let infoDict: [String:Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist is not fount")
        }
        return dict
    }()
    
    static let rootURL : URL  = {
        guard let urlString = DiamondXEEnvironment.infoDict["Root_URL"] as? String else {
            fatalError("plist is not fount")

        }
        
        guard let url = URL(string: urlString) else {
            fatalError("plist is not fount")

        }
        return url
    }()
    
//    static let saltKey : URL  = {
//        guard let urlString = DiamondXEEnvironment.infoDict["Salt_KEY"] as? String else {
//            fatalError("plist is not fount")
//
//        }
//        
//        guard let url = URL(string: urlString) else {
//            fatalError("plist is not fount")
//
//        }
//        return url
//    }()
//    
//    static let marchantID : URL  = {
//        guard let urlString = DiamondXEEnvironment.infoDict["Marchant_ID"] as? String else {
//            fatalError("plist is not fount")
//
//        }
//        
//        guard let url = URL(string: urlString) else {
//            fatalError("plist is not fount")
//
//        }
//        return url
//    }()
    
}
