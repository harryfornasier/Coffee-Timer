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
            HStack(alignment: .center, spacing: 0) {
                Image("moka")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: .infinity)
                    .padding()
                    .overlay(
                        Rectangle()
                            .stroke(Color(red: 80/255, green: 80/255, blue: 80/255), lineWidth: 3)
                    )
                
                    .frame(height: 110)
                
                Text(formatTime(timerManager.timeRemaining))
                    .font(.system(size: 30, weight: .bold, design: .monospaced))
                    .frame(maxHeight: .infinity)
                    .padding()
                
                
                    .frame(height: 110)
                    .background(
                        Color(
                            red: 231/255.0,
                            green: 231/255.0,
                            blue: 231/255.0,
                            opacity: 1
                        )
                    )
                
            }
            .overlay(
                ZStack {
                    Rectangle()
                        .stroke(Color(red: 255/255, green: 255/255, blue: 255/255), lineWidth: 4)
                        .offset(x: -3, y: -3)
                    
                    Rectangle()
                        .stroke(Color(red: 80/255, green: 80/255, blue: 80/255), lineWidth: 4)
                        .offset(x: 3, y: 3)
                    
                    Rectangle()
                        .stroke(Color(red: 231/255, green: 231/255, blue: 231/255), lineWidth: 7)
                }
            )
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: 80)
            .padding()
            .background(
                Color(
                    red: 231/255.0,
                    green: 231/255.0,
                    blue: 231/255.0,
                    opacity: 1
                )
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
                .padding(.horizontal, 30)
                
                HStack(spacing: 15) {
                    Button(action: handleTimerAction) {
                        Text(timerManager.isTimerActive ? "Reset" : "Start")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(timerManager.isTimerActive ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(0)
                    }
                    .disabled(timerManager.time <= 0 && !timerManager.isTimerActive)
                    .overlay(
                        ZStack {
                            Rectangle()
                                .stroke(Color(red: 255/255, green: 255/255, blue: 255/255), lineWidth: 2)
                                .offset(x: -1, y: -1)
                            
                            Rectangle()
                                .stroke(Color(red: 80/255, green: 80/255, blue: 80/255), lineWidth: 2)
                                .offset(x: 1, y: 1)
                            
                            Rectangle()
                                .stroke(Color(red: 231/255, green: 231/255, blue: 231/255), lineWidth: 3)
                        }
                    )
                    
                    Button("Quit") {
                        NSApplication.shared.terminate(nil)
                    }
                    
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(0)
                    .overlay(
                        ZStack {
                            Rectangle()
                                .stroke(Color(red: 255/255, green: 255/255, blue: 255/255), lineWidth: 2)
                                .offset(x: -1, y: -1)
                            
                            Rectangle()
                                .stroke(Color(red: 80/255, green: 80/255, blue: 80/255), lineWidth: 2)
                                .offset(x: 1, y: 1)
                            
                            Rectangle()
                                .stroke(Color(red: 231/255, green: 231/255, blue: 231/255), lineWidth: 3)
                        }
                    )
                }
                
                .buttonStyle(.plain)
                .padding(.horizontal, 40)
            }
        }
        .padding(.vertical, 20)
        .background(
            Color(
                red: 231/255.0,
                green: 231/255.0,
                blue: 231/255.0,
                opacity: 1
            )
        )
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
        return String(format: "-%02d:%02d", minutes, remainingSeconds)
    }
}
#Preview {
    ContentView()
}
