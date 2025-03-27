//
//  HapticManager.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import UIKit

class HapticManager {
    static let shared = HapticManager()
    
    func triggerImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
