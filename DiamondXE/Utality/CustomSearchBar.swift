//
//  CustomSearchBar.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/04/24.
//

import Foundation
import UIKit

protocol CustomSearchBarDelegate: AnyObject {
    func didChangeSearchText(_ searchText: String)
}

class CustomSearchBar: UIView, UITextFieldDelegate {
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    weak var delegate: CustomSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.didChangeSearchText(textField.text ?? "")
    }
}
