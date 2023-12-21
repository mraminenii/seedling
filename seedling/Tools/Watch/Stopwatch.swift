//
//  Stopwatch.swift
//  Seedling
//
//  Created by Wai Shuen Wu on 11/16/22.
//

import Foundation
import SwiftUI

//Create a new stopwatch object using the ObservedObject tag by doing @ObservedObject var timer = stopwatch()
class stopwatch: ObservableObject {
    @Published var secondsElapsed = 0.0
    var timer = Timer()
    
    /*
     Starts the timer, incrementing it every 0.01 seconds.
     */
    func startWatch() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.secondsElapsed += 0.01
                }
    }
    
    /*
     Pauses the timer.
     */
    func pauseWatch() {
        timer.invalidate()
    }
    
    /*
     Ends the timer. The time is reset.
     */
    func endWatch() {
        timer.invalidate()
        self.secondsElapsed = 0.0
    }
    
    /*
     Returns a string of the time in HH:MM:SS:mm format.
     */
    func displayTime() -> String {
        let hours = Int(secondsElapsed / 3600)
        let minutes = (Int(secondsElapsed) % 3600) / 60
        let seconds = (Int(secondsElapsed) % 3600) % 60
        let miliseconds = Int(secondsElapsed.truncatingRemainder(dividingBy: 1) * 100)
        return (String(format: "%02d", hours) + ":" +
                String(format: "%02d", minutes) + ":" +
                String(format: "%02d", seconds) + ":" +
                String(format: "%02d", miliseconds))
    }
    
    /*
     Returns the time in seconds.
     */
    func returnSeconds() -> Double {
        return secondsElapsed
    }
}
