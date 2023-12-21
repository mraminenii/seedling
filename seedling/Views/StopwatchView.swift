//
//  TimerView.swift
//  Seedling
//
//  Created by Brian Q on 11/28/22.
//
import Foundation
import SwiftUI


struct StopwatchView: View {
    @State private var showExercise = true
    @State var start = false
    @State var tempTimerName: String = ""
    @State var timerList = [workouts]()
    @FocusState var focused: Bool
    
    @State var isTimerRunning = false
        @State private var startTime =  Date()
        @State private var timerString = "0.00"
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @ObservedObject var stopWatchManager = StopWatchManager()

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color(red: 0.6706, green: 0.8392, blue: 0.5765))
                .frame(width: 400, height: 100)
                .padding(.bottom, 100)
            Text("Stopwatch")
                .font(.system(size:55))
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            SeedlingImage()
            
            //setting up timer to run from 0.00 upwards until tapped, resets when tapped again
//            Text(self.timerString)
//                .font(Font.system(.largeTitle, design: .monospaced))
//                .onReceive(timer) { _ in
//                    if self.isTimerRunning {
//                        timerString = String(format: "%.2f", (Date().timeIntervalSince(self.startTime)))
//                    }
//                }
            Text(String(format: "%.2f", stopWatchManager.secondsElapsed))
                .font(Font.system(.largeTitle, design: .monospaced))
            //start and stop buttons to control timer
            HStack {
                if stopWatchManager.mode == .stopped {
                    Button(action: {self.stopWatchManager.start()}) {
                        TimerButton(label: "Start")
                    }
                    .padding()
                    Button(action: {self.stopWatchManager.stop()}) {
                        TimerButton(label: "Stop")
                    }
                    .padding()
                }
                if stopWatchManager.mode == .running {
                    Button(action: {self.stopWatchManager.pause()}) {
                        TimerButton(label: "Pause")
                    }
                    .padding()
                    Button(action: {self.stopWatchManager.stop()}) {
                        TimerButton(label: "Stop")
                    }
                    .padding()
                }
                if stopWatchManager.mode == .paused {
                    Button(action: {self.stopWatchManager.start()}) {
                        TimerButton(label: "Start")
                    }
                    .padding()
                    Button(action: {self.stopWatchManager.stop()}) {
                        TimerButton(label: "Stop")
                    }
                    .padding()
                }
//                StartPause()
//                    .onTapGesture {
////                        isTimerRunning.toggle()
//                        if !isTimerRunning {
//                            self.stopWatchManager.start()
//                            isTimerRunning.toggle()
//                        } else {
//                            self.stopWatchManager.pause()
//                            isTimerRunning.toggle()
//                        }
//                    }
//                ResetButton()
//                    .onTapGesture {
//                        self.stopWatchManager.stop()
//                        if isTimerRunning {
////                            timerString = "0.00"
////                            startTime = Date()
////                            isTimerRunning.toggle()
//                            isTimerRunning.toggle()
//                        }
//                    }
            }
            .padding()
        }
        .padding(.bottom, 220)
    }
}


struct StopwatchPreviews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}

struct ResetButton : View {
    var body: some View {
        return Text("RESET")
            .font(.title)
            .foregroundColor(.black)
            .padding()
            .background(Color(red: 0.90, green: 0.90, blue: 0.90))
            .cornerRadius(10.0)
    }
}

struct StartPause : View {
    var body: some View {
        return Text("START")
            .font(.title)
            .foregroundColor(.black)
            .padding()
            .background(Color(red: 0.90, green: 0.90, blue: 0.90))
            .cornerRadius(10.0)
    }
}

struct SeedlingImage : View {
    var body: some View {
        return Image("SeedlingImage")
            .resizable()
            .scaledToFit()
            .frame(width: 150.0, height: 150.0)
            .padding(.bottom, 10)
    }
}

enum stopWatchMode {
    case running
    case stopped
    case paused
}

class StopWatchManager: ObservableObject {
    
    @Published var mode: stopWatchMode = .stopped
    @Published var secondsElapsed = 0.0
    
    var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.secondsElapsed = self.secondsElapsed + 0.01
        }
    }
    
    func pause() {
        timer.invalidate()
        mode = .paused
    }
    
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
    
}

struct TimerButton: View {
    
    let label: String
    
    var body: some View {
        Text(label)
            .font(.title)
            .foregroundColor(.black)
            .padding()
            .background(Color(red: 0.90, green: 0.90, blue: 0.90))
            .cornerRadius(10.0)
    }
}
