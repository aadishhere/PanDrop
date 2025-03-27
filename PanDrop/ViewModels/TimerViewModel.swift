//
//  TimerViewModel.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var timerModel = TimerModel() {
        didSet {
            recalculateTimeRemaining()
        }
    }
    @Published var timeRemaining: Int = 0
    @Published var isTimerRunning: Bool = false
    @Published var sessionComplete: Bool = false
    
    private var timer: Timer?
    
    init() {
        recalculateTimeRemaining()
    }
    
    // Progress (0.0 to 1.0)
    var progress: CGFloat {
        let totalDuration = timerModel.isWorkSession ? timerModel.workDuration * 60 : timerModel.shortBreakDuration * 60
        guard totalDuration > 0 else { return 0 }
        return 1 - (CGFloat(timeRemaining) / CGFloat(totalDuration)) // Invert for fill-from-bottom
    }
    
    func startTimer() {
        if !isTimerRunning {
            isTimerRunning = true
            sessionComplete = false
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timerCompleted()
                }
            }
        }
    }
    
    func pauseTimer() {
        isTimerRunning = false
        timer?.invalidate()
    }
    
    func resetTimer() {
        isTimerRunning = false
        timer?.invalidate()
        recalculateTimeRemaining()
    }
    
    func timerCompleted() {
        isTimerRunning = false
        timer?.invalidate()
        sessionComplete = true
        
        if timerModel.isWorkSession {
            timerModel.sessionsCompleted += 1
        }
        
        // Switch between work and break sessions
        timerModel.isWorkSession.toggle()
        recalculateTimeRemaining()
        
        // Announce session change
        announceSessionChange()
    }
    
    private func announceSessionChange() {
        if !timerModel.isWorkSession {
            // Work session completed
            let message = "Great job! Take a break for \(timerModel.shortBreakDuration) minutes. Relax and recharge!"
            SoundManager.shared.speak(text: message)
        } else {
            // Break session completed
            if timerModel.sessionsCompleted % 4 == 0 {
                // Long break message
                let message = "Time for a long break! Now you can have a coffee, call your mom, or just relax for \(timerModel.longBreakDuration) minutes."
                SoundManager.shared.speak(text: message)
            } else {
                // Short break message
                let message = "Break time is over. Get back to work for \(timerModel.workDuration) minutes. You've got this!"
                SoundManager.shared.speak(text: message)
            }
        }
    }
    
    func recalculateTimeRemaining() {
        timeRemaining = timerModel.isWorkSession ? timerModel.workDuration * 60 : timerModel.shortBreakDuration * 60
    }
}
