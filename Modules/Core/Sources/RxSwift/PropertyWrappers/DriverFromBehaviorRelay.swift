//
//  DriverFromBehaviorRelay.swift
//  Core
//
//  Created by Денис Кожухарь on 17.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxCocoa
import RxRelay

@propertyWrapper
public struct DriverFromBehaviorRelay<UnderlyingValue, Value> {
    // MARK: - Public properties

    public var wrappedValue: Driver<Value> {
        behaviorRelay.asDriver().apply(transform)
    }

    public var projectedValue: BehaviorRelay<UnderlyingValue> { behaviorRelay }

    // MARK: - Private properties

    private let behaviorRelay: BehaviorRelay<UnderlyingValue>
    private let transform: (Driver<UnderlyingValue>) -> Driver<Value>

    public init(defaultValue: Value) where UnderlyingValue == Value {
        self.behaviorRelay = BehaviorRelay(value: defaultValue)
        self.transform = { $0 }
    }

    public init(defaultValue: UnderlyingValue, transform: @escaping (Driver<UnderlyingValue>) -> Driver<Value>) {
        self.behaviorRelay = BehaviorRelay(value: defaultValue)
        self.transform = transform
    }
}
