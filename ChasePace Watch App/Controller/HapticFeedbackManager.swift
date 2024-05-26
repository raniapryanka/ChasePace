//
//  HapticFeedbackManager.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 25/05/24.
//

import Foundation
import WatchKit
import Foundation

class HapticFeedbackManager {
    
    static let shared = HapticFeedbackManager()
    private var hapticTimer: Timer?

    func startContinuousHapticFeedback() {
        stopHapticFeedback()
        hapticTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            WKInterfaceDevice.current().play(.notification)
        }
    }
    
    func stopHapticFeedback() {
        hapticTimer?.invalidate()
        hapticTimer = nil
    }
    
    func playEndHapticFeedback() {
        WKInterfaceDevice.current().play(.success)
    }
}
