//
//  TimerCountManage.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/09/24.
//

import Foundation
import UIKit

protocol TimerDelegate: AnyObject {
    func timerDidFinish()
}

class TimerForCancelItem {
    weak var delegate: TimerDelegate?
    private var timer: Timer?
    private var secondsRemaining: Int = 0
    private weak var timerLabel: UILabel?
    
    init(timeString: String, label: UILabel) {
        // Parse the "00:54 Hrs." format to extract hours and minutes
        let timeComponents = timeString.replacingOccurrences(of: " Hrs.", with: "").split(separator: ":")
        if timeComponents.count == 2,
           let hours = Int(timeComponents[0]),
           let minutes = Int(timeComponents[1]) {
            self.secondsRemaining = (hours * 3600) + (minutes * 60)
        }
        self.timerLabel = label
    }
    
    func startTimer() {
        updateLabel() // Immediately show initial time on the label
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            updateLabel()
        } else {
            timer?.invalidate()
            delegate?.timerDidFinish()
        }
    }
    
    private func updateLabel() {
        let hours = secondsRemaining / 3600
        let minutes = (secondsRemaining % 3600) / 60
        let seconds = secondsRemaining % 60
        timerLabel?.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
