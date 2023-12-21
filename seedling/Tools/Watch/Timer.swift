//
//  Timer.swift
//  Seedling
//
//  Created by Wai Shuen Wu on 11/16/22.
//

import Foundation
import SwiftUI

class countdownTimer: ObservableObject {
    @Published var secsRemaining = 0.0
    @Published var timerRunning = true
    
    var timer = Timer()
    var hours = 0.0
    var minutes = 0.0
    var seconds = 0.0
    
    /*
     Create a new stopwatch by giving it the specified hours, minutes, and seconds
     */
    init (hours: Double, minutes: Double, seconds: Double) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        secsRemaining = (hours * 3600) + (minutes * 60) + seconds
    }
    
    /*
     Starts the timer. Does not run if time remaining is 0.
     */
    func startTimer() {
        self.timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if (self.secsRemaining > 0.0) {
                self.secsRemaining -= 0.01
            } else {
                self.timerRunning = false
                timer.invalidate()
            }
        }
    }
    
    /*
     Pauses the timer.
     */
    func pauseTimer() {
        timer.invalidate()
    }
    
    /*
     Resets the timer. The time remaining is reset.
     */
    func resetTimer() {
        timer.invalidate()
        secsRemaining = (hours * 3600) + (minutes * 60) + seconds
    }
    
    /*
     Returns a string of the timer remaining in HH:MM:SS:mm format.
     */
    func displayTimer()-> String {
        let hours = Int(secsRemaining / 3600)
        let minutes = (Int(secsRemaining) % 3600) / 60
        let seconds = (Int(secsRemaining) % 3600) % 60
        let miliseconds = Int(secsRemaining.truncatingRemainder(dividingBy: 1) * 100)
        return (String(format: "%02d", hours) + ":" +
                String(format: "%02d", minutes) + ":" +
                String(format: "%02d", seconds) + ":" +
                String(format: "%02d", miliseconds))
    }
    
    /*
     Returns true when the timer ends.
     */
    func timerOver() -> Bool {
        return !(timerRunning)
    }
}
