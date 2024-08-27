//
//  SwipeGestureUtility.swift
//  DiamondXE
//
//  Created by iOS Developer on 12/08/24.
//

import Foundation
import UIKit
class SwipeGestureUtility {

    static func addSwipeGesture(to view: UIView, navigationController: UINavigationController?) {
        // Swipe right gesture recognizer
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeRightGesture)

        // Swipe left gesture recognizer
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeftGesture.direction = .left
        view.addGestureRecognizer(swipeLeftGesture)
    }

    @objc static func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        guard let view = gesture.view, let navigationController = (view.next as? UIViewController)?.navigationController else {
            return
        }

        if gesture.direction == .right {
            navigationController.popViewController(animated: true)
        } else if gesture.direction == .left {
            // Handle left swipe if needed
        }
    }
}
