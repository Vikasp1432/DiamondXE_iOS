//
//  UserTypeManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/04/24.
//

import Foundation
import  UIKit


class UserTypeManager{
    static func getSignupType(userType : Int) -> String{
        switch userType {
        case 0:
            return "Buyer"
        case 1:
            return "Dealer"
        default:
            return "Supplier"
        }
    }
    
    static func getSignupDataCellSections(userType : Int, isIndiaCode:Bool) -> Int{
        switch userType {
        case 0:
            return 2
        case 1:
            if isIndiaCode{
                return 6
            }
            else{
                return 5
            }
           
        default:
            return 5
        }
    }
    static func getSignupDataCellrow(userType : Int) -> Int{
        switch userType {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 1
        }
    }
}
