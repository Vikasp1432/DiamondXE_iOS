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
        layer.borderColor = UIColor.themeClr.cgColor

        layer.masksToBounds = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = self.cornerRadius
            gradientLayer.masksToBounds = true
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func setGradientLayerWithoutShadow(colorsInOrder colors: [CGColor], startPoint sPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint ePoint: CGPoint = CGPoint(x: 1, y: 0.5)) {

//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        layer.shadowRadius = 2.0
//        layer.shadowOpacity = 0.5
//        layer.borderColor = UIColor.themeClr.cgColor

        layer.masksToBounds = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = self.cornerRadius
            gradientLayer.masksToBounds = true
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    
//    override open func layoutSubviews() {
//        super.layoutSubviews()
//        setGradientLayer(colorsInOrder: [UIColor.red.cgColor, UIColor.blue.cgColor]) // Example colors
//    }
    
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
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = self.cornerRadius
            gradientLayer.masksToBounds = true
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func clearGradientView() {
        // Remove all gradient layers
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        self.layer.shadowOpacity = 0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor

    }
    
  
}



extension CAGradientLayer {

    func redBackgroundGradient() -> CAGradientLayer{
        let startColor =  UIColor(red:0.82, green:0.13, blue:0.19, alpha:1.0)
        let centreColor = UIColor(red:0.65, green:0.04, blue:0.10, alpha:1.0)
        let endColor = UIColor(red:0.56, green:0.04, blue:0.09, alpha:1.0)

        let gradientColors : [CGColor] = [startColor.cgColor,centreColor.cgColor,endColor.cgColor]
        let gradientLocations : [Float] = [0.0,0.5,1.0]
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?

        return gradientLayer
    }


}


class AnimatedButton: UIButton {

    // MARK: - Properties
        private var isAnimating = true

        // MARK: - Initializer methods
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
            
        }

        // MARK: - Setup method for button properties
        private func setup() {
//            addTarget(self, action: #selector(toggleAnimation), for: .touchUpInside)
            startAnimation()
        }

        // MARK: - Animation methods
//        @objc private func toggleAnimation() {
//            isAnimating.toggle()
//            if isAnimating {
//                startAnimation()
//            } else {
//                stopAnimation()
//            }
//        }

        private func startAnimation() {
            guard isAnimating else { return }
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.imageView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: nil)
        }

        private func stopAnimation() {
            imageView?.layer.removeAllAnimations()
            imageView?.transform = CGAffineTransform.identity
        }
    }
