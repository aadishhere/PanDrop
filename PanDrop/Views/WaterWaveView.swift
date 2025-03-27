//
//  WaterAnimationView.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.

import SwiftUI

struct WaterWaveView: View {
    var progress: CGFloat // 0.0 (empty) to 1.0 (full)
    @State private var waveOffset = Angle(degrees: 0)
    @State private var wavePhase: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Water Wave
                WaveShape(progress: progress, waveOffset: waveOffset, wavePhase: wavePhase)
                    .fill(Constants.primaryColor.opacity(0.6))
                    .overlay(
                        // Subtle wave effect
                        WaveShape(progress: progress, waveOffset: waveOffset + Angle(degrees: 30), wavePhase: wavePhase + 0.5)
                            .fill(Constants.primaryColor.opacity(0.4))
                            .blendMode(.softLight)
                    )
                    .onAppear {
                        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                            self.waveOffset = Angle(degrees: 360)
                        }
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                            self.wavePhase = 1
                        }
                    }
            }
        }
    }
}

struct WaveShape: Shape {
    var progress: CGFloat
    var waveOffset: Angle
    var wavePhase: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight = rect.height / 20
        let yOffset = rect.height * (1 - progress) // Fill from bottom
        
        path.move(to: CGPoint(x: 0, y: yOffset))
        
        for x in stride(from: 0, through: rect.width, by: 10) {
            let angle = CGFloat(x) / rect.width * CGFloat(360) + CGFloat(waveOffset.degrees) + wavePhase * 360
            let y = yOffset + CGFloat(sin(angle * .pi / 180)) * waveHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}
