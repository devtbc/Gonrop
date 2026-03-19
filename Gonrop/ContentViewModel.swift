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
        
        var timerVM1 : TimerViewModel = TimerViewModel(isRunning: true, timeRemaining: 420)
        
        init(){
            timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
            timerVM1.bind(to: timer)

        }
        func startTimer() {
            
        }
        func stopTimer() {
           
        }
        func addSomeTime() {
            sumNumofTimerRemaining += 240
        }
        
        func timerVMBind() {
            timerVM1.bind(to: timer)
        }
    }
    

    @Observable
class TimerViewModel {
    var isRunning: Bool
    var timeRemaining: Int
    private var cancellable: AnyCancellable?
    var targetTime = Date.now.addingTimeInterval(0)
    var endDate: Date?
    
    //timeRemaining = savedTimeRemaining -[currentTime timeIntervalSinceDate:savedDate];
    
            
    init () {
        isRunning = false
        timeRemaining = 420//watch for bugs with targetTime
            }
    init(isRunning: Bool, timeRemaining: Int) {
        self.isRunning = isRunning
        self.timeRemaining = timeRemaining
        targetTime = Date.now.addingTimeInterval(TimeInterval(timeRemaining))
    }
    
    func bind(to publisher: some Publisher<Date, Never>) {
        cancellable = publisher.sink { [self] dateOfTick in
            if isRunning {
                timeRemaining = Int(dateOfTick.distance(to: targetTime))
            }
        }
    }
    
    //These are going to live in the parent VM for the moment.
        //Since I only have on and don't know about---- maybe nvm
    func start() {
        if timeRemaining <= 0 { return }
        targetTime = Date.now.addingTimeInterval(TimeInterval(timeRemaining))
        isRunning = true
    }
    func stop() {
        isRunning = false
        timeRemaining = Int(Date.now.distance(to: targetTime))
        //isRunning = false
        //keep the remaind time and cancel thhe sink binding
    }
    func addTime(_ seconds: Int) {
        targetTime = targetTime.advanced(by: TimeInterval(seconds))
        //timeRemaining += seconds
    }
}


#Preview {
    ContentView()
}
