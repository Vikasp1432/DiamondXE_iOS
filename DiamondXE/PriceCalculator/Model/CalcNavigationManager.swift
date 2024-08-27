//
//  CalcNavigationManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/08/24.
//

import Foundation
import UIKit

class CalcNavigationManager {
    
    static let shared = CalcNavigationManager()
    private init() {}
    
    func pushViewController(_ viewController: UIViewController, from sourceViewController: UIViewController, animated: Bool = true) {
        sourceViewController.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(from viewController: UIViewController, animated: Bool = true) {
        viewController.navigationController?.popViewController(animated: animated)
    }
    
    func presentModalViewController(_ viewController: UIViewController, from sourceViewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        sourceViewController.present(viewController, animated: animated, completion: completion)
    }
    
    func dismissModalViewController(from viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.dismiss(animated: animated, completion: completion)
    }
}
