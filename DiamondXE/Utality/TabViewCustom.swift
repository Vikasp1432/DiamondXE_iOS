//
//  TabViewCustom.swift
//  DiamondXE
//
//  Created by iOS Developer on 15/05/24.
//

import Foundation
import UIKit

@IBDesignable
class CustomTabBar: UITabBar {
    private var shapeLayer: CALayer?
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        //shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
       // shapeLayer.lineWidth = 1.0

        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 2.5
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    
    func createPath() -> CGPath {
        let height: CGFloat = 29.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 20, y: height))
        
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 20, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    
    
//            func createPath() -> CGPath {
//                let height: CGFloat = 37.0
//                let buttonCount: CGFloat = 4 // Number of tab bar buttons
//                let buttonWidth = self.frame.width / buttonCount
//                let path = UIBezierPath()
//
//                path.move(to: CGPoint(x: 0, y: 0)) // start top left
//
//                // Loop to add curves for each button
//                for i in 0..<Int(buttonCount) {
//                    let startX = buttonWidth * CGFloat(i)
//                    let centerWidth = startX + buttonWidth / 2
//
//                    // First curve for the button
//                    path.addCurve(to: CGPoint(x: centerWidth, y: height),
//                                  controlPoint1: CGPoint(x: startX + buttonWidth * 0.25, y: 0),
//                                  controlPoint2: CGPoint(x: startX + buttonWidth * 0.25, y: height))
//
//                    // Second curve for the button
//                    path.addCurve(to: CGPoint(x: startX + buttonWidth, y: 0),
//                                  controlPoint1: CGPoint(x: startX + buttonWidth * 0.75, y: height),
//                                  controlPoint2: CGPoint(x: startX + buttonWidth * 0.75, y: 0))
//                }
//
//                path.addLine(to: CGPoint(x: self.frame.width, y: 0))
//                path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
//                path.addLine(to: CGPoint(x: 0, y: self.frame.height))
//                path.close()
//
//                return path.cgPath
//            }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}
