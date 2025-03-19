//
//  ContentView.swift
//  Coffee Timer
//
//  Created by Harrison Fornasier on 17/03/2025.
//

import SwiftUI



struct ContentView: View {
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                Image("moka")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: .infinity)
                    .padding()
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(height: 90)
                
                Text(formatTime(timerManager.timeRemaining))
                    .font(.system(size: 40, weight: .bold, design: .monospaced))
                    .frame(maxHeight: .infinity)
                    .padding()
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(height: 90)
                
            }
            .fixedSize(horizontal: false, vertical: true) // Critical for equal heights
            .frame(height: 80)
            .padding()
            .background(Color.white)
            .overlay(
                Rectangle()
                    .stroke(Color.black, lineWidth: 3)
            )
            
            
                        VStack(spacing: 5) {
                            VStack {
                                Slider(
                                    value: $timerManager.time,
                                    in: 0...1200,
                                    step: 300
                                ) {
                                    Text("Time")
                                } minimumValueLabel: {
                                    Text("0:00")
                                        .font(.caption)
                                } maximumValueLabel: {
                                    Text("20:00")
                                        .font(.caption)
                                }
                                .disabled(timerManager.isTimerActive)
                                .padding(.horizontal, 10)
                            }
                            .padding(.horizontal, 20)
                            
                            HStack(spacing: 15) {
                                Button(action: handleTimerAction) {
                                    Text(timerManager.isTimerActive ? "Reset" : "Start")
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 8)
                                        .background(timerManager.isTimerActive ? Color.red : Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(6)
                                }
                                
                                Button("Quit") {
                                    NSApplication.shared.terminate(nil)
                                }
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                    .padding(.vertical, 20)
                    .frame(width: 350)
                }
    
    private func handleTimerAction() {
        if timerManager.isTimerActive {
            timerManager.resetTimer()
        } else {
            timerManager.startTimer()
        }
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "-%d:%02d", minutes, remainingSeconds)
    }
}
#Preview {
    ContentView()
}
