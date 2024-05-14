//
//  ActivityIndigatorView.swift
//  DiamondXE
//
//  Created by iOS Developer on 19/04/24.
//

import Foundation
import UIKit


class CustomActivityIndicator {
    static let shared = CustomActivityIndicator()
    
    private var activityIndicator: UIActivityIndicatorView!
    private var container: UIView!
    
    private init() {}
    
    func show(in view: UIView) {
        container = UIView(frame: view.bounds)
        container.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(named: "whitClr")
        activityIndicator.center = container.center
        container.addSubview(activityIndicator)
        
        view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
}
