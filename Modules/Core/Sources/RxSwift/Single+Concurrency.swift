//
//  Single+Concurrency.swift
//
//  Created by Денис Кожухарь on 30.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation
import RxSwift

public extension PrimitiveSequenceType where Trait == SingleTrait {
    /// Create single that emit value from async throws function.
    ///
    /// - Parameter handler:  A async throws function.
    /// - Returns: The observable sequence with the specified implementation for the subscribe method
    static func async(_ handler: @escaping () async throws -> Element) -> Single<Element> {
        Single.create { single in
            let task = Task {
                do {
                    single(.success(try await handler()))
                } catch {
                    single(.failure(error))
                }
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
