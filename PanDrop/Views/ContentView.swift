//
//  ContentView.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TimerViewModel
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Full-Screen Water Wave
                WaterWaveView(progress: viewModel.progress)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Timer Display
                    Text("\(viewModel.timeRemaining / 60):\(String(format: "%02d", viewModel.timeRemaining % 60))")
                        .font(.system(size: horizontalSizeClass == .compact ? 80 : 120, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    // Session Type
                    Text(viewModel.timerModel.isWorkSession ? "Work Session" : "Break Session")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    // Timer Controls
                    HStack(spacing: 20) {
                        Button(action: {
                            HapticManager.shared.triggerImpact(style: .medium)
                            viewModel.startTimer()
                        }) {
                            Image(systemName: "play.fill")
                                .font(.title)
                                .padding()
                                .background(Circle().fill(Color.white.opacity(0.2)))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            HapticManager.shared.triggerImpact(style: .medium)
                            viewModel.pauseTimer()
                        }) {
                            Image(systemName: "pause.fill")
                                .font(.title)
                                .padding()
                                .background(Circle().fill(Color.white.opacity(0.2)))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            HapticManager.shared.triggerImpact(style: .medium)
                            viewModel.resetTimer()
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.title)
                                .padding()
                                .background(Circle().fill(Color.white.opacity(0.2)))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .onAppear {
            // Prevent screen sleep
            UIApplication.shared.isIdleTimerDisabled = true
            // Configure audio session
            SoundManager.shared.configureAudioSession()
        }
        .onDisappear {
            // Re-enable screen sleep
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .onChange(of: scenePhase) { newPhase in
            // Handle app lifecycle changes
            switch newPhase {
            case .active:
                UIApplication.shared.isIdleTimerDisabled = true
                SoundManager.shared.configureAudioSession()
            case .inactive, .background:
                UIApplication.shared.isIdleTimerDisabled = false
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    ContentView(viewModel: TimerViewModel()) // Provide the ViewModel here
}
