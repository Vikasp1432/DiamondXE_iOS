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
    
    
    func addInnerOuterShadow(shadowColor: UIColor = UIColor(red: 0.234, green: 0.236, blue: 0.246, alpha: 1),
                         shadowOffset: CGSize = CGSize(width: 0, height: 3),
                         shadowOpacity: Float = 0.5,
                             shadowRadius: CGFloat = 10) {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        
    
    }

}




@IBDesignable
class InnerDropShadowView: UIView {
    
    @IBInspectable var shadowColor: UIColor = UIColor.black.withAlphaComponent(0.3)
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowBlurRadius: CGFloat = 10
//    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var backgroundColorForView: UIColor = .groupTableViewBackground {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Rectangle Drawing with Corner Radius
        let rectanglePath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        backgroundColorForView.setFill()
        rectanglePath.fill()
        
        // Rectangle Inner Shadow
        context.saveGState()
        UIRectClip(rectanglePath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0, color: nil)
        context.setAlpha(shadowColor.cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let opaqueShadowColor = shadowColor.withAlphaComponent(1)
        context.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: opaqueShadowColor.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        opaqueShadowColor.setFill()
        rectanglePath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           
           // Apply outer shadow
//           layer.shadowColor = UIColor.red.cgColor
//           layer.shadowOffset = shadowOffset
//           layer.shadowRadius = shadowBlurRadius
//           layer.shadowOpacity = 1
//        layer.cornerRadius = cornerRadius
//        layer.masksToBounds = false

//           layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.3
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
       }
}


@IBDesignable
class HeaderDropShadow : UIView{
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
    }
    override func layoutSubviews() {
           super.layoutSubviews()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
}
