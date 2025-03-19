//
//  TimerManager.swift
//  Coffee Timer
//
//  Created by Harrison Fornasier on 19/03/2025.
//

import Foundation
import Combine

class TimerManager: ObservableObject {
    @Published var time = 0.0
    @Published var timeRemaining = 0
    @Published var isTimerActive = false
    private var timer: AnyCancellable?
    
    init() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    func startTimer() {
        timeRemaining = Int(time)
        isTimerActive = true
    }
    
    func resetTimer() {
        isTimerActive = false
        timeRemaining = 0
        time = 0
    }
    
    private func updateTimer() {
        guard isTimerActive else { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            isTimerActive = false
        }
    }
}
