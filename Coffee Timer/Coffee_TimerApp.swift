//
//  Coffee_TimerApp.swift
//  Coffee Timer
//
//  Created by Harrison Fornasier on 17/03/2025.
//

import SwiftUI

@main
struct Coffee_TimerApp: App {
    @StateObject private var timerManager = TimerManager() // Add this
    
    var body: some Scene {
        MenuBarExtra {
            ContentView()
                .environmentObject(timerManager)
                .frame(width: 300, height: 200)
        } label: {
            Image(systemName: timerManager.isTimerActive ? "mug.fill" : "mug")
                .foregroundColor(timerManager.isTimerActive ? .blue : .primary)
        }
        .menuBarExtraStyle(.window)
    }
}
