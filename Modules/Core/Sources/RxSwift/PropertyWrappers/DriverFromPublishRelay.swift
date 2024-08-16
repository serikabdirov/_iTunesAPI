//
//  DriverFromPublishRelay.swift
//  Core
//
//  Created by Денис Кожухарь on 17.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxCocoa
import RxRelay

@propertyWrapper
public struct DriverFromPublishRelay<UnderlyingValue, Value> {
    // MARK: - Public properties

    public var wrappedValue: Driver<Value> {
        publishRelay.asDriver(onErrorDriveWith: .never()).apply(transform)
    }

    public var projectedValue: PublishRelay<UnderlyingValue> { publishRelay }

    // MARK: - Private properties

    private let publishRelay: PublishRelay<UnderlyingValue>
    private let transform: (Driver<UnderlyingValue>) -> Driver<Value>

    public init() where UnderlyingValue == Value {
        self.publishRelay = PublishRelay()
        self.transform = { $0 }
    }

    public init(transform: @escaping (Driver<UnderlyingValue>) -> Driver<Value>) {
        self.publishRelay = PublishRelay()
        self.transform = transform
    }
}
