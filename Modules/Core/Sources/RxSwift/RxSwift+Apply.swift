//
//  RxSwift+Apply.swift
//  Core
//
//  Created by Денис Кожухарь on 17.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxCocoa
import RxSwift

public extension ObservableType {
    func apply<T: ObservableType>(_ transform: (Self) -> T) -> T {
        transform(self)
    }

    func apply<T: ObservableConvertibleType>(_ transform: (Self) -> T) -> T {
        transform(self)
    }
}

public extension SharedSequence {
    func apply<T: ObservableType>(_ transform: (Self) -> T) -> T {
        transform(self)
    }

    func apply<T: ObservableConvertibleType>(_ transform: (Self) -> T) -> T {
        transform(self)
    }
}
