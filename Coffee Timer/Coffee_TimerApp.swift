//
//  Coffee_TimerApp.swift
//  Coffee Timer
//
//  Created by Harrison Fornasier on 17/03/2025.
//

import SwiftUI

@main
struct Coffee_TimerApp: App {
    @StateObject private var timerManager = TimerManager()
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
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

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        if let window = NSApp.windows.first {
            window.styleMask.remove(.resizable)
            window.styleMask.remove(.closable)
            window.styleMask.remove(.miniaturizable)
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
}
