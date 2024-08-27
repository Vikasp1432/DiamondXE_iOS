//
//  RingSizerModel.swift
//  DXE Price
//
//  Created by iOS Developer on 12/04/24.
//

import Foundation
import UIKit

class RingSizeModel: NSObject
{
    public var diameter_mm  : CGFloat = 1.0
    public var usaCode   : String?
    public var inrCode   : String?
    public var diameter_eur  : CGFloat = 1.0
    public var ukCode   : String?

    
    init(diameter_mm: CGFloat, usaCode: String, inrCode: String, diameter_eur: CGFloat, ukCode:String)
    {
        self.diameter_mm = diameter_mm
        self.usaCode  = usaCode
        self.inrCode  = inrCode
        self.diameter_eur = diameter_eur
        self.ukCode = ukCode
    }
}

