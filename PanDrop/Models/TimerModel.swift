//
//  TimerModel.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import Foundation

struct TimerModel {
    var workDuration: Int = 25 // Default work duration in minutes
    var shortBreakDuration: Int = 5 // Default short break duration in minutes
    var longBreakDuration: Int = 15 // Default long break duration in minutes
    var sessionsCompleted: Int = 0 // Number of completed work sessions
    var isWorkSession: Bool = true // Tracks if the current session is work or break
}
