//
//  RxSwift+TrackingState.swift
//
//  Created by Денис Кожухарь on 30.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxRelay
import RxSwift

public protocol RelayType {
    associatedtype Element
    func accept(_ event: Element)
}

extension BehaviorRelay: RelayType {}
extension PublishRelay: RelayType {}

public extension ObservableType {
    func trackState<R: RelayType>(
        using relay: R
    ) -> Observable<Element> where R.Element == Bool {
        self.do(
            onSubscribe: { relay.accept(true) },
            onDispose: { relay.accept(false) }
        )
    }
}

public extension PrimitiveSequence where Trait == SingleTrait {
    func trackState<R: RelayType>(
        using relay: R
    ) -> Single<Element> where R.Element == Bool {
        self.do(
            onSubscribe: { relay.accept(true) },
            onDispose: { relay.accept(false) }
        )
    }

    func trackState(
        using relay: BehaviorRelay<Int>
    ) -> Single<Element> {
        self.do(
            onSubscribe: { relay.accept(relay.value + 1) },
            onDispose: { relay.accept(relay.value - 1) }
        )
    }
}

public extension Completable {
    func trackState<R: RelayType>(
        using relay: R
    ) -> Completable where R.Element == Bool {
        self.do(
            onSubscribe: { relay.accept(true) },
            onDispose: { relay.accept(false) }
        )
    }

    func trackState(
        using relay: BehaviorRelay<Int>
    ) -> Completable {
        self.do(
            onSubscribe: { relay.accept(relay.value + 1) },
            onDispose: { relay.accept(relay.value - 1) }
        )
    }
}
