//
//  UITextFieldProperty.swift
//  DiamondXE
//
//  Created by iOS Developer on 08/07/24.
//

import Foundation
import UIKit

class CustomTextField: UITextField {

    var errorColor: UIColor = .red {
        didSet {
            layer.borderColor = errorColor.cgColor
        }
    }

    var errorMessage: String? {
        didSet {
            updateBorderColor()
        }
    }

//    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override init(frame: CGRect) {
        super.init(frame: frame)
       // setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setup()
    }

//    private func setup() {
//        self.font = UIFont(name: "Lato-Medium", size: 15)
//        layer.backgroundColor = UIColor.white.cgColor
//        layer.borderWidth = 1.0
//        layer.cornerRadius = 8.0
//        layer.borderColor = UIColor.lightGray.cgColor
//        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
//        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
//    }
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }

    @objc private func editingDidBegin() {
        layer.borderColor = UIColor.clear.cgColor
    }

    @objc private func editingDidEnd() {
        updateBorderColor()
    }

    private func updateBorderColor() {
        layer.borderColor = errorMessage == nil ? UIColor.clear.cgColor : errorColor.cgColor
    }

    func getText() -> String? {
        return text
    }
}

class CustomTextFieldContainer: UIView, UITextFieldDelegate {

     let textField = CustomTextField()
     let errorLabel = UILabel()
    private var heightConstraint: NSLayoutConstraint?
       
       @IBInspectable var placeholder: String? {
           didSet {
               textField.placeholder = placeholder
           }
       }

       @IBInspectable var errorColor: UIColor = UIColor.red {
           didSet {
               errorLabel.textColor = errorColor
               textField.errorColor = errorColor
           }
       }

       var errorMessage: String? {
           didSet {
               textField.errorMessage = errorMessage
               errorLabel.text = errorMessage
               errorLabel.isHidden = errorMessage == nil
               updateHeightConstraint()
               setNeedsLayout()
           }
       }

       override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setup()
       }

       private func setup() {
           // Setup text field
          // addSubview(textField)
           textField.delegate = self
           textField.translatesAutoresizingMaskIntoConstraints = false
           textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
           textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
           textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
           textField.heightAnchor.constraint(equalToConstant: 40).isActive = true

           // Setup error label
           errorLabel.font = UIFont.systemFont(ofSize: 12)
           errorLabel.textColor = errorColor
           errorLabel.numberOfLines = 0
           errorLabel.isHidden = true
           addSubview(errorLabel)
           errorLabel.translatesAutoresizingMaskIntoConstraints = false
           errorLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
           errorLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
           errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4).isActive = true

           // Adjust height of the container
           heightConstraint = heightAnchor.constraint(equalToConstant: 40)
           heightConstraint?.isActive = true
       }

       private func updateHeightConstraint() {
           let errorLabelHeight = errorLabel.sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude)).height
           let newHeight = errorMessage == nil ? 40 : (40 + errorLabelHeight + 4)
           heightConstraint?.constant = newHeight
           layoutIfNeeded()
       }

       override func layoutSubviews() {
           super.layoutSubviews()
           textField.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
           let errorLabelHeight = errorLabel.sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude)).height
           errorLabel.frame = CGRect(x: 0, y: textField.frame.maxY + 4, width: frame.width, height: errorLabelHeight)
       }

       func textFieldDidBeginEditing(_ textField: UITextField) {
           errorMessage = nil
       }
   }
