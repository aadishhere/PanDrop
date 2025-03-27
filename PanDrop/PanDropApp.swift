//
//  PanDropApp.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import SwiftUI

@main
struct PanDropApp: App {
    @StateObject private var viewModel = TimerViewModel() // Create the ViewModel here

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(viewModel: viewModel) // Pass the ViewModel to ContentView
                    .navigationBarItems(trailing: NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                        Image(systemName: "gear")
                            .font(.title2)
                    })
            }
        }
    }
}

