//
//  ProgressIndicatorView.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import SwiftUI

struct ProgressIndicatorView: View {
    var sessionsCompleted: Int
    
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                Circle()
                    .fill(index < sessionsCompleted ? Constants.accentColor : Color.gray.opacity(0.3))
                    .frame(width: 10, height: 10)
            }
        }
    }
}
