//
//  Delegates.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/04/24.
//

import Foundation
import UIKit

// delegates with country codes and name
protocol CountryInfoDelegate {
    func didcountryCodeAndName(countryID: Int,countryCode: String, countryName:String, countryFlag:String)
}
protocol CityInfoDelegate {
    func didGetCityName(cityID: Int,cityName: String)
}

protocol StateInfoDelegate {
    func didGetStateName(stateID: Int,stateName: String)
}


protocol EmialVerifyDelegate {
    func didEmailVerify(status: Int,msg: String)
}


protocol CellDataDelegate {
    func didUpdateText(textKey:String,text: String?, indexPath: IndexPath)
}


// navigation delegate
protocol DataReceiver {
    associatedtype DataType
    func receiveData(_ data: DataType)
}

protocol DataReceiver2 {
    associatedtype DataType1
    associatedtype DataType2
    func receiveData(_ data: DataType1)
    func receiveData2(_ data: DataType2)
}

// navigation delegate
protocol BaseViewControllerDelegate: AnyObject {
    func didPerformAction(tag: Int)
}

protocol ChildViewControllerProtocol: UIViewController {
    var delegate: BaseViewControllerDelegate? { get set }
    func didSendString(str:String)
}

protocol SearchOptionSelecteDelegate : AnyObject{
    func didselectOption(searchTitle:String,details: [SearchAttribDetail], shapeArr:[String])
}

protocol SearchOptionSelecteDelegateB2B : UIViewController {
    var delegateData: SearchOptionSelecteDelegate? { get set }
}


protocol B2BSearchResultVCDelegate: AnyObject {
    func didSelectDiamond(_ diamond: DiamondListingDetail)
}

protocol PinCodeDelegate {
    func didEnterPincode(pincode: String, indexPath: IndexPath)
}
