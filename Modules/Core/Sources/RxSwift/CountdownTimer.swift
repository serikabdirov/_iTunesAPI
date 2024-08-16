//
//  CountdownTimer.swift
//
//  Created by Денис Кожухарь on 15.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

public final class CountdownTimer {
    // MARK: - Public properties

    public var timeSignal = PublishRelay<Int>()
    public var completedSignal = PublishRelay<Bool>()

    public private(set) var isStarted = false {
        didSet {
            completedSignal.accept(!isStarted)
        }
    }

    // MARK: - Private properties

    private let timeStep: Double
    private let timeInterval: Int
    private var startDate = Date()
    private var timer: Timer?

    // MARK: - Init

    public init(timeInterval: Int, timeStep: Double = 1) {
        self.timeInterval = timeInterval
        self.timeStep = timeStep
    }

    // MARK: - Public methods

    public func start() {
        isStarted = true
        timeSignal.accept(timeInterval)
        timer?.invalidate()
        startDate = Date()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(
                timeInterval: self.timeStep,
                target: self,
                selector: #selector(self.timerTick),
                userInfo: nil,
                repeats: true
            )
        }
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
        isStarted = false
    }

    // MARK: - Private methods

    @objc
    private func timerTick() {
        let date = Date()
        let time = timeInterval - Int(round(date.timeIntervalSince(startDate)))
        if time > 0 {
            timeSignal.accept(time)
        } else {
            timeSignal.accept(0)
            stop()
        }
    }
}
