//
//  TimerManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/04/24.
//

import Foundation
import UIKit

class TimerManager {
    static let shared = TimerManager()
    
    private var timer: Timer?
    private var countdownDuration: TimeInterval = 30
    private var timeRemaining: TimeInterval = 30
    private var updateInterval: TimeInterval = 1 // Update interval in seconds
    
    private var countdownLabel: UILabel?
    private var completion: (() -> Void)?
    
    private init() {}
    
    func startTimer(withLabel label: UILabel, completion: (() -> Void)?) {
        stopTimer() // Stop any existing timer
        
        timeRemaining = countdownDuration
        countdownLabel = label
        self.completion = completion
        
        // Update UI immediately
        updateLabel()
        
        // Start the timer
        timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        timeRemaining -= updateInterval
        
        if timeRemaining <= 0 {
            stopTimer()
            completion?() // Trigger completion handler
        }
        
        updateLabel()
    }
    
    private func updateLabel() {
        guard let label = countdownLabel else {
            return
        }
        
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        label.text = String(format: "%02d:%02d", minutes, seconds)
    }
}
