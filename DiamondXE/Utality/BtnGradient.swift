//
//  BtnGradient.swift
//  DiamondXE
//
//  Created by iOS Developer on 01/06/24.
//

import Foundation
import UIKit

class GradientButtonHandler {

    // Method to add gradient to a UIButton
    func addGradient(to button: UIButton, with colors: [UIColor]) {
        // Remove existing gradient layers if any
        clearGradient(from: button)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        
        // Insert the gradient layer below the button's title label
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Method to clear the gradient from a UIButton
    func clearGradient(from button: UIButton) {
        // Remove all gradient layers
        button.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
    }
}


extension UIButton {
    func setGradientLayer(colorsInOrder colors: [CGColor], startPoint sPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint ePoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
       
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func clearGradient() {
        // Remove all gradient layers
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        self.layer.shadowOpacity = 0
    }
    
}


extension UIView {
    func setGradientLayerView(colorsInOrder colors: [CGColor], startPoint sPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint ePoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
       
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.borderColor = UIColor.themeClr.cgColor

        layer.masksToBounds = false
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func clearGradientView() {
        // Remove all gradient layers
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        self.layer.shadowOpacity = 0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor

    }
    
}


