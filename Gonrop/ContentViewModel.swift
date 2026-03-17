//
//  ContentViewModel.swift
//  Gonrop
//
//  Created by Tyler Stiffler on 2/24/26.
//

import SwiftUI
import Combine


    @Observable
    class ViewModel {
        var tmpTimeRem = 42//934
        var sumNumofTimerRunning : Bool = false
        var sumNumofTimerRemaining : Int = 0
        
        var timer: Publishers.Autoconnect<Timer.TimerPublisher>
        
        var timerVM1 : TimerViewModel = TimerViewModel(isRunning: false, timeRemaining: 42)
        
        init(){
            timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
            
//            func stopTimer() {
//                self.timer.upstream.connect().cancel()
//            }
//            
            func startTimer() {
                sumNumofTimerRemaining = 120
                sumNumofTimerRunning = true
            }
            func stopTimer() {
               // sumNumofTimerRemaining = 120
                sumNumofTimerRunning = false
            }
            func addSomeTime() {
                sumNumofTimerRemaining += 240
            }
        }
    }
    

    @Observable
    class TimerViewModel {
        var isRunning: Bool
        var timeRemaining: Int
        
        var endDate: Date?
        
        init(isRunning: Bool, timeRemaining: Int) {
            self.isRunning = isRunning
            self.timeRemaining = timeRemaining
        }
        func start() {
            isRunning = true
        }
        func stop() {
            isRunning = false
        }
        
    }


#Preview {
    ContentView()
}
