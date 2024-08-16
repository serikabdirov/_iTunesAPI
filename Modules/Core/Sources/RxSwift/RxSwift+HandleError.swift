//
//  RxSwift+HandleError.swift
//
//  Created by Денис Кожухарь on 30.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxRelay
import RxSwift

public extension ObservableType {
    func handleError<R: RelayType>(
        using relay: R
    ) -> Observable<Element> where R.Element == Error {
        self.do(
            onError: { relay.accept($0) }
        )
    }

    func handleError<R: RelayType>(
        using relay: R
    ) -> Observable<Element> where R.Element == String {
        self.do(
            onError: { relay.accept($0.localizedDescription) }
        )
    }
}

public extension PrimitiveSequence where Trait == SingleTrait {
    func handleError<R: RelayType>(
        using relay: R
    ) -> Single<Element> where R.Element == Error {
        self.do(
            onError: { relay.accept($0) }
        )
    }

    func handleError<R: RelayType>(
        using relay: R
    ) -> Single<Element> where R.Element == String {
        self.do(
            onError: { relay.accept($0.localizedDescription) }
        )
    }

    func subscribe<R: RelayType>(
        errorHandler: R,
        onSuccess: ((Element) -> Void)? = nil,
        onDisposed: (() -> Void)? = nil
    ) -> Disposable where R.Element == Error {
        subscribe(
            onSuccess: onSuccess,
            onFailure: { errorHandler.accept($0) },
            onDisposed: onDisposed
        )
    }

    func subscribe<R: RelayType>(
        errorHandler: R,
        onSuccess: ((Element) -> Void)? = nil,
        onDisposed: (() -> Void)? = nil
    ) -> Disposable where R.Element == String {
        subscribe(
            onSuccess: onSuccess,
            onFailure: { errorHandler.accept($0.localizedDescription) },
            onDisposed: onDisposed
        )
    }

    func translateError<T: ErrorTranslator>(using translator: T) -> Self {
        self.catch { [translator] in throw translator.translate(from: $0) }
    }
}

public extension Completable {
    func handleError<R: RelayType>(
        using relay: R
    ) -> Completable where R.Element == Error {
        self.do(
            onError: { relay.accept($0) }
        )
    }

    func handleError<R: RelayType>(
        using relay: R
    ) -> Completable where R.Element == String {
        self.do(
            onError: { relay.accept($0.localizedDescription) }
        )
    }
}
