//
//  ViewProperty.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/04/24.
//

import Foundation
import UIKit

// border property
@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
            get { return layer.cornerRadius }
            set {
                  layer.cornerRadius = newValue

                  // If masksToBounds is true, subviews will be
                  // clipped to the rounded corners.
                  layer.masksToBounds = (newValue > 0)
            }
        }
    
    
    
 

    
}

extension UIView {
    //UIColor.red.cgColor//UIColor(red: 0.918, green: 0.925, blue: 0.965, alpha: 1).cgColor
    func addBottomShadow(shadowColor: UIColor = UIColor(red: 0.234, green: 0.236, blue: 0.246, alpha: 1),
                         shadowOffset: CGSize = CGSize(width: 0, height: 3),
                         shadowOpacity: Float = 0.5,
                         shadowRadius: CGFloat = 10) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: bounds.maxY))
        shadowPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        shadowPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY + shadowOffset.height))
        shadowPath.addLine(to: CGPoint(x: 0, y: bounds.maxY + shadowOffset.height))
        shadowPath.close()
        layer.shadowPath = shadowPath.cgPath
    }
}
