//
//  PriceListStruct.swift
//  DXE Calc
//
//  Created by Genie Talk on 03/03/23.
import Foundation
import UIKit


struct PriceListStruct : Codable {
    var response: Response?
    enum CodingKeys: String, CodingKey {
          case response
       }
}

// MARK: - Response
struct Response : Codable {
    var header: Header?
    var body: Body?
}

// MARK: - Body
struct Body : Codable {
    var price: [Price]?
}

// MARK: - Price
struct Price  : Codable{
    var shape: String?
    var high_size, low_size: Double?
    var color: String?
    var clarity: String?
    var caratprice: Int?
    var date: String?
 
}


enum Clarity  {
    case clarityIf
    case i1
    case i2
    case i3
    case si1
    case si2
    case si3
    case vs1
    case vs2
    case vvs1
    case vvs2
}

enum Color {
    case d
    case e
    case f
    case g
    case h
    case i
    case j
    case k
    case l
    case m
    case n
}

enum Shape {
    case round
}

// MARK: - Header
struct Header  : Codable {
    var errorCode: Int?
    var errorMessage: String?
}

