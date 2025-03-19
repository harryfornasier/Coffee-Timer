//
//  TimerManager.swift
//  Coffee Timer
//
//  Created by Harrison Fornasier on 19/03/2025.
//

import Foundation
import Combine
import AppKit


class TimerManager: ObservableObject {
    @Published var time = 0.0 {
            didSet {
                if !isTimerActive {
                    timeRemaining = Int(time)
                }
            }
        }
    
    @Published var timeRemaining = 0
    @Published var isTimerActive = false
    private var timer: AnyCancellable?
    private var originalTime: Int = 0
    private var sound: NSSound?
    
    init() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    func startTimer() {
        playStartSound()
        originalTime = Int(time)
        timeRemaining = originalTime
        isTimerActive = true
    }
    
    func resetTimer() {
        isTimerActive = false
        timeRemaining = originalTime
    }
    
    private func updateTimer() {
        guard isTimerActive else { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            isTimerActive = false
            playCompletionSound()
        }
    }
    
    private func playCompletionSound() {
        sound?.stop()
        
        // Load and play new sound
        guard let path = Bundle.main.path(forResource: "ding", ofType: "wav") else {
            print("Sound file not found")
            return
        }
        sound = NSSound(contentsOfFile: path, byReference: false)
        sound?.play()
    }
    
    private func playStartSound() {
        sound?.stop()
        
        // Load and play new sound
        guard let path = Bundle.main.path(forResource: "start", ofType: "wav") else {
            print("Sound file not found")
            return
        }
        sound = NSSound(contentsOfFile: path, byReference: false)
        sound?.play()
    }
}
