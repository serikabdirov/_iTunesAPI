//
//  SignalFromPublishRelay.swift
//  Core
//
//  Created by Денис Кожухарь on 17.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxCocoa
import RxRelay

@propertyWrapper
public struct SignalFromPublishRelay<UnderlyingValue, Value> {
    // MARK: - Public properties

    public var wrappedValue: Signal<Value> {
        publishRelay.asSignal().apply(transform)
    }

    public var projectedValue: PublishRelay<UnderlyingValue> { publishRelay }

    // MARK: - Private properties

    private let publishRelay: PublishRelay<UnderlyingValue>
    private let transform: (Signal<UnderlyingValue>) -> Signal<Value>

//    public init() where Value == UnderlyingValue {
//        self.publishRelay = PublishRelay()
//        self.transform = { $0 }
//    }

    public init(transform: @escaping (Signal<UnderlyingValue>) -> Signal<Value>) {
        self.publishRelay = PublishRelay()
        self.transform = transform
    }
}

public extension SignalFromPublishRelay where UnderlyingValue == Value {
    init() {
        self.publishRelay = PublishRelay()
        self.transform = { $0 }
    }
}
