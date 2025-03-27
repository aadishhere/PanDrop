//
//  SessionCompleteView.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import SwiftUI

struct SessionCompleteView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.timerModel.isWorkSession ? "Time for a Break!" : "Back to Work!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Button(action: {
                viewModel.sessionComplete = false
                viewModel.startTimer()
            }) {
                Text("Next Session")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.black.opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
