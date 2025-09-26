//
//  CoffeeRunTimerView.swift
//  iosApp2
//
//  Created by Satoof Haj  on 2025-09-26.
//

import SwiftUI

struct CoffeeRunTimerView: View {
    @State private var timeRemaining = 60
    @State private var isRunning = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Coffee Run Timer")
                .font(.largeTitle)
                .bold()
            
            Text("\(timeRemaining) seconds left")
                .font(.title)
                .foregroundColor(.timsBrown)
            
            HStack(spacing: 20) {
                Button(action: startTimer) {
                    Text("Start Run")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.timsBrown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: resetTimer) {
                    Text("Reset")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.timsCream)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
    
    // Start countdown
    func startTimer() {
        if !isRunning {
            isRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    t.invalidate()
                    isRunning = false
                }
            }
        }
    }
    
    // Reset timer
    func resetTimer() {
        timer?.invalidate()
        timeRemaining = 60
        isRunning = false
    }
}

#Preview {
    CoffeeRunTimerView()
}

