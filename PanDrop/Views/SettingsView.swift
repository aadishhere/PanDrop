//
//  SettingsView.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Timer Settings")) {
                Stepper("Work Duration: \(viewModel.timerModel.workDuration) minutes", value: $viewModel.timerModel.workDuration, in: 1...60)
                    .onChange(of: viewModel.timerModel.workDuration) { _ in
                        viewModel.resetTimer() // Call resetTimer() instead
                    }
                
                Stepper("Short Break: \(viewModel.timerModel.shortBreakDuration) minutes", value: $viewModel.timerModel.shortBreakDuration, in: 1...30)
                    .onChange(of: viewModel.timerModel.shortBreakDuration) { _ in
                        viewModel.resetTimer() // Call resetTimer() instead
                    }
                
                Stepper("Long Break: \(viewModel.timerModel.longBreakDuration) minutes", value: $viewModel.timerModel.longBreakDuration, in: 1...60)
                    .onChange(of: viewModel.timerModel.longBreakDuration) { _ in
                        viewModel.resetTimer() // Call resetTimer() instead
                    }
            }
        }
        .navigationTitle("Settings")
    }
}
