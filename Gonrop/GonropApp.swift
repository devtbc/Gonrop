//
//  GonropApp.swift
//  Gonrop
//
//  Created by Tyler Stiffler on 1/27/25.
//

import SwiftUI

@Observable
@MainActor
class ClockService {
    var now: Date = .now
    private var task: Task<Void, Never>?
    
    init() {
        task = Task {
            for await tick in Self.makeTicker() {
                self.now = tick
            }
        }
    }
    //Issues with non isolated on mainActor
    //        deinit {
    //            task?.cancel()
    //        }
    
    private static func makeTicker() -> AsyncStream<Date> {
        AsyncStream { continuation in
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                continuation.yield(.now)
            }
            RunLoop.main.add(timer, forMode: .common)
            
            continuation.onTermination = { _ in
                timer.invalidate()
            }
        }
    }
}

@main
struct GonropApp: App {
    @State private var clockService = ClockService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(clockService)
        }
    }
}
