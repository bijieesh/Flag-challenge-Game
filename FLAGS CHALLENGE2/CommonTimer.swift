//
//  timer.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 24/06/25.
//

import Foundation
import Combine

class CommonTimer: ObservableObject {
    @Published var remainingTime: Int
    private var duration: Int
    private var timer: Timer?
    private var isRunning = false
    private var onComplete: (() -> Void)?
    
    init(duration: Int, onComplete: (() -> Void)? = nil) {
        self.duration = duration
        self.remainingTime = duration
        self.onComplete = onComplete
    }
    
    func start() {
        guard !isRunning else { return }
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.tick()
        }
    }
    
    func pause() {
        timer?.invalidate()
        isRunning = false
    }
    
    func reset() {
        timer?.invalidate()
        isRunning = false
        remainingTime = duration
    }

    func restart() {
        reset()
        start()
    }

    private func tick() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            timer?.invalidate()
            isRunning = false
            onComplete?()
        }
    }
}
